using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    static SQLHelper us = new SQLHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["VisitingQQNum"] != null)
            {
                string sql = "SELECT UserName FROM Users WHERE QQNum='" + Session["VisitingQQNum"].ToString() + "'";
                DataTable dt = us.SQL_dt(sql);
                Lab_Name.Text = dt.Rows[0][0].ToString();
                string VisitingQQNum = Session["VisitingQQNum"].ToString();
                string QQNum = Session["QQNum"].ToString();
                if (VisitingQQNum == QQNum)
                {
                    Btn_Friend.Visible = true;
                }
                else
                    Btn_Friend.Visible = false;
            }
            else
                Response.Redirect("/Zone/Login.aspx");
        }
    }

    protected void Btn_MyMainPage_Click(object sender, EventArgs e)
    {
        Response.Redirect("/Zone/MainPage.aspx");
    }

    protected void Btn_Journal_Click(object sender, EventArgs e)  //跳到日志
    {
        Response.Redirect("/Zone/Journal/JournalList.aspx");
    }

    protected void Btn_Album_Click(object sender, EventArgs e)  //相册
    {
        Response.Redirect("/Zone/Album/FileList.aspx");
    }

    protected void Btn_SaySay_Click(object sender, EventArgs e)  //说说
    {
        Response.Redirect("/Zone/SaySay/SaySayList.aspx");
    }

    protected void Btn_MainInf_Click(object sender, EventArgs e)  //个人档
    {
        Response.Redirect("/Zone/MainInf.aspx");
    }
    

    protected void Btn_Message_Board_Click(object sender, EventArgs e)  //留言板
    {
        Response.Redirect("/Zone/Message_Board/Message_Board.aspx");
    }

    protected void Btn_Back_Click(object sender, EventArgs e)  //返回个人中心
    {
        Session["VisitingQQNum"] = Session["QQNum"].ToString();
        Response.Redirect("/Zone/FirstPage.aspx");
    }

    protected void Btn_Close_Click(object sender, EventArgs e)  //注销
    {
        Session["QQNum"] = null;
        Session["VisitingQQNum"] = null;
        Response.Redirect("/Zone/Login.aspx");
    }

    protected void Btn_Friend_Click(object sender, EventArgs e)  //好友
    {
        Response.Redirect("/Zone/Friend/Friend.aspx");
    }
}
