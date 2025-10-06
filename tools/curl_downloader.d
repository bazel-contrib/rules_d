// Small wrapper over curl C-API as std.net.curl seems to be broken

import std.algorithm : each;
import etc.c.curl;
import std.exception : enforce;
import std.format : format;
import std.range : empty;
import std.stdio : File;
import std.string : toStringz;

class CurlException : Exception
{
    this(string msg)
    {
        super(msg);
    }
}

struct CurlDownloader
{
    ubyte[] get(string url, string githubToken = "")
    {
        Buffer buffer;
        curl_slist* headers = setHeaders(githubToken);
        CURL* curl = curl_easy_init();
        enforce(curl, new CurlException("Failed to initialize curl."));
        scope (exit)
        {
            curl_slist_free_all(headers);
            curl_easy_cleanup(curl);
        }
        setOptions(curl, url, headers, &get_callback, &buffer);

        auto result = curl_easy_perform(curl);
        enforce(result == CurlError.ok, new CurlException(
                "curl_easy_perform failed: %s".format(curl_easy_strerror(result))));
        return buffer.data;
    }

    void downloadToFile(string url, string filePath, string githubToken = "")
    {
        downloadToFile(url, File(filePath, "wb+"), githubToken);
    }

    void downloadToFile(string url, File file, string githubToken = "")
    {
        enforce(file.isOpen, "Failed to open file %s for writing.".format(file.name));

        CURL* curl = curl_easy_init();
        enforce(curl, new CurlException("Failed to initialize curl."));
        curl_slist* headers = setHeaders(githubToken);
        scope (exit)
        {
            curl_slist_free_all(headers);
            curl_easy_cleanup(curl);
        }
        setOptions(curl, url, headers, &download_callback, &file);

        auto result = curl_easy_perform(curl);
        enforce(result == CurlError.ok, new CurlException(
                "curl_easy_perform failed: %s".format(curl_easy_strerror(result))));
    }

private:
    static this()
    {
        curl_global_init(CurlGlobal.default_);
    }

    static ~this()
    {
        curl_global_cleanup();
    }

    struct Buffer
    {
        ubyte[] data;
    }

    curl_slist* setHeaders(string githubToken)
    {
        string[] headers;
        if (!githubToken.empty)
        {
            headers ~= "Authorization: Bearer " ~ githubToken;
            headers ~= "Accept: application/vnd.github+json";
            headers ~= "X-GitHub-Api-Version: 2022-11-28";
        }
        headers ~= "User-Agent: dlang-etc.c.curl";
        curl_slist* curl_headers = null;
        headers.each!(h => curl_headers = curl_slist_append(curl_headers, h.toStringz));
        return curl_headers;
    }

    void setOptions(CURL* curl, string url, curl_slist* headers, void* callback, void* callbackData)
    {
        curl_easy_setopt(curl, CurlOption.url, url.toStringz);
        curl_easy_setopt(curl, CurlOption.httpheader, headers);
        curl_easy_setopt(curl, CurlOption.writefunction, callback);
        curl_easy_setopt(curl, CurlOption.writedata, callbackData);
        curl_easy_setopt(curl, CurlOption.followlocation, 1L); // follow redirects
        curl_easy_setopt(curl, CurlOption.maxredirs, 5L); // maximum redirects to follow
        curl_easy_setopt(curl, CurlOption.connecttimeout, 10L); // 10 seconds connection timeout
        curl_easy_setopt(curl, CurlOption.timeout, 600L); // 10 minutes
        curl_easy_setopt(curl, CurlOption.failonerror, 1L); // fail on HTTP errors
    }

    extern (C) static size_t get_callback(void* content, size_t size, size_t nmemb, void* bufferPtr)
    {
        auto contentSize = size * nmemb;
        auto buffer = cast(Buffer*) bufferPtr;
        buffer.data ~= (cast(const(ubyte)*) content)[0 .. contentSize];
        return contentSize;
    }

    extern (C) static size_t download_callback(void* content, size_t size, size_t nmemb, void* filePtr)
    {
        auto contentSize = size * nmemb;
        auto file = cast(File*) filePtr;
        file.rawWrite((cast(const(ubyte)*) content)[0 .. contentSize]);
        return contentSize;
    }
}
