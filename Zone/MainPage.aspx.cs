﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MainPage : System.Web.UI.Page
{
    static SQLHelper us = new SQLHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["QQNum"] == null || Session["VisitingQQNum"] == null)
                Response.Redirect("Login.aspx");
            string VisitingQQNum = Session["VisitingQQNum"].ToString();
            string QQNum = Session["QQNum"].ToString();
            if (VisitingQQNum != QQNum)
            {

            }
            DataBindTorpt_MyNewEvents(1);
        }
    }
    protected void DataBindTorpt_MyNewEvents(int current)
    {
        string VisitingQQNum = Session["VisitingQQNum"].ToString();
        string sql = "SELECT * FROM New_Events WHERE QQNum='" + VisitingQQNum + "'";
        DataTable dt = us.SQL_dt(sql);
        DataColumn dc = null;
        dc = dt.Columns.Add("UserName", Type.GetType("System.String"));
        sql = "SELECT UserName FROM Users WHERE QQNum='" + VisitingQQNum + "'";
        DataTable t = us.SQL_dt(sql);
        string UserName = t.Rows[0][0].ToString();
        for(int i = 0; i < dt.Rows.Count; i++)
        {
            dt.Rows[i][7] = UserName;
        }
        dc = dt.Columns.Add("Message", Type.GetType("System.String"));
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i][1].ToString() == "1")
                dt.Rows[i][8] = "发表了一篇日志";
            else if (dt.Rows[i][1].ToString() == "2")
                dt.Rows[i][8] = "发表了一篇说说";
            else if (dt.Rows[i][1].ToString() == "3")
                dt.Rows[i][8] = "上传了图片";
        }
        if (dt.Rows.Count == 0)
            div_Page.Visible = false;
        dt.DefaultView.Sort = "Time DESC";
        PagedDataSource pds = new PagedDataSource();
        pds.AllowPaging = true;
        pds.PageSize = 10;
        pds.DataSource = dt.DefaultView;
        TotalPage.Text = pds.PageCount.ToString();
        pds.CurrentPageIndex = current - 1;
        rpt_MyNewEvents.DataSource = pds;
        rpt_MyNewEvents.DataBind();
    }
    protected void btnFirstPage_Click(object sender, EventArgs e)  //首页
    {
        int current = 1;
        NowPage.Text = current.ToString();
        DataBindTorpt_MyNewEvents(current);
    }

    protected void btnUpPage_Click(object sender, EventArgs e)  //上一页
    {
        int current = Convert.ToInt32(NowPage.Text) - 1;
        if (current >= 1)
        {
            NowPage.Text = current.ToString();
            DataBindTorpt_MyNewEvents(current);
        }
    }

    protected void btnDownPage_Click(object sender, EventArgs e)  //下一页
    {
        int current = Convert.ToInt32(NowPage.Text);
        current++;
        if (current <= Convert.ToInt32(TotalPage.Text))
        {
            NowPage.Text = current.ToString();
            DataBindTorpt_MyNewEvents(current);
        }
    }

    protected void btnLastPage_Click(object sender, EventArgs e)  //尾页
    {
        int current = Convert.ToInt32(TotalPage.Text);
        NowPage.Text = current.ToString();
        DataBindTorpt_MyNewEvents(current);
    }

    protected void btnJump_Click(object sender, EventArgs e)  //跳页
    {
        try
        {
            int current = Convert.ToInt32(txtJumpPage.Text);
            if (current >= 1 && current <= Convert.ToInt32(TotalPage.Text))
            {
                NowPage.Text = current.ToString();
                DataBindTorpt_MyNewEvents(current);
            }
            else
                Response.Write("<script>alert('请输入正确的数字！')</script>");
        }
        catch
        {
            Response.Write("<script>alert('请输入数字！')</script>");
        }
    }

    protected void rpt_MyNewEvents_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "Read")
        {
            string[] temp = e.CommandArgument.ToString().Split(',');
            string EventType = temp[0];
            string VisitingQQNum = Session["VisitingQQNum"].ToString();
            if (EventType == "1")
            {
                int JournalID = Convert.ToInt32(temp[1]);
                Response.Redirect("/Zone/Journal/Journal.aspx?ID=" + JournalID + "");
            }
            else if (EventType == "2")
            {
                Response.Redirect("/Zone/SaySay/SaySayList.aspx");
            }
            else if (EventType == "3")
            {
                Image Pic = (Image)e.Item.FindControl("Ima1");
                string[] t = Pic.ImageUrl.Split('/');
                string Path = t[3] + "/";
                Session["FileName"] = Path;
                Response.Redirect("/Zone/Album/Album.aspx");
            }
        }
    }
}