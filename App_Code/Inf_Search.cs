using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Inf_Search 的摘要说明
/// </summary>
public class Inf_Search
{
    public Inf_Search()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
    public string Find_Constellation(string Birthday)  //获取星座
    {
        string[] num = Birthday.Split('-');
        int Month = Convert.ToInt32(num[1]);
        int Day = Convert.ToInt32(num[2]);
        if (Month == 1)
        {
            if (Day <= 19)
                return "摩羯座";
            else
                return "水瓶座";
        }
        else if (Month == 2)
        {
            if (Day <= 18)
                return "水瓶座";
            else
                return "双鱼座";
        }
        else if (Month == 3)
        {
            if (Day <= 20)
                return "双鱼座";
            else
                return "白羊座";
        }
        else if (Month == 4)
        {
            if (Day <= 19)
                return "白羊座";
            else
                return "金牛座";
        }
        else if (Month == 5)
        {
            if (Day <= 20)
                return "金牛座";
            else
                return "双子座";
        }
        else if(Month ==6)
        {
            if (Day <= 21)
                return "双子座";
            else
                return "巨蟹座";
        }
        else if(Month ==7)
        {
            if (Day <= 22)
                return "巨蟹座";
            else
                return "狮子座";
        }
        else if (Month == 8)
        {
            if (Day <= 22)
                return "狮子座";
            else
                return "处女座";
        }
        else if(Month == 9)
        {
            if (Day <= 22)
                return "处女座";
            else
                return "天枰座";
        }
        else if (Month == 10)
        {
            if (Day <= 23)
                return "天枰座";
            else
                return "天蝎座";
        }
        else if (Month == 11)
        {
            if (Day <= 22)
                return "天蝎座";
            else
                return "射手座";
        }
        else
        {
            if (Day <= 22)
                return "射手座";
            else
                return "摩羯座";
        }
    }
    public int Find_Age(string Birthday)  //获取年龄
    {
        string[] num = Birthday.Split('-');
        int BirthYear = Convert.ToInt16(num[0]);
        int NowYear = Convert.ToInt16(DateTime.Now.Year.ToString());
        return NowYear - BirthYear;
    }
}