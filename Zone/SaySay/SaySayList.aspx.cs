using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Zone_SaySay_SaySayList : System.Web.UI.Page
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
            if(VisitingQQNum == QQNum)
            {
                divGuest.Visible = false;
                divMaster.Visible = true;
            }
            else
            {
                divMaster.Visible = false;
                divGuest.Visible = true;
            }
            DataBindTorpt_SaySay(1);
        }
    }

    protected void rpt_SaySay_ItemCommand(object source, RepeaterCommandEventArgs e)  //第一层点击事件
    {
        if (e.CommandName == "GetIn")
        {
            string QQNum = e.CommandArgument.ToString();
            string t = Session["QQNum"].ToString();
            Session["VisitingQQNum"] = QQNum;
            Response.Redirect("../MainPage.aspx");
        }
        else if (e.CommandName == "GetInSaySay")
        {
            string SaySayID = e.CommandArgument.ToString();
            Response.Redirect("SaySay.aspx?SID=" + SaySayID + "");
        }
        else if (e.CommandName == "Delete")
        {
            int SaySayID = Convert.ToInt32(e.CommandArgument.ToString());
            string sql = "DELETE FROM SaySay WHERE SaySayID='" + SaySayID + "'";
            us.SQL(sql);
            sql = "DELETE FROM SaySay_Com WHERE SaySayID='" + SaySayID + "'";
            us.SQL(sql);
            sql = "DELETE FROM New_Events WHERE EventType='2' AND EventID='" + SaySayID + "'";
            us.SQL(sql);
            Response.Write("<script>alert('删除成功！');location='SaySayList.aspx'</script>");
        }
        else if (e.CommandName == "Com")
        {
            TextBox Substance = (TextBox)e.Item.FindControl("txt_Com");
            if (Substance.Text.Length > 200)
                Response.Write("<script>alert('长度超过200！')</script>");
            else if (Substance.Text.Length == 0)
                Response.Write("<script>alert('请输入内容！')</script>");
            else
            {
                int SaySayID = Convert.ToInt32(e.CommandArgument.ToString());
                string QQNum = Session["QQNum"].ToString();
                string sql = "SELECT UserName FROM Users WHERE QQNum='" + QQNum + "'";
                DataTable dt = us.SQL_dt(sql);
                string OwnerName = dt.Rows[0][0].ToString();
                string Time = DateTime.Now.ToString();
                sql = "INSERT INTO SaySay_Com(QQNum,VisitorName,SaySayID,Substance,Time) VALUES('" + QQNum + "','" + OwnerName + "','" + SaySayID + "','" + Substance.Text + "','" + Time + "')";
                us.SQL(sql);
                Response.Redirect("SaySayList.aspx");
            }
        }
    }

    protected void rpt_SaySay_ItemDataBound(object sender, RepeaterItemEventArgs e)  //第二层数据绑定及第一层控件显示
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            LinkButton Del = (LinkButton)e.Item.FindControl("btn_Del_SaySay");
            string VisitingQQNum = Session["VisitingQQNum"].ToString();
            string QQNum = Session["QQNum"].ToString();
            if (VisitingQQNum == QQNum)
                Del.Visible = true;
            else
                Del.Visible = false;
            Label Lab_ComNum = (Label)e.Item.FindControl("Lab_ComNum");
            Repeater rpt = (Repeater)e.Item.FindControl("rpt_Comment");
            HiddenField HF_SaySayID = (HiddenField)e.Item.FindControl("HF_SaySayID");
            int SaySayID = Convert.ToInt32(HF_SaySayID.Value);
            string sql = "SELECT * FROM SaySay_Com WHERE SaySayID='" + SaySayID + "' AND ResponseTo is null ORDER BY Time DESC";
            DataTable dt = us.SQL_dt(sql);
            Lab_ComNum.Text = dt.Rows.Count.ToString();
            rpt.DataSource = dt;
            rpt.DataBind();
        }
    }

    protected void rpt_Comment_ItemCommand(object source, RepeaterCommandEventArgs e)  //第二层点击事件
    {
        if (e.CommandName == "GetIn")
        {
            string QQNum = e.CommandArgument.ToString();
            Session["VisitingQQNum"] = QQNum;
            Response.Redirect("../MainPage.aspx");
        }
        else if (e.CommandName == "Delete")
        {
            int SaySay_ComID = Convert.ToInt32(e.CommandArgument.ToString());
            string sql = "DELETE FROM SaySay_Com WHERE SaySay_ComID='" + SaySay_ComID + "' OR ResponseTo='" + SaySay_ComID + "'";
            us.SQL(sql);
            Response.Write("<script>alert('删除成功！');location='SaySayList.aspx'</script>");
        }
        else if (e.CommandName == "Res")
        {
            Panel pan = (Panel)e.Item.FindControl("Pan");
            pan.Visible = true;
        }
        else if (e.CommandName == "Res_Submit")
        {
            TextBox Substance = (TextBox)e.Item.FindControl("txt_Res");
            if (Substance.Text.Length > 200)
                Response.Write("<script>alert('长度超过200！')</script>");
            else if (Substance.Text.Length == 0)
                Response.Write("<script>alert('请输入内容！')</script>");
            else
            {
                string[] temp = e.CommandArgument.ToString().Split(',');
                int SaySay_ComID = Convert.ToInt32(temp[0]);
                int SaySayID = Convert.ToInt32(temp[1]);
                string Time = DateTime.Now.ToString();
                string QQNum = Session["QQNum"].ToString();
                string sql = "SELECT UserName FROM Users WHERE QQNum='" + QQNum + "'";
                DataTable dt = us.SQL_dt(sql);
                string VisitorName = dt.Rows[0][0].ToString();
                sql = "INSERT INTO SaySay_Com(QQNum,VisitorName,SaySayID,Substance,Time,ResponseTo) VALUES('" + QQNum + "','" + VisitorName + "','" + SaySayID + "','" + Substance.Text + "','" + Time + "','" + SaySay_ComID + "')";
                us.SQL(sql);
                Response.Redirect("SaySayList.aspx");
            }
        }
    }

    protected void rpt_Comment_ItemDataBound(object sender, RepeaterItemEventArgs e)  //第三层数据绑定及第二层控件显示
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            LinkButton Del = (LinkButton)e.Item.FindControl("btn_Del_Com");
            string VisitingQQNum = Session["VisitingQQNum"].ToString();
            string QQNum = Session["QQNum"].ToString();
            if (VisitingQQNum == QQNum)
                Del.Visible = true;
            else
                Del.Visible = false;
            HiddenField HF_ComID = (HiddenField)e.Item.FindControl("HF_ComID");
            int SaySay_ComID = Convert.ToInt32(HF_ComID.Value);
            string sql = "SELECT * FROM SaySay_Com WHERE ResponseTo='" + SaySay_ComID + "' ORDER BY Time DESC";
            DataTable dt = us.SQL_dt(sql);
            Repeater rpt = (Repeater)e.Item.FindControl("rpt_Response");
            rpt.DataSource = dt;
            rpt.DataBind();
        }
    }

    protected void rpt_Response_ItemCommand(object source, RepeaterCommandEventArgs e)  //第三层点击事件
    {
        if(e.CommandName== "GetIn")
        {
            string QQNum = e.CommandArgument.ToString();
            Session["VisitingQQNum"] = QQNum;
            Response.Redirect("../MainPage.aspx");
        }
        else if(e.CommandName== "Delete")
        {
            int SaySay_ComID = Convert.ToInt32(e.CommandArgument.ToString());
            string sql = "DELETE FROM SaySay_Com WHERE SaySay_ComID='" + SaySay_ComID + "'";
            us.SQL(sql);
            Response.Write("<script>alert('删除成功！');location='SaySayList.aspx'</script>");
        }
    }

    protected void rpt_Response_ItemDataBound(object sender, RepeaterItemEventArgs e)  //第三层控件显示
    {
        LinkButton Del = (LinkButton)e.Item.FindControl("btn_Del_Res");
        string VisitingQQNum = Session["VisitingQQNum"].ToString();
        string QQNum = Session["QQNum"].ToString();
        if (VisitingQQNum == QQNum)
            Del.Visible = true;
        else
            Del.Visible = false;
    }
    protected void DataBindTorpt_SaySay(int current)  //绑定第一层数据
    {
        string VisitingQQNum = Session["VisitingQQNum"].ToString();
        string sql = "SELECT * FROM SaySay WHERE QQNum='" + VisitingQQNum + "' ORDER BY Time DESC";
        DataTable dt = us.SQL_dt(sql);
        if (dt.Rows.Count == 0)
            div_Page.Visible = false;
        PagedDataSource pds = new PagedDataSource();
        pds.AllowPaging = true;
        pds.PageSize = 10;
        pds.DataSource = dt.DefaultView;
        TotalPage.Text = pds.PageCount.ToString();
        pds.CurrentPageIndex = current - 1;
        rpt_SaySay.DataSource = pds;
        rpt_SaySay.DataBind();
    }
    protected void btnFirstPage_Click(object sender, EventArgs e)  //首页
    {
        int current = 1;
        NowPage.Text = current.ToString();
        DataBindTorpt_SaySay(current);
    }

    protected void btnUpPage_Click(object sender, EventArgs e)  //上一页
    {
        int current = Convert.ToInt32(NowPage.Text) - 1;
        if (current >= 1)
        {
            NowPage.Text = current.ToString();
            DataBindTorpt_SaySay(current);
        }
    }

    protected void btnDownPage_Click(object sender, EventArgs e)  //下一页
    {
        int current = Convert.ToInt32(NowPage.Text);
        current++;
        if (current <= Convert.ToInt32(TotalPage.Text))
        {
            NowPage.Text = current.ToString();
            DataBindTorpt_SaySay(current);
        }
    }

    protected void btnLastPage_Click(object sender, EventArgs e)  //尾页
    {
        int current = Convert.ToInt32(TotalPage.Text);
        NowPage.Text = current.ToString();
        DataBindTorpt_SaySay(current);
    }

    protected void btnJump_Click(object sender, EventArgs e)  //跳页
    {
        try
        {
            int current = Convert.ToInt32(txtJumpPage.Text);
            if (current >= 1 && current <= Convert.ToInt32(TotalPage.Text))
            {
                NowPage.Text = current.ToString();
                DataBindTorpt_SaySay(current);
            }
            else
                Response.Write("<script>alert('请输入正确的数字！')</script>");
        }
        catch
        {
            Response.Write("<script>alert('请输入数字！')</script>");
        }
    }

    protected void btn_Submit_Click(object sender, EventArgs e)  //发表说说
    {
        string txt = HF_txt.Value;
        if (txt.Length > 2000)
            Response.Write("<script>alert('请将字数限制在两千字之内！')</script>");
        else
        {
            string Substance = HF_html.Value;
            string Time = DateTime.Now.ToString();
            string QQNum = Session["QQNum"].ToString();
            string sql = "SELECT UserName FROM Users WHERE QQNum='" + QQNum + "'";
            DataTable dt = us.SQL_dt(sql);
            string OwnerName = dt.Rows[0][0].ToString();
            sql = "INSERT INTO SaySay(QQNum,OwnerName,Substance,Time) VALUES('" + QQNum + "','" + OwnerName + "','" + Substance + "','" + Time + "')";
            us.SQL(sql);
            sql = "SELECT SaySayID FROM SaySay WHERE QQNum='" + QQNum + "' AND OwnerName='" + OwnerName + "' AND Substance='" + Substance + "' AND Time='" + Time + "'";
            DataTable d = us.SQL_dt(sql);
            int EventID = Convert.ToInt32(d.Rows[0][0].ToString());
            sql = "INSERT INTO New_Events(EventType,EventID,Substance,Time,QQNum) VALUES('2','" + EventID + "','" + Substance + "','" + Time + "','" + QQNum + "')";
            us.SQL(sql);
            Response.Redirect("SaySayList.aspx");
        }
    }
}