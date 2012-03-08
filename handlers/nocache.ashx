<%@ WebHandler Language="C#" Class="nocache" %>

using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Web;
using System.Web.Script.Serialization;

public class nocache : IHttpHandler
{
    public void ProcessRequest (HttpContext context) {        
        context.Response.Cache.SetCacheability(HttpCacheability.NoCache);

        string source = File.ReadAllText(context.Request.PhysicalApplicationPath + "js/source.js");
        context.Response.ContentType = "text/javascript";
        context.Response.Write(string.Format(source, "Cache-Control: no-cache", ResponseHelper.GetHeaderData(context) ));        
    }    

    public bool IsReusable {
        get {
            return false;
        }
    }

}