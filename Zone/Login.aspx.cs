using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Zone_Login : System.Web.UI.Page
{
    static SQLHelper us = new SQLHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["QQNum"] != null)
                txtQQNum.Text = Session["QQNum"].ToString();
            ibtn_yzm.ImageUrl = "ImageCode.aspx";
        }
    }

    protected void btn_Login_Click(object sender, EventArgs e)  //登录
    {
        string QQNum = txtQQNum.Text;
        string Password = txtPassword.Text;
        string code = tbx_yzm.Text;
        HttpCookie htco = Request.Cookies["ImageV"];
        string scode = htco.Value.ToString();
        if (code.ToLower() == scode.ToLower())
        {
            if (QQNum.Length == 0)
                Response.Write("<script>alert('QQ号不得为空！')</script>");
            else if (QQNum.Length != 9 && QQNum.Length != 11)
                Response.Write("<script>alert('QQ号或密码错误！')</script>");
            else if (Password.Length < 8 || Password.Length > 16)
                Response.Write("<script>alert('QQ号或密码错误！')</script>");
            else
            {
                string sql = "SELECT Password FROM Users WHERE QQNum='" + QQNum + "'";
                Password = FormsAuthentication.HashPasswordForStoringInConfigFile(Password, "MD5").ToLower();
                DataTable dt = us.SQL_dt(sql);
                if (dt.Rows.Count == 0)
                    Response.Write("<script>alert('QQ号或密码错误！')</script>");
                else
                {
                    if (Password == dt.Rows[0][0].ToString())
                    {
                        Session["QQNum"] = QQNum;
                        Session["VisitingQQNum"] = QQNum;
                        Response.Redirect("FirstPage.aspx");
                    }
                    else
                        Response.Write("<script>alert('QQ号或密码错误！')</script>");
                }

            }
        }
        else
            Response.Write("<script>alert('验证码错误！')</script>");
    }

    protected void btn_Register_Click(object sender, EventArgs e)  //注册
    {
        Response.Redirect("Register.aspx");
    }
}