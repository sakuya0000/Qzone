using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FindPwd : System.Web.UI.Page
{
    static Class1 us = new Class1();
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void btnFind_Click(object sender, EventArgs e)  //找回密码
    {
        string username = txtUsername.Text;
        if (us.CheckUser(username) == 1)
        {
            string password = us.FindPwd(username);
            Response.Write("<script>alert('" + password + "')</script>");
        }
        else
            Response.Write("<script>alert('用户不存在！')</script>");
    }

    protected void btnBack_Click(object sender, EventArgs e)  //切换找回密码页面到主页面
    {
        Response.Redirect("Main.aspx");
    }
}