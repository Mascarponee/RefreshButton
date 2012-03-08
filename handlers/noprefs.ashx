<%@ WebHandler Language="C#" Class="noprefs" %>

using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Web;
using System.Web.Script.Serialization;

public class noprefs : IHttpHandler
{
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/javascript";
        string source = File.ReadAllText(context.Request.PhysicalApplicationPath + "js/source.js");
        context.Response.Write(string.Format(source, "Simple .js resource without any cache-specific headers", ResponseHelper.GetHeaderData(context) ));        
    }    

    public bool IsReusable {
        get {
            return false;
        }
    }

}