using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MainInf : System.Web.UI.Page
{
    static SQLHelper us = new SQLHelper();
    static Inf_Search Find = new Inf_Search();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["QQNum"] == null||Session["VisitingQQNum"]==null)
            Response.Redirect("Login.aspx");
        string VisitingQQNum = Session["VisitingQQNum"].ToString();
        string QQNum = Session["QQNum"].ToString();
        if (VisitingQQNum == QQNum)
            btn_Change.Visible = true;
        else
            btn_Change.Visible = false;
        Find_Inf();
    }
    protected void Find_Inf()  //载入数据
    {
        string QQNum = Session["QQNum"].ToString();
        string sql = "SELECT * FROM Users WHERE QQNum='" + QQNum + "'";
        DataTable dt = us.SQL_dt(sql);
        if (Convert.ToInt32(dt.Rows[0][3]) == 1)
            lab_Sex.Text = "男";
        else
            lab_Sex.Text = "女";
        lab_Age.Text = dt.Rows[0][4].ToString();
        string temp = dt.Rows[0][5].ToString();
        string[] num = temp.Split('-');
        string Birthday = Convert.ToInt16(num[1]).ToString() + "月" + Convert.ToInt16(num[2]).ToString() + "日";
        lab_Birthday.Text = Birthday;
        lab_Constellation.Text = dt.Rows[0][6].ToString();
        lab_Con.Text = dt.Rows[0][6].ToString();
        lab_BloodType.Text = dt.Rows[0][7].ToString();
    }

    protected void btn_Change_Click(object sender, EventArgs e)  //进入修改页面
    {
        div_Change.Visible = true;
        div_Look.Visible = false;
        string QQNum = Session["QQNum"].ToString();
        string sql = "SELECT * FROM Users WHERE QQNum='" + QQNum + "'";
        DataTable dt = us.SQL_dt(sql);
        txt_UserName.Text = dt.Rows[0][1].ToString();
        if (Convert.ToInt32(dt.Rows[0][3]) == 1)
            male.Selected = true;
        else
            female.Selected = true;
        if (dt.Rows[0][7].ToString() == "A型")
            LT_A.Selected = true;
        else if (dt.Rows[0][7].ToString() == "B型")
            LT_B.Selected = true;
        else if (dt.Rows[0][7].ToString() == "AB型")
            LT_AB.Selected = true;
        else if (dt.Rows[0][7].ToString() == "O型")
            LT_O.Selected = true;
        else
            LT_其他.Selected = true;
        Cal_Birthday.SelectedDate = DateTime.Parse(dt.Rows[0][5].ToString());
        Cal_Birthday.VisibleDate = DateTime.Parse(dt.Rows[0][5].ToString());
    }

    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        string QQNum = Session["QQNum"].ToString();
        string UserName = txt_UserName.Text;
        string Sex = SelSex.Text;
        string Birthday = Cal_Birthday.SelectedDate.ToString("yyyy-MM-dd");
        int Age = Find.Find_Age(Birthday);
        string Constellation = Find.Find_Constellation(Birthday);
        string BloodType = SelType.Text;
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
        else
        {
            string sql = "UPDATE Users SET UserName=N'" + UserName + "',Sex='" + Sex + "',Age='" + Age + "',Birthday='" + Birthday + "',Constellation='" + Constellation + "',BloodType='" + BloodType + "' WHERE QQNum='" + QQNum + "'";
            us.SQL(sql);
            Response.Write("<script>alert('修改成功！');location='MainInf.aspx'</script>");
        }
    }
}