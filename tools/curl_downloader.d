// Small wrapper over curl C-API as std.net.curl seems to be broken

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
    string get(string url, string githubToken = "")
    {
        Buffer buffer;
        curl_slist* headers = setHeaders(githubToken);
        scope (exit)
        {
            curl_slist_free_all(headers);
        }
        setOptions(url, headers, &get_callback, &buffer);

        auto result = curl_easy_perform(curl);
        enforce(result == CurlError.ok, new CurlException(
                "curl_easy_perform failed: %s".format(curl_easy_strerror(result))));
        return cast(string)(buffer.data);
    }

    void downloadToFile(string url, string filePath, string githubToken = "")
    {
        auto file = File(filePath, "wb");
        enforce(file.isOpen, "Failed to open file %s for writing.".format(
                filePath));
        curl_slist* headers = setHeaders(githubToken);
        scope (exit)
        {
            curl_slist_free_all(headers);
        }
        setOptions(url, headers, &download_callback, &file);

        auto result = curl_easy_perform(curl);
        enforce(result == CurlError.ok, new CurlException(
                "curl_easy_perform failed: %s".format(curl_easy_strerror(result))));
    }

private:
    static CURL* curl;
    static this()
    {
        curl_global_init(CurlGlobal.default_);
        curl = curl_easy_init();
        enforce(curl, new CurlException("Failed to initialize curl."));
    }

    static ~this()
    {
        curl_easy_cleanup(curl);
        curl_global_cleanup();
    }

    struct Buffer
    {
        ubyte[] data;
    }

    curl_slist* setHeaders(string githubToken)
    {
        curl_slist* headers;
        if (!githubToken.empty)
        {
            headers = curl_slist_append(headers, ("Authorization:Bearer " ~ githubToken).toStringz);
            headers = curl_slist_append(headers, "Accept: application/vnd.github+json".toStringz);
            headers = curl_slist_append(headers, "X-GitHub-Api-Version: 2022-11-28".toStringz);
        }
        headers = curl_slist_append(headers, "User-Agent: dlang-etc.c.curl".toStringz);
        return headers;
    }

    void setOptions(string url, curl_slist* headers, void* callback, void* callbackData)
    {
        curl_easy_setopt(curl, CurlOption.url, url.toStringz);
        curl_easy_setopt(curl, CurlOption.httpheader, headers);
        curl_easy_setopt(curl, CurlOption.writefunction, callback);
        curl_easy_setopt(curl, CurlOption.writedata, callbackData);
        curl_easy_setopt(curl, CurlOption.followlocation, 1); // follow redirects
        curl_easy_setopt(curl, CurlOption.maxredirs, 5); // maximum redirects to follow
    }

    extern (C) static size_t get_callback(void* content, size_t size, size_t nmemb, void* bufferPtr)
    {
        auto contentSize = size * nmemb;
        auto buffer = cast(Buffer*) bufferPtr;
        buffer.data ~= (cast(
                const(ubyte)*) content)[0 .. contentSize];
        return contentSize;
    }

    extern (C) static size_t download_callback(void* content, size_t size, size_t nmemb, void* filePtr)
    {
        auto contentSize = size * nmemb;
        auto file = cast(File*) filePtr;
        file.rawWrite(
            (cast(const(ubyte)*) content)[0 .. contentSize]);
        return contentSize;
    }
}
