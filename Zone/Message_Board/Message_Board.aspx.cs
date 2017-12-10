using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Zone_Message_Board_Message_Board : System.Web.UI.Page
{
    static SQLHelper us = new SQLHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["QQNum"] == null || Session["VisitingQQNum"] == null)
                Response.Redirect("../Login.aspx");
            string VisitingQQNum = Session["VisitingQQNum"].ToString();
            string QQNum = Session["QQNum"].ToString();
            if (VisitingQQNum == QQNum)
            {
                divGuest.Visible = false;
            }
            else
                divGuest.Visible = true;
            DatatBindTorpt_Message(1);
        }
    }

    protected void btn_GuestSubmit_Click(object sender, EventArgs e)  //评论
    {
        string Substance =HF_html.Value.ToString();
        int Lenth = HF_txt.Value.Length;
        if (Lenth >= 200)
            Response.Write("<script>alert('长度过长！')</script>");
        else if (Lenth == 0)
            Response.Write("<script>alert('请输入内容！')</script>");
        else
        {
            string Time = DateTime.Now.ToString();
            string QQNum = Session["QQNum"].ToString();
            string VisitingQQNum = Session["VisitingQQNum"].ToString();
            string sql = "INSERT INTO Message_Board(Substance,Time,QQNum,Owner_QQNum) VALUES ('" + Substance + "','" + Time + "','" + VisitingQQNum + "','" + QQNum + "')";
            us.SQL(sql);
            Response.Redirect("Message_Board.aspx");
        }
    }

    protected void rpt_Message_ItemCommand(object source, RepeaterCommandEventArgs e)  //外层
    {
        if (e.CommandName == "Delete")
        {
            int Message_BoradID = Convert.ToInt32(e.CommandArgument.ToString());
            string sql = "DELETE FROM Message_Board WHERE Message_BoradID='" + Message_BoradID + "' OR ResponseToID='" + Message_BoradID + "'";
            us.SQL(sql);
            Response.Write("<script>alert('删除成功！');location='Message_Board.aspx'</script>");
        }
        else if (e.CommandName == "Response")
        {
            TextBox Substance = (TextBox)e.Item.FindControl("txt_Response");
            if (Substance.Text.Length > 200)
                Response.Write("<script>alert('长度过长！')</script>");
            else
            {
                int Message_BoradID = Convert.ToInt32(e.CommandArgument.ToString());
                string Time = DateTime.Now.ToString();
                string sql = "INSERT INTO Message_Board(QQNum,Substance,Time,Owner_QQNum,ResponseToID) VALUES('" + Session["VisitingQQNum"].ToString() + "','" + Substance.Text + "','" + Time + "','" + Session["QQNum"].ToString() + "','" + Message_BoradID + "')";
                us.SQL(sql);
                Response.Redirect("Message_Board.aspx");
            }
        }
        else if (e.CommandName == "GetIn")
        {
            string VisitingQQNum = e.CommandArgument.ToString();
            Session["VisitingQQNum"] = VisitingQQNum;
            Response.Redirect("/Zone/MainPage.aspx");
        }
    }

    protected void rpt_Response_ItemCommand(object source, RepeaterCommandEventArgs e)  //内层
    {
        if(e.CommandName== "Delete")
        {
            int Message_BoradID =Convert.ToInt32(e.CommandArgument.ToString());
            string sql = "DELETE FROM Message_Board WHERE Message_BoradID='" + Message_BoradID + "'";
            us.SQL(sql);
            Response.Write("<script>alert('删除成功！');location='Message_Board.aspx'</script>");
        }
        else if (e.CommandName == "GetIn")
        {
            string VisitingQQNum = e.CommandArgument.ToString();
            Session["VisitingQQNum"] = VisitingQQNum;
            Response.Redirect("/Zone/MainPage.aspx");
        }
    }
    protected void DatatBindTorpt_Message(int current)  //第一层数据绑定
    {
        string QQNum = Session["VisitingQQNum"].ToString();
        string sql = "SELECT * FROM Message_Board WHERE QQNum='" + QQNum + "' AND ResponseToID is null ORDER BY Time DESC";
        DataTable dt = us.SQL_dt(sql);
        if (dt.Rows.Count == 0)
            divPage.Visible = false;
        Lab_Num.Text = dt.Rows.Count.ToString();
        int j = 0;
        for(int i = dt.Rows.Count-1; i >= 0; i--)
        {
            dt.Rows[j++][5] = i+1 ;
        }
        DataColumn dc = null;
        dc = dt.Columns.Add("UserName", Type.GetType("System.String"));
        DataTable d = new DataTable();
        for(int i = 0; i < dt.Rows.Count; i++)
        {
            sql = "SELECT UserName FROM Users WHERE QQNum='" + dt.Rows[i][4].ToString() + "'";
            d = us.SQL_dt(sql);
            dt.Rows[i][6] = d.Rows[0][0];
        }
        PagedDataSource pds = new PagedDataSource();
        pds.AllowPaging = true;
        pds.PageSize = 10;
        pds.DataSource = dt.DefaultView;
        TotalPage.Text = pds.PageCount.ToString();
        pds.CurrentPageIndex = current - 1;
        rpt_Message.DataSource = pds;
        rpt_Message.DataBind();
    }
    protected void btnFirstPage_Click(object sender, EventArgs e)  //首页
    {
        int current = 1;
        NowPage.Text = current.ToString();
        DatatBindTorpt_Message(current);
    }

    protected void btnUpPage_Click(object sender, EventArgs e)  //上一页
    {
        int current = Convert.ToInt32(NowPage.Text) - 1;
        if (current >= 1)
        {
            NowPage.Text = current.ToString();
            DatatBindTorpt_Message(current);
        }
    }

    protected void btnDownPage_Click(object sender, EventArgs e)  //下一页
    {
        int current = Convert.ToInt32(NowPage.Text);
        current++;
        if (current <= Convert.ToInt32(TotalPage.Text))
        {
            NowPage.Text = current.ToString();
            DatatBindTorpt_Message(current);
        }
    }

    protected void btnLastPage_Click(object sender, EventArgs e)  //尾页
    {
        int current = Convert.ToInt32(TotalPage.Text);
        NowPage.Text = current.ToString();
        DatatBindTorpt_Message(current);
    }

    protected void btnJump_Click(object sender, EventArgs e)  //跳页
    {
        try
        {
            int current = Convert.ToInt32(txtJumpPage.Text);
            if (current >= 1 && current <= Convert.ToInt32(TotalPage.Text))
            {
                NowPage.Text = current.ToString();
                DatatBindTorpt_Message(current);
            }
            else
                Response.Write("<script>alert('请输入正确的数字！')</script>");
        }
        catch
        {
            Response.Write("<script>alert('请输入数字！')</script>");
        }
    }

    protected void rpt_Message_ItemDataBound(object sender, RepeaterItemEventArgs e)  //第二层数据绑定
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            LinkButton Del = e.Item.FindControl("btn_Delete") as LinkButton;
            HiddenField Message_BoradID = e.Item.FindControl("MessageID") as HiddenField;
            if (Session["VisitingQQNum"] != Session["QQNum"])
            {
                Del.Visible = false;
            }
            else
            {
                Del.Visible = true;
            }
            Repeater rpt = e.Item.FindControl("rpt_Response") as Repeater;
            string QQNum = Session["VisitingQQNum"].ToString();
            int ID = Convert.ToInt32(Message_BoradID.Value);
            string sql = "SELECT * FROM Message_Board WHERE QQNum='" + QQNum + "' AND ResponseToID='" + ID + "'ORDER BY Time DESC";
            DataTable dt = us.SQL_dt(sql);
            DataColumn dc = null;
            dc = dt.Columns.Add("UserName", Type.GetType("System.String"));
            DataTable d = new DataTable();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                sql = "SELECT UserName FROM Users WHERE QQNum='" + dt.Rows[i][4].ToString() + "'";
                d = us.SQL_dt(sql);
                dt.Rows[i][6] = d.Rows[0][0];
            }
            rpt.DataSource = dt;
            rpt.DataBind();
        }
    }

    protected void rpt_Response_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        LinkButton Del_Res = e.Item.FindControl("btn_Delete_Res") as LinkButton;
        if (Session["VisitingQQNum"] != Session["QQNum"])
            Del_Res.Visible = false;
        else
            Del_Res.Visible = true;
    }
}