using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// SQLHelper 的摘要说明
/// </summary>
public class SQLHelper
{
    static string str = @"server=DESKTOP-F3H8PQV;Integrated Security=SSPI;database=Demo;";
    public SQLHelper()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
    public DataTable SQL_dt(string sql)  //返回表
    {
        SqlConnection conn = new SqlConnection(str);
        System.Data.DataTable dt = new DataTable();
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);
        da.Fill(dt);
        conn.Close();
        return dt;
    }
    public void SQL(string sql)
    {
        SqlConnection con = new SqlConnection(str);
        con.Open();
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.ExecuteNonQuery();
        con.Close();
    }
}