using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Zone_Journal_JournalEdit : System.Web.UI.Page
{
    static SQLHelper us = new SQLHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["QQNum"] == null || Session["VisitingQQNum"] == null)
                Response.Redirect("../Login.aspx");
            if (Session["JournalID"] != null)
            {
                string sql = "SELECT Title,Substance FROM Journal WHERE JournalID='" + Session["JournalID"].ToString() + "'";
                DataTable dt = us.SQL_dt(sql);
                txtTitle.Text = dt.Rows[0][0].ToString();
                txtWrite.Text = dt.Rows[0][1].ToString();
            }
        }
    }
    protected void btn_Submit_Click(object sender, EventArgs e)  //提交
    {
        string Title = txtTitle.Text;
        string Substance = txtWrite.Text;
        string Date = DateTime.Now.ToString();
        string QQNum = Session["QQNum"].ToString();
        if (Title.Length == 0)
            Response.Write("<script>alert('请输入日志标题！')</script>");
        else if (Substance.Length == 0)
            Response.Write("<script>alert('请输入日志内容！')</script>");
        else
        {
            //string sql = "INSERT INTO Journal VALUES('" + QQNum + "',N'" + Date + "',N'" + Title + "',N'" + Substance + "')";
            //us.SQL(sql);
            SqlConnection connection = new SqlConnection("server=DESKTOP-KH8JE5M;Integrated Security=SSPI;database=QZone;");
            connection.Open();
            SqlCommand command = new SqlCommand("INSERT INTO Journal VALUES('" + QQNum + "',N'" + Date + "',@Title,@Substance)", connection);
            command.Parameters.AddWithValue("@Title", Title);
            command.Parameters.AddWithValue("@Substance", Substance);
            command.ExecuteNonQuery();
            command.Dispose();

            //sql = "SELECT JournalID FROM Journal WHERE QQNum='" + QQNum + "'AND Date='" + Date + "' AND Title='" + Title + "' AND Substance='" + Substance + "'";
            //DataTable dt = us.SQL_dt(sql);
            SqlCommand cmd = new SqlCommand("SELECT JournalID FROM Journal WHERE QQNum='" + QQNum + "'AND Date='" + Date + "' AND Title=@Title  AND Substance = @Substance", connection);
            cmd.Parameters.AddWithValue("@Title", Title);
            cmd.Parameters.AddWithValue("@Substance", Substance);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);


            int EventID = Convert.ToInt32(dt.Rows[0][0].ToString());
            string Time = DateTime.Now.ToString();
            //sql = "INSERT INTO New_Events(EventType,EventID,Substance,Time,QQNum) VALUES('1','" + EventID + "','" + Title + "','" + Time + "','" + QQNum + "')";
            //us.SQL(sql);
            SqlCommand cmd2 = new SqlCommand("INSERT INTO New_Events(EventType,EventID,Substance,Time,QQNum) VALUES('1','" + EventID + "',@Title,'" + Time + "','" + QQNum + "')", connection);
            cmd2.Parameters.AddWithValue("@Title", Title);
            cmd2.ExecuteNonQuery();
            cmd2.Dispose();
            connection.Close();



            Response.Redirect("JournalList.aspx");
        }
    }

    protected void btn_Cancel_Click(object sender, EventArgs e)  //返回
    {
        if(Session["JournalID"]==null)
            Response.Redirect("JournalList.aspx");
        else
        {
            string JournalID = Session["JournalID"].ToString();
            Session["JournalID"] = null;
            Response.Redirect("Journal.aspx?ID=" + JournalID + "");
        }
    }
}