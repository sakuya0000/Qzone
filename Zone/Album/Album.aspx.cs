using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Zone_Album_Album : System.Web.UI.Page
{
    static SQLHelper us = new SQLHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["QQNum"] == null || Session["VisitingQQNum"] == null)
                Response.Redirect("../Login.aspx");
            if (Session["FileName"] == null)
                Response.Redirect("FileList.aspx");
            string VisitingQQNum = Session["VisitingQQNum"].ToString();
            string QQNum = Session["QQNum"].ToString();
            if (VisitingQQNum == QQNum)
                div_upload.Visible = true;
            else
                div_upload.Visible = false;
            DataBindTorpt_Album();
        }
    }
    protected bool IsImage(string Extension)  //验证文件格式
    {
        bool flag = false;
        string[] allow = { ".jpg", ".gif", ".bmp", ".png" };
        for(int i = 0; i < 4; i++)
        {
            if (Extension == allow[i])
            {
                flag = true;
                break;
            }
        }
        return flag;
    }
    protected string CreateRNG()  //生成随机字符串
    {
        RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
        byte[] buff = new byte[4];
        rng.GetBytes(buff);
        return Convert.ToBase64String(buff);
    }
    protected string CreateHash(string filename)  //哈希加密
    {
        string strSalt = CreateRNG();
        string temp = filename + strSalt;
        temp= FormsAuthentication.HashPasswordForStoringInConfigFile(temp, "sha1");
        temp = temp.ToLower().Substring(0, 16);
        return temp;
    }
    protected void btnUpload_Click(object sender, EventArgs e)  //上传
    {
        HttpFileCollection files = Request.Files;  //取得所有文件
        Boolean fileOk = false;
        string Inform = "<script>alert('";
        for(int i = 0; i < files.Count; i++)
        {
            HttpPostedFile PostedFile = files[i];  //取得单独的文件
            string fileName = System.IO.Path.GetFileName(PostedFile.FileName);  //获得文件名
            if (fileName != "")
            {
                string fileExtension = System.IO.Path.GetExtension(fileName).ToLower();  //取得文件拓展名
                fileOk = IsImage(fileExtension); //验证文件格式
                if (fileOk)
                {
                    if (PostedFile.ContentLength < 8192000)
                    {
                        string filepath = Session["FileName"].ToString();
                        string virpath = "/Zone/Album/" + filepath + CreateHash(fileName) + fileExtension;
                        string mappath = Server.MapPath(virpath);
                        string Time= DateTime.Now.ToString();
                        string sql = "INSERT INTO Album(FileName,Path,Time) VALUES('" + filepath + "','" + virpath + "','"+Time+"')";
                        us.SQL(sql);
                        PostedFile.SaveAs(mappath);
                        if (i < 1)
                        {
                            string QQNum = Session["QQNum"].ToString();
                            string Img = "Image" + (i+1).ToString();
                            sql = "SELECT PicID FROM Album WHERE Path='" + virpath + "'";
                            DataTable dt = us.SQL_dt(sql);
                            int EventID = Convert.ToInt32(dt.Rows[0][0].ToString());
                            sql = "INSERT INTO New_Events(EventType,EventID,Time,QQNum," + Img + ") VALUES ('3','" + EventID + "','" + Time + "','" + QQNum + "','" + virpath + "')";
                            us.SQL(sql);
                        }
                        if (i != files.Count - 1)
                            Inform += "文件 " + fileName + " 上次成功！\\n";
                        else
                            Inform += "文件 " + fileName + " 上次成功！";
                    }
                    else
                    {
                        if (i != files.Count - 1)
                            Inform += "文件 " + fileName + " 过大，请重新选择！\\n";
                        else
                            Inform += "文件 " + fileName + " 过大，请重新选择！";
                    }
                }
                else
                {
                    if (i != files.Count - 1)
                        Inform += "文件 " + fileName + " 格式不正确！\\n";
                    else
                        Inform += "文件 " + fileName + " 格式不正确！";
                }
            }
        }
        if (Inform == "<script>alert('")
            Inform += "请选择要上传的文件！');location='Album.aspx'</script>";
        else
            Inform += "');location='Album.aspx'</script>";
        Response.Write(Inform);
    }
    protected void DataBindTorpt_Album()  //绑定数据
    {
        string FileName = Session["FileName"].ToString();
        string sql = "SELECT * FROM Album WHERE FileName='" + FileName + "' ORDER BY Time DESC";
        DataTable dt = us.SQL_dt(sql);
        rpt_Album.DataSource = dt;
        rpt_Album.DataBind();

    }
    protected void rpt_Album_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            string[] temp = e.CommandArgument.ToString().Split(',');
            int PicID = Convert.ToInt32(temp[0]);
            string Path = temp[1];
            string sql = "DELETE FROM Album WHERE PicID='" + PicID + "'";
            us.SQL(sql);
            Path = Server.MapPath(Path);
            System.IO.File.Delete(Path);
            sql = "DELETE FROM New_Events WHERE EventID='" + PicID + "' AND EventType='3'";
            us.SQL(sql);
            Response.Write("<script>alert('删除成功！');location='Album.aspx'</script>");
        }
    }
    protected void btn_Back_Click(object sender, EventArgs e)  //返回
    {
        Session["FileName"] = null;
        Response.Redirect("FileList.aspx");
    }

    protected void rpt_Album_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        LinkButton Del = (LinkButton)e.Item.FindControl("btn_Delete");
        if (Session["QQNum"] == Session["VisitingQQNum"])
            Del.Visible = true;
        else
            Del.Visible = false;
    }
}