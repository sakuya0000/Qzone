using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Zone_FirstPage : System.Web.UI.Page
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
                Response.Redirect("MainPage.aspx");
            DataBindTorpt_NewEvents(1);
        }
    }
    protected void DataBindTorpt_NewEvents(int current)
    {
        string QQNum = Session["QQNum"].ToString();
        string sql = "SELECT FriendQQNum FROM QQFriends WHERE QQNum='" + QQNum + "'";
        DataTable dt = us.SQL_dt(sql);
        sql = "SELECT * FROM New_Events WHERE QQNum='" + QQNum + "' ORDER BY Time DESC";
        DataTable table = us.SQL_dt(sql);
        for(int i = 0; i < dt.Rows.Count; i++)
        {
            sql = "SELECT * FROM New_Events WHERE QQNum='" + dt.Rows[i][0].ToString() + "'";
            DataTable temp = us.SQL_dt(sql);
            for (int j = 0; j < temp.Rows.Count; j++)
                table.Rows.Add(new object[] {temp.Rows[j][0], temp.Rows[j][1], temp.Rows[j][2], temp.Rows[j][3], temp.Rows[j][4], temp.Rows[j][5], temp.Rows[j][6] });
        }
        DataColumn dc = null;
        dc = table.Columns.Add("Message", Type.GetType("System.String"));
        for (int i = 0; i < table.Rows.Count; i++)
        {
            if (table.Rows[i][1].ToString() == "1")
                table.Rows[i][7] = "发表了一篇日志";
            else if (table.Rows[i][1].ToString() == "2")
                table.Rows[i][7] = "发表了一篇说说";
            else if (table.Rows[i][1].ToString() == "3")
                table.Rows[i][7] = "上传了图片";
        }
        dc = table.Columns.Add("UserName", Type.GetType("System.String"));
        for(int i = 0; i < table.Rows.Count; i++)
        {
            sql = "SELECT UserName FROM Users WHERE QQNum='" + table.Rows[i][5].ToString() + "'";
            dt = us.SQL_dt(sql);
            table.Rows[i][8] = dt.Rows[0][0];
        }
        if (dt.Rows.Count == 0)
            div_Page.Visible = false;
        table.DefaultView.Sort = "Time DESC";
        PagedDataSource pds = new PagedDataSource();
        pds.AllowPaging = true;
        pds.PageSize = 10;
        pds.DataSource = table.DefaultView;
        TotalPage.Text = pds.PageCount.ToString();
        pds.CurrentPageIndex = current - 1;
        rpt_NewEvents.DataSource = pds;
        rpt_NewEvents.DataBind();
    }
    protected void btnFirstPage_Click(object sender, EventArgs e)  //首页
    {
        int current = 1;
        NowPage.Text = current.ToString();
        DataBindTorpt_NewEvents(current);
    }

    protected void btnUpPage_Click(object sender, EventArgs e)  //上一页
    {
        int current = Convert.ToInt32(NowPage.Text) - 1;
        if (current >= 1)
        {
            NowPage.Text = current.ToString();
            DataBindTorpt_NewEvents(current);
        }
    }

    protected void btnDownPage_Click(object sender, EventArgs e)  //下一页
    {
        int current = Convert.ToInt32(NowPage.Text);
        current++;
        if (current <= Convert.ToInt32(TotalPage.Text))
        {
            NowPage.Text = current.ToString();
            DataBindTorpt_NewEvents(current);
        }
    }

    protected void btnLastPage_Click(object sender, EventArgs e)  //尾页
    {
        int current = Convert.ToInt32(TotalPage.Text);
        NowPage.Text = current.ToString();
        DataBindTorpt_NewEvents(current);
    }

    protected void btnJump_Click(object sender, EventArgs e)  //跳页
    {
        try
        {
            int current = Convert.ToInt32(txtJumpPage.Text);
            if (current >= 1 && current <= Convert.ToInt32(TotalPage.Text))
            {
                NowPage.Text = current.ToString();
                DataBindTorpt_NewEvents(current);
            }
            else
                Response.Write("<script>alert('请输入正确的数字！')</script>");
        }
        catch
        {
            Response.Write("<script>alert('请输入数字！')</script>");
        }
    }
    protected void rpt_NewEvents_ItemCommand(object source, RepeaterCommandEventArgs e)  //点击事件
    {
        if (e.CommandName == "Read")
        {
            string[] temp = e.CommandArgument.ToString().Split(',');
            string EventType = temp[0];
            string QQNum = temp[2];
            if (EventType == "1")
            {
                Session["VisitingQQNum"] = QQNum;
                int JournalID = Convert.ToInt32(temp[1]);
                Response.Redirect("/Zone/Journal/Journal.aspx?ID=" + JournalID + "");
            }
            else if (EventType == "2")
            {
                Session["VisitingQQNum"] = QQNum;
                Response.Redirect("/Zone/SaySay/SaySayList.aspx");
            }
            else if (EventType == "3")
            {
                Session["VisitingQQNum"] = QQNum;
                Image Pic = (Image)e.Item.FindControl("Ima1");
                string[] t = Pic.ImageUrl.Split('/');
                string Path = t[3] + "/";
                Session["FileName"] = Path;
                Response.Redirect("/Zone/Album/Album.aspx");
            }
        }
        else if(e.CommandName== "GetIn")
        {
            string VisitingQQNum = e.CommandArgument.ToString();
            Session["VisitingQQNum"] = VisitingQQNum;
            Response.Redirect("MainPage.aspx");
        }
    }
}