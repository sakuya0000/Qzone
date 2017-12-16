<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using System.Collections;
using System.Web.Script.Serialization;

public class Handler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        string Roman = context.Request.Form["Roman"].ToString();
        ArrayList eventList = new ArrayList();
        Hashtable ht = new Hashtable();
        bool flag = true;
        for(int i = 0; i < Roman.Length; i++)
        {
            if (Roman[i] != 'I' && Roman[i] != 'V' && Roman[i] != 'X' && Roman[i] != 'L' && Roman[i] != 'C' && Roman[i] != 'D' && Roman[i] != 'M')
            {
                flag = false;
                ht.Add("eventNum", 0);
                break;
            }
        }
        if (flag==true)
        {
            ht.Add("eventNum", RomanToInt(Roman));
        }
        eventList.Add(ht);
        JavaScriptSerializer ser = new JavaScriptSerializer();
        string jsonStr = ser.Serialize(eventList);
        context.Response.ContentType = "text/plain";
        context.Response.Write(jsonStr);
    }

    public int RomanToInt(string Roman)
    {
        int sum = 0;
        for(int i = 0; i < Roman.Length - 1; i++)
        {
            if (romanValues(Roman[i]) >= romanValues(Roman[i + 1]))
                sum += romanValues(Roman[i]);
            else
                sum -= romanValues(Roman[i]);
        }
        sum += romanValues(Roman[Roman.Length - 1]);
        return sum;
    }
    public int romanValues(char roman)
    {
        switch (roman) {
            case 'I': return 1;
            case 'V':return 5;
            case 'X':return 10;
            case 'L':return 50;
            case 'C':return 100;
            case 'D':return 500;
            case 'M':return 1000;
            default:return 0;
        }
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}