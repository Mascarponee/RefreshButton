using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

/// <summary>
/// Summary description for ResponseHelper
/// </summary>
public static class ResponseHelper
{
    private static string[] _filterHeaders = new string[] { "Accept", "Accept-Charset", "Accept-Encoding", "Accept-Language", "Host", "Referer", "User-Agent", "Connection" };
    private static int _version = 0;
    private static object sync = new object();

    public static void SetVersionHeader(HttpContext context)
    {
        lock (sync)
        {
            context.Response.AddHeader("Version", _version.ToString());
            _version++;
        }
    }
    
    public static string GetHeaderData(HttpContext context)
	{
        Dictionary<string, string> headersDictionary = GetHeadersDictionary(context);
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        return serializer.Serialize(headersDictionary);
	}

    private static Dictionary<string, string> GetHeadersDictionary(HttpContext context)
    {
        var headersDictionary = new Dictionary<string, string>();
        NameValueCollection headers = context.Request.Headers;
        foreach (string key in headers.Keys)
        {
            if (!_filterHeaders.Contains(key))
            {
                headersDictionary.Add(key, headers[key]);
            }
        }
        lock (sync)
        {
            headersDictionary.Add("Version", _version.ToString());
            _version++;
        }
        return headersDictionary;
    }
}