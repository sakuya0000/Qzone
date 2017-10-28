using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Class1 的摘要说明
/// </summary>
public class Class1
{
    static string str = @"server=DESKTOP-F3H8PQV;Integrated Security=SSPI;database=Demo;";
    public Class1()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
    public int CheckUser(string username)  //检查用户是否存在
    {
        //SELECT * FROM users WHERE username='username'
        string sql = "SELECT * FROM users WHERE username=N'" + username + "'";
        SqlConnection conn = new SqlConnection(str);
        System.Data.DataTable dt = new DataTable();
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);
        da.Fill(dt);
        conn.Close();
        int count = dt.Rows.Count;
        if (count == 0)
            return 0;
        else return 1;
    }
    public int CheckPwd(string username,string password)  //检查用户和密码
    {
        string sql = "SELECT * FROM users WHERE username=N'" + username + "' AND password='" + password + "'";
        SqlConnection conn = new SqlConnection(str);
        System.Data.DataTable dt = new DataTable();
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);
        da.Fill(dt);
        conn.Close();
        return dt.Rows.Count;
    }
    public void AddUser(string username,string password)  //添加用户
    {
        string sql = "insert into users values (N'" + username + "','" + password + "')";
        SqlConnection conn = new SqlConnection(str);
        conn.Open();
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.ExecuteNonQuery();
        conn.Close();
    }
    public void UpdateUser(string username,string password)  //更新密码
    {
        string sql = "UPDATE users SET password='" + password  + "' WHERE username=N'" + username + "'";
        SqlConnection con = new SqlConnection(str);
        con.Open();
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.ExecuteNonQuery();
        con.Close();
    }
    public string FindPwd(string username)
    {
        string sql = "select password from users where username = N'" + username + "'";
        SqlConnection conn = new SqlConnection(str);
        System.Data.DataTable dt = new DataTable();
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);
        da.Fill(dt);
        conn.Close();
        return dt.Rows[0][0].ToString();
    }
}