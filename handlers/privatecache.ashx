<%@ WebHandler Language="C#" Class="privatecache" %>

using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Web;
using System.Web.Script.Serialization;

public class privatecache : IHttpHandler
{
    public void ProcessRequest (HttpContext context) {
        TimeSpan refresh = new TimeSpan(0, 0, 15);
        HttpContext.Current.Response.Cache.SetMaxAge(refresh);
        context.Response.Cache.SetCacheability(HttpCacheability.Private);
        
        context.Response.ContentType = "text/javascript";
        string source = File.ReadAllText(context.Request.PhysicalApplicationPath + "js/source.js");
        context.Response.Write(string.Format(source, "Cache-Control: Private", ResponseHelper.GetHeaderData(context) ));
    }
        
    public bool IsReusable {
        get {
            return false;
        }
    }

}