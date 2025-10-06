import std.algorithm : each;
import std.conv : to;
import std.exception : enforce;
import std.format : format;
import std.stdio : File;
import std.base64 : Base64;
static import std.digest.sha;

string computeIntegrityHash(uint length)(string filePath)
{
    return computeIntegrityHash!length(File(filePath, "rb"));
}

string computeIntegrityHash(uint length)(File file)
{
    static if (length == 160)
        alias SHA = std.digest.sha.SHA1;
    else static if (length == 224)
        alias SHA = std.digest.sha.SHA224;
    else static if (length == 256)
        alias SHA = std.digest.sha.SHA256;
    else static if (length == 384)
        alias SHA = std.digest.sha.SHA384;
    else static if (length == 512)
        alias SHA = std.digest.sha.SHA512;
    else
        static assert(false, "length must be one of 160, 224, 256, 384, or 512");
    SHA sha;
    enforce(file.isOpen, "Failed to open file %s for reading.".format(file.name));
    file.seek(0);
    file.byChunk(1024 * 1024).each!(chunk => sha.put(chunk));
    return format!"sha%s-%s"(length, Base64.encode(sha.finish).to!string);
}
