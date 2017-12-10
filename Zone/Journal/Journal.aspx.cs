using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Zone_Journal : System.Web.UI.Page
{
    static SQLHelper us = new SQLHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            if (Session["QQNum"] == null || Session["VisitingQQNum"] == null)
                Response.Redirect("../Login.aspx");
            string JournalID = Request.QueryString["ID"];
            if (JournalID == null)
                Response.Redirect("JournalList.aspx");
            string VisitingQQNum = Session["VisitingQQNum"].ToString();
            string QQNum = Session["QQNum"].ToString();
            if (VisitingQQNum == QQNum)
                btn_JournalEdit.Visible = true;
            else
                btn_JournalEdit.Visible = false;
            string sql = "SELECT * FROM Journal WHERE JournalID='" +Convert.ToInt32(JournalID) + "'";
            DataTable dt = us.SQL_dt(sql);
            Lab_JournalTitle.Text = dt.Rows[0][3].ToString();
            Lab_JournalDate.Text = dt.Rows[0][2].ToString();
            Lab_JournalSubstance.Text = dt.Rows[0][4].ToString();
            DataBindTorpt_Comment(1);
        }
    }

    protected void btn_JournalEdit_Click(object sender, EventArgs e)  //跳到编辑页
    {
        Session["JournalID"]= Request.QueryString["ID"];
        Response.Redirect("JournalEdit.aspx");
    }

    protected void rpt_Comment_ItemDataBound(object sender, RepeaterItemEventArgs e)  //绑定第二层repeater数据
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            LinkButton Del = (LinkButton)e.Item.FindControl("btn_CommentDelete");
            if (Session["QQNum"] == Session["VisitingQQNum"])
                Del.Visible = true;
            else
                Del.Visible = false;
            string JournalID = Request.QueryString["ID"];
            Repeater rep = e.Item.FindControl("rpt_Response") as Repeater;
            Label ID = e.Item.FindControl("Lab_CommentID") as Label;
            string CommentID = ID.Text;
            string sql = "SELECT * FROM Journal_Com WHERE JournalID='" + JournalID + "' AND ResponseTo ='" + CommentID + "' ORDER BY Date DESC";
            DataTable dt = us.SQL_dt(sql);
            rep.DataSource = dt;
            rep.DataBind();
        }
    }

    protected void rpt_Comment_ItemCommand(object source, RepeaterCommandEventArgs e)    //第一层repeater点击事件
    {
        if(e.CommandName== "DeleteComment")
        {
            string Journal_ComID = e.CommandArgument.ToString();
            string sql = "DELETE FROM Journal_Com WHERE Journal_ComID='" + Journal_ComID + "'";
            us.SQL(sql);
            sql = "DELETE FROM Journal_Com WHERE ResponseTo='" + Journal_ComID + "'";
            us.SQL(sql);
            Response.Write("<script>alert('删除成功！')</script>");
        }
        else if(e.CommandName== "GetIn_Comment")
        {
            string VisitingQQNum = e.CommandArgument.ToString();
            Session["VisitingQQNum"] = VisitingQQNum;
            Response.Redirect("../MainPage.aspx");
        }
        else if(e.CommandName== "Write")
        {
            string[] temp = e.CommandArgument.ToString().Split(',');
            int JournalID =Convert.ToInt32(temp[0]);
            int ResponseTo = Convert.ToInt32(temp[1]);
            string Time= DateTime.Now.ToString();
            TextBox Substance = (TextBox)e.Item.FindControl("txt_Com");
            string QQNum = Session["QQNum"].ToString();
            string sql = "SELECT UserName FROM Users WHERE QQNum='" + QQNum + "'";
            DataTable dt = us.SQL_dt(sql);
            string VisitorName = dt.Rows[0][0].ToString();
            //sql = "INSERT INTO Journal_Com(JournalID,QQNum,VisitorName,Date,Substance,ResponseTo) VALUES('" + JournalID + "','" + QQNum + "','" + VisitorName + "','" + Time + "','" + Substance.Text + "','" + ResponseTo + "')";
            //us.SQL(sql);
            SqlConnection connection = new SqlConnection("server=DESKTOP-KH8JE5M;Integrated Security=SSPI;database=QZone;");
            connection.Open();
            SqlCommand cmd = new SqlCommand("INSERT INTO Journal_Com(JournalID,QQNum,VisitorName,Date,Substance,ResponseTo) VALUES('" + JournalID + "','" + QQNum + "','" + VisitorName + "','" + Time + "',@Substance,'" + ResponseTo + "')",connection);
            cmd.Parameters.AddWithValue("@Substance", Substance.Text);
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            connection.Close();


            Response.Redirect("Journal.aspx?ID=" + JournalID + "");
        }
    }

    protected void btn_Back_JournalList_Click(object sender, EventArgs e)  //返回日志列表
    {
        Response.Redirect("JournalList.aspx");
    }
    protected void DataBindTorpt_Comment(int current)  //绑定外层数据
    {
        string JournalID = Request.QueryString["ID"];
        string sql = "SELECT * FROM Journal_Com WHERE JournalID='" + JournalID + "' AND ResponseTo is null ORDER BY Date DESC";
        DataTable dt = us.SQL_dt(sql);
        Lab_Num.Text = dt.Rows.Count.ToString();
        int count = 0;
        if (dt.Rows.Count == 0)
            divPage.Visible = false;
        for(int i = dt.Rows.Count - 1; i >= 0; i--)
        {
            dt.Rows[count++][6] = i + 1;
        }
        PagedDataSource pds = new PagedDataSource();
        pds.AllowPaging = true;
        pds.PageSize = 5;
        pds.DataSource = dt.DefaultView;
        TotalPage.Text = pds.PageCount.ToString();
        pds.CurrentPageIndex = current - 1;
        rpt_Comment.DataSource = pds;
        rpt_Comment.DataBind();
    }
    protected void btnFirstPage_Click(object sender, EventArgs e)  //首页
    {
        int current = 1;
        NowPage.Text = current.ToString();
        DataBindTorpt_Comment(current);
    }

    protected void btnUpPage_Click(object sender, EventArgs e)  //上一页
    {
        int current = Convert.ToInt32(NowPage.Text) - 1;
        if (current >= 1)
        {
            NowPage.Text = current.ToString();
            DataBindTorpt_Comment(current);
        }
    }

    protected void btnDownPage_Click(object sender, EventArgs e)  //下一页
    {
        int current = Convert.ToInt32(NowPage.Text);
        current++;
        if (current <= Convert.ToInt32(TotalPage.Text))
        {
            NowPage.Text = current.ToString();
            DataBindTorpt_Comment(current);
        }
    }

    protected void btnLastPage_Click(object sender, EventArgs e)  //尾页
    {
        int current = Convert.ToInt32(TotalPage.Text);
        NowPage.Text = current.ToString();
        DataBindTorpt_Comment(current);
    }

    protected void btnJump_Click(object sender, EventArgs e)  //跳页
    {
        try
        {
            int current = Convert.ToInt32(txtJumpPage.Text);
            if (current >= 1 && current <= Convert.ToInt32(TotalPage.Text))
            {
                NowPage.Text = current.ToString();
                DataBindTorpt_Comment(current);
            }
            else
                Response.Write("<script>alert('请输入正确的数字！')</script>");
        }
        catch
        {
            Response.Write("<script>alert('请输入数字！')</script>");
        }
    }

    protected void rpt_Response_ItemCommand(object source, RepeaterCommandEventArgs e)  //第二层repeater点击事件
    {
        if (e.CommandName == "DeleteResponse")
        {
            string Journal_ComID = e.CommandArgument.ToString();
            string sql = "DELETE FROM Journal_Com WHERE Journal_ComID='" + Journal_ComID + "'";
            us.SQL(sql);
            Response.Write("<script>alert('删除成功！')</script>");
        }
        else if(e.CommandName== "GetIn_Response")
        {
            string VisitingQQNum = e.CommandArgument.ToString();
            Session["VisitingQQNum"] = VisitingQQNum;
            Response.Redirect("../MainPage.aspx");
        }
    }

    protected void rpt_Response_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        LinkButton Del = (LinkButton)e.Item.FindControl("btn_ResponseDelete");
        if (Session["QQNum"] == Session["VisitingQQNum"])
            Del.Visible = true;
        else
            Del.Visible = false;
    }

    protected void btn_Submit_Click(object sender, EventArgs e)  //评论
    {
        int Length = HF_Count.Value.Length;
        if (Length > 2000)
            Response.Write("<script>alert('字数超过2000！')</script>");
        else
        {
            string Substance = HF_Substance.Value;
            string Date= DateTime.Now.ToString();
            int JournalID =Convert.ToInt32(Request.QueryString["ID"]);
            string QQNum = Session["QQNum"].ToString();
            string sql = "SELECT UserName FROM Users WHERE QQNum='" + QQNum + "'";
            DataTable dt = us.SQL_dt(sql);
            string VisitorName = dt.Rows[0][0].ToString();
            //sql = "INSERT INTO Journal_Com(JournalID,QQNum,VisitorName,Date,Substance) VALUES('" + JournalID + "','" + QQNum + "','" + VisitorName + "','" + Date + "','" + Substance + "')";
            //us.SQL(sql);
            SqlConnection connection = new SqlConnection("server=DESKTOP-KH8JE5M;Integrated Security=SSPI;database=QZone;");
            connection.Open();
            SqlCommand cmd = new SqlCommand("INSERT INTO Journal_Com(JournalID,QQNum,VisitorName,Date,Substance) VALUES('" + JournalID + "','" + QQNum + "','" + VisitorName + "','" + Date + "',@Substance)", connection);
            cmd.Parameters.AddWithValue("@Substance", Substance);
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            connection.Close();
            
            Response.Redirect("Journal.aspx?ID=" + JournalID + "");
        }
    }
    
}