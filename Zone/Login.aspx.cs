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
        ibtn_yzm.ImageUrl = "ImageCode.aspx";
    }

    protected void btn_Login_Click(object sender, EventArgs e)  //登录
    {
        string UserName = txtUsername.Text;
        string Password = txtPwd.Text;
        string code = tbx_yzm.Text;
        HttpCookie htco = Request.Cookies["ImageV"];
        string scode = htco.Value.ToString();
        if (code.ToLower() == scode.ToLower())
        {
            if (UserName.Length == 0)
                Response.Write("<script>alert('用户名不得为空！')</script>");
            else if (UserName.Length > 16 || UserName.Length < 8)
                Response.Write("<script>alert('用户名为8-16位！')</script>");
            else if (Password.Length > 16 || UserName.Length < 8)
                Response.Write("<script>alert('用户名或密码错误！')</script>");
            else
            {
                string sql = "SELECT Password FROM Users WHERE UserName ='" + UserName + "'";
                Password = FormsAuthentication.HashPasswordForStoringInConfigFile(Password, "MD5").ToLower();
                DataTable dt = us.SQL_dt(sql);
                if (dt.Rows.Count == 0)
                    Response.Write("<script>alert('用户名或密码错误！')</script>");
                else
                {
                    if (Password == dt.Rows[0].ToString())
                    {
                        UserName = FormsAuthentication.HashPasswordForStoringInConfigFile(UserName, "MD5").ToLower();
                        Session["username"] = UserName;
                        Response.Redirect("MainPage.aspx");
                    }
                    else
                        Response.Write("<script>alert('用户名或密码错误！')</script>");
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