using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Register : System.Web.UI.Page
{
    static Class1 us = new Class1();

    protected void Page_Load(object sender, EventArgs e)
    {
        ibtn_yzm.ImageUrl = "ImageCode.aspx";
    }


    protected void btnSubmit_Click(object sender, EventArgs e)  //注册
    {
        string username = txtUsername.Text;
        string Pwd_O = txtPwd_O.Text;
        string Pwd_R = txtPwd_R.Text;
        int lenName = username.Length;
        int lenPwd = Pwd_O.Length;
        string code = tbx_yzm.Text;
        HttpCookie htco = Request.Cookies["ImageV"];
        string scode = htco.Value.ToString();
        if (code == scode)
        {
            if (lenName == 0)
            {
                Response.Write("<script>alert('用户名不能为空!')</script>");
            }
            else
            {
                if (us.CheckUser(username) == 1)
                {
                    Response.Write("<script>alert('用户名已存在!')</script>");
                }
                else if (Pwd_O == Pwd_R)
                {
                    if (lenPwd >= 6 && lenPwd <= 12)
                    {
                        us.AddUser(username, Pwd_O);
                        Response.Write("<script>alert('注册成功！');location='Main.aspx'</script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('密码必须为6到12位的数字或字母！')</script>");
                    }
                }
                else
                    Response.Write("<script>alert('输入密码和确认密码不一致')</script>");
            }
        }
        else
            Response.Write("<script>alert('验证码输入不正确！')</script>");
    }

    protected void btnBack_Click(object sender, EventArgs e)  //返回注册页面到主页面
    {
        Response.Redirect("Main.aspx");
    }
}