using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class JournalList : System.Web.UI.Page
{
    static SQLHelper us = new SQLHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string VisitingQQNum = Session["VisitingQQNum"].ToString();
            string QQNum = Session["QQNum"].ToString();
            if (VisitingQQNum == QQNum)
                btn_Wirte.Visible = true;
            else
                btn_Wirte.Visible = false;
            if (Session["QQNum"] == null || Session["VisitingQQNum"] == null)
                Response.Redirect("../Login.aspx");
            if (Session["NowPage"] == null)
                DataBindTorpt_Journal(1);
            else
            {
                DataBindTorpt_Journal(Convert.ToInt32(Session["NowPage"].ToString()));
                NowPage.Text = Session["NowPage"].ToString();
                Session["NowPage"] = null;
            }
        }
    }
    protected void btn_Wirte_Click(object sender, EventArgs e)
    {
        Response.Redirect("JournalEdit.aspx");
    }
    protected void rpt_Journal_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "GetIn")
        {
            string JournalID = e.CommandArgument.ToString();
            Response.Redirect("Journal.aspx?ID=" + JournalID + "");
        }
        else if (e.CommandName == "Del")
        {
            int JournalID =Convert.ToInt32(e.CommandArgument.ToString());
            string sql = "DELETE FROM Journal WHERE JournalID='" + JournalID + "'";
            us.SQL(sql);
            sql = "DELETE FROM Journal_Com WHERE JournalID='" + JournalID + "'";
            us.SQL(sql);
            sql = "DELETE FROM New_Events WHERE EventID='" + JournalID + "'AND EventType='1'";
            us.SQL(sql);
            Response.Redirect("JournalList.aspx");
        }
    }
    protected void DataBindTorpt_Journal(int current)
    {
        Session["NowPage"] = current;
        string VisitingQQNum = Session["VisitingQQNum"].ToString();
        string sql = "SELECT * FROM Journal WHERE QQNum='" + VisitingQQNum + "'";
        DataTable dt = us.SQL_dt(sql);
        PagedDataSource pds = new PagedDataSource();
        pds.AllowPaging = true;
        pds.PageSize = 5;
        pds.DataSource = dt.DefaultView;
        TotalPage.Text = pds.PageCount.ToString();
        pds.CurrentPageIndex = current - 1;
        rpt_Journal.DataSource = pds;
        rpt_Journal.DataBind();
    }

    protected void btnFirstPage_Click(object sender, EventArgs e)  //首页
    {
        int current = 1;
        NowPage.Text = current.ToString();
        DataBindTorpt_Journal(current);
    }

    protected void btnUpPage_Click(object sender, EventArgs e)  //上一页
    {
        int current = Convert.ToInt32(NowPage.Text) - 1;
        if (current >= 1)
        {
            NowPage.Text = current.ToString();
            DataBindTorpt_Journal(current);
        }
    }

    protected void btnDownPage_Click(object sender, EventArgs e)  //下一页
    {
        int current = Convert.ToInt32(NowPage.Text);
        current++;
        if (current <= Convert.ToInt32(TotalPage.Text))
        {
            NowPage.Text = current.ToString();
            DataBindTorpt_Journal(current);
        }
    }

    protected void btnLastPage_Click(object sender, EventArgs e)
    {
        int current = Convert.ToInt32(TotalPage.Text);
        NowPage.Text = current.ToString();
        DataBindTorpt_Journal(current);
    }

    protected void btnJump_Click(object sender, EventArgs e)
    {
        try
        {
            int current = Convert.ToInt32(txtJumpPage.Text);
            if (current >= 1 && current <= Convert.ToInt32(TotalPage.Text))
            {
                NowPage.Text = current.ToString();
                DataBindTorpt_Journal(current);
            }
            else
                Response.Write("<script>alert('请输入正确的数字！')</script>");
        }
        catch
        {
            Response.Write("<script>alert('请输入数字！')</script>");
        }
    }

    protected void rpt_Journal_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        LinkButton Del = (LinkButton)e.Item.FindControl("btn_Del");
        string VisitingQQNum = Session["VisitingQQNum"].ToString();
        string QQNum = Session["QQNum"].ToString();
        if (VisitingQQNum == QQNum)
            Del.Visible = true;
        else
            Del.Visible = false;
    }
}