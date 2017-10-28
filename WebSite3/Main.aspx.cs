using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class test : System.Web.UI.Page
{
    static Class1 us = new Class1();
    protected void Page_Load(object sender, EventArgs e)
    {
        ibtn_yzm.ImageUrl = "ImageCode.aspx";
    }


    protected void btnLogin_Click(object sender, EventArgs e)  //登录
    {
        string username = txtUsername.Text;
        string password = txtPwd.Text;
        int lenName = username.Length;
        int lenPwd = password.Length;
        int count = us.CheckPwd(username, password);
        string code = tbx_yzm.Text;
        HttpCookie htco = Request.Cookies["ImageV"];
        string scode = htco.Value.ToString();
        if (code == scode)
        {
            if (lenName == 0)
                Response.Write("<script>alert('用户名不能为空')</script>");
            else
            {
                if (lenPwd >= 6 && lenPwd <= 12)
                {
                    if (count == 0)
                        Response.Write("<script>alert('用户名或密码错误！')</script>");
                    else
                    {
                        Response.Write("<script>alert('登录成功！');location='Welcome.aspx'</script>");
                        Session["username"] = username;
                    }
                }
                else
                    Response.Write("<script>alert('密码必须为6到12位的数字或字母！')</script>");
            }
        }
        else
            Response.Write("<script>alert('验证码输入不正确！')</script>");
    }

    protected void btnReg_Click(object sender, EventArgs e)  //切换主页面到注册页面
    {
        Response.Redirect("Register.aspx");
    }

    protected void btnChange1_Click(object sender, EventArgs e)  //切换主页面到修改密码页面
    {
        Response.Redirect("ChangePwd.aspx");
    }

    protected void btnFind1_Click(object sender, EventArgs e)  //切换主页面到找回密码页面
    {
        Response.Redirect("FindPwd.aspx");
    }
}