using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Register : System.Web.UI.Page
{
    static SQLHelper us = new SQLHelper();
    static Inf_Search Find = new Inf_Search();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ibtn_yzm.ImageUrl = "ImageCode.aspx";
        }
    }

    protected void btn_Register_Click(object sender, EventArgs e)  //注册
    {
        string UserName = txtUserName.Text;
        string Password = txtPassword.Text;
        string code = tbx_yzm.Text;
        HttpCookie htco = Request.Cookies["ImageV"];
        string scode = htco.Value.ToString();
        if (code.ToLower() == scode.ToLower())
        {
            if (UserName.Length == 0)
            {
                Response.Write("<script>alert('用户名不能为空!')</script>");
            }
            else if (UserName.Length < 3)
            {
                Response.Write("<script>alert('用户名不能少于3个字符!')</script>");
            }
            else if (UserName.Length > 20)
            {
                Response.Write("<script>alert('用户名不能多于20个字符!')</script>");
            }
            else if (Password.Length < 6 || Password.Length > 18)
                Response.Write("<script>alert('密码必须为6到18位!')</script>");
            else
            {
                if (Session["QQNiceNum"] == null)
                    Session["QQNiceNum"] = CreateQQNiceNum(11);
                Password = FormsAuthentication.HashPasswordForStoringInConfigFile(Password, "MD5").ToLower();  //对密码进行加密
                string Birthday = DateTime.Now.AddYears(-10).ToString("yyyy-01-01");
                string Constellation = Find.Find_Constellation(Birthday);
                //string sql = "INSERT INTO Users VALUES('" + Session["QQNiceNum"].ToString() + "','" + UserName + "','" + Password + "',1,10,'" + Birthday + "','" + Constellation + "',N'其他')";
                //us.SQL(sql);

                SqlConnection connection = new SqlConnection("server=DESKTOP-KH8JE5M;Integrated Security=SSPI;database=QZone;");
                connection.Open();
                SqlCommand command = new SqlCommand("INSERT INTO Users VALUES(@QQNum,@UserName,@Password,@Sex,@Age,@Birthday,@Constellation,@BloodType)", connection);
                command.Parameters.Add(new SqlParameter("@QQNum", SqlDbType.NVarChar, 50));
                command.Parameters["@QQNum"].Value = Session["QQNiceNum"].ToString();
                command.Parameters.AddWithValue("@UserName", UserName);
                command.Parameters.AddWithValue("@Password", Password);
                command.Parameters.AddWithValue("@Sex", 1);
                command.Parameters.AddWithValue("@Age", 10);
                command.Parameters.AddWithValue("@Birthday", Birthday);
                command.Parameters.AddWithValue("@Constellation", Constellation);
                command.Parameters.AddWithValue("@BloodType", "其他");
                command.ExecuteNonQuery();
                command.Dispose();
                connection.Close();


                Session["QQNum"] = Session["QQNiceNum"];
                Session["QQNiceNum"] = null;
                Response.Write("<script>alert('注册成功！');location='Login.aspx'</script>");
            }
        }
        else
            Response.Write("<script>alert('验证码输入不正确！')</script>");
    }

    protected void btn_Change_QQNiceNum_Click(object sender, EventArgs e)  //更换QQ靓号
    {
        lab_QQNiceName.Text = CreateQQNiceNum(9);
        Session["QQNiceNum"] = lab_QQNiceName.Text;
    }

    protected void btn_Create_QQNiceNum_Click(object sender, EventArgs e)  //切换到第二个页面
    {
        lab_QQNiceName.Text = CreateQQNiceNum(9);
        div_FirstPage.Visible = false;
        div_SecondPage.Visible = true;
        Session["QQNiceNum"] = lab_QQNiceName.Text;
    }

    protected string CreateQQNiceNum(int Length)  //生成QQ靓号
    {
        var result = new StringBuilder();
        for (var i = 0; i < Length; i++)
        {
            var r = new Random(Guid.NewGuid().GetHashCode());
            result.Append(r.Next(0, 10));
        }
        string sql = "SELECT QQNum FROM Users WHERE QQNum='" + result + "'";
        DataTable dt = us.SQL_dt(sql);
        if (dt.Rows.Count != 0 || result[0]=='0')
            return CreateQQNiceNum(Length);
        return result.ToString();
    }
}