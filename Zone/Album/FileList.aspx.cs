using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Zone_Album_FileList : System.Web.UI.Page
{
    static SQLHelper us = new SQLHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string VisitingQQNum = Session["VisitingQQNum"].ToString();
            string QQNum = Session["QQNum"].ToString();
            if (VisitingQQNum == QQNum)
                btn_CreateAlbum.Visible = true;
            else
                btn_CreateAlbum.Visible = false;
            if (Session["QQNum"] == null || Session["VisitingQQNum"] == null)
                Response.Redirect("../Login.aspx");
            rpt_FileList_ItemDataBound();
        }
    }

    protected void rpt_FileList_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if(e.CommandName== "GetIn")
        {
            string FileName = e.CommandArgument.ToString();
            Session["FileName"] = FileName;
            Response.Redirect("Album.aspx");
        }
        else if (e.CommandName == "Delete")
        {
            string FileName = e.CommandArgument.ToString();
            string sql = "DELETE FROM Album_FileList WHERE FileName='" + FileName + "'";
            us.SQL(sql);
            sql = "DELETE FROM Album WHERE FileName='" + FileName + "'";
            us.SQL(sql);
            string path = Server.MapPath(FileName);
            File.Delete(path);
            Response.Write("<script>alert('删除成功！');location='FileList.aspx'</script>");
        }
    }

    protected void btn_CreateAlbum_Click(object sender, EventArgs e)  //切换页面
    {
        div_FirstPage.Visible = false;
        div_SecondPage.Visible = true;
    }

    protected void rpt_FileList_ItemDataBound()  //数据绑定
    {
        string VisitingQQNum = Session["VisitingQQNum"].ToString();
        string sql = "SELECT * FROM Album_FileList WHERE QQNum='" + VisitingQQNum + "' ORDER BY Time DESC";
        DataTable dt = us.SQL_dt(sql);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            string[] temp = Regex.Split(dt.Rows[i][1].ToString(), "&&&", RegexOptions.IgnoreCase);
            dt.Rows[i][2] = temp[0];
        }
        rpt_FileList.DataSource = dt;
        rpt_FileList.DataBind();
    }

    protected void btn_Submit_Click(object sender, EventArgs e)  //创建
    {
        string QQNum = Session["QQNum"].ToString();
        string sql = "SELECT Album_FileListID FROM Album_FileList WHERE QQNum='" + QQNum + "'";
        DataTable dt = us.SQL_dt(sql);
        if (dt.Rows.Count >= 30)
            Response.Write("<script>alert('相册数不可超过30个！')</script>");
        else if (txt_AlbumName.Text.Length == 0)
            Response.Write("<script>alert('请输入相册名！')</script>");
        else if (txt_AlbumName.Text.Length >= 20)
            Response.Write("<script>alert('相册名过长！')</script>");
        else
        {
            string Time= DateTime.Now.ToString();
            string AlbumName = txt_AlbumName.Text + "&&&" + CreateAlbumName()+"/";
            //sql = "INSERT INTO Album_FileList(FileName,QQNum,Time) VALUES('" + AlbumName + "','" + QQNum + "','"+Time+"')";
            //us.SQL(sql);

            SqlConnection connection = new SqlConnection("server=DESKTOP-KH8JE5M;Integrated Security=SSPI;database=QZone;");
            connection.Open();
            SqlCommand cmd = new SqlCommand("INSERT INTO Album_FileList(FileName,QQNum,Time) VALUES(@AlnumName,@QQNum,@Time)",connection);
            cmd.Parameters.AddWithValue("@AlnumName", AlbumName);
            cmd.Parameters.AddWithValue("@QQNum", QQNum);
            cmd.Parameters.AddWithValue("@Time", Time);
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            connection.Close();



            Directory.CreateDirectory(Server.MapPath(AlbumName));
            Response.Write("<script>alert('创建成功！');location='FileList.aspx'</script>");
        }
    }
    protected string CreateAlbumName()  //生成随机哈希字符串
    {
        RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
        byte[] buff = new byte[4];
        rng.GetBytes(buff);
        return FormsAuthentication.HashPasswordForStoringInConfigFile(Convert.ToBase64String(buff), "MD5").ToLower().Substring(0,16);
    }


    protected void rpt_FileList_ItemDataBound1(object sender, RepeaterItemEventArgs e)
    {
        LinkButton Del = e.Item.FindControl("btn_Delete") as LinkButton;
        if (Session["QQNum"] == Session["VisitingQQNum"])
            Del.Visible = true;
        else
            Del.Visible = false;
    }
}