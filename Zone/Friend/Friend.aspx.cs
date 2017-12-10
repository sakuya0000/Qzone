using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Zone_Friend_Friend : System.Web.UI.Page
{
    static SQLHelper us = new SQLHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["QQNum"] == null || Session["VisitingQQNum"] == null)
                Response.Redirect("../Login.aspx");
            string VisitingQQNum = Session["VisitingQQNum"].ToString();
            string QQNum = Session["QQNum"].ToString();
            if (VisitingQQNum != QQNum)
                Response.Redirect("/Zone/MainPage.aspx");
            DataBindTorpt_MyFriend(1);
        }
    }
    protected void DataBindTorpt_MyFriend(int current)  //我的好友页数据绑定
    {
        string QQNum = Session["QQNum"].ToString();
        string sql = "SELECT * FROM QQFriends WHERE QQNum='" + QQNum + "'";
        DataTable dt = us.SQL_dt(sql);
        if (dt.Rows.Count == 0)
            div_Page_MyFriend.Visible = false;
        for(int i = 0; i < dt.Rows.Count; i++)
        {
            dt.Rows[i][0] = i + 1;
        }
        PagedDataSource pds = new PagedDataSource();
        pds.AllowPaging = true;
        pds.PageSize = 10;
        pds.DataSource = dt.DefaultView;
        TotalPage1.Text = pds.PageCount.ToString();
        pds.CurrentPageIndex = current - 1;
        rpt_MyFriend.DataSource = pds;
        rpt_MyFriend.DataBind();
    }
    protected void btnFirstPage_Click(object sender, EventArgs e)  //首页
    {
        int current = 1;
        NowPage1.Text = current.ToString();
        DataBindTorpt_MyFriend(current);
    }

    protected void btnUpPage_Click(object sender, EventArgs e)  //上一页
    {
        int current = Convert.ToInt32(NowPage1.Text) - 1;
        if (current >= 1)
        {
            NowPage1.Text = current.ToString();
            DataBindTorpt_MyFriend(current);
        }
    }

    protected void btnDownPage_Click(object sender, EventArgs e)  //下一页
    {
        int current = Convert.ToInt32(NowPage1.Text);
        current++;
        if (current <= Convert.ToInt32(TotalPage1.Text))
        {
            NowPage1.Text = current.ToString();
            DataBindTorpt_MyFriend(current);
        }
    }

    protected void btnLastPage_Click(object sender, EventArgs e)  //尾页
    {
        int current = Convert.ToInt32(TotalPage1.Text);
        NowPage1.Text = current.ToString();
        DataBindTorpt_MyFriend(current);
    }

    protected void btnJump_Click(object sender, EventArgs e)  //跳页
    {
        try
        {
            int current = Convert.ToInt32(txtJumpPage1.Text);
            if (current >= 1 && current <= Convert.ToInt32(TotalPage1.Text))
            {
                NowPage1.Text = current.ToString();
                DataBindTorpt_MyFriend(current);
            }
            else
                Response.Write("<script>alert('请输入正确的数字！')</script>");
        }
        catch
        {
            Response.Write("<script>alert('请输入数字！')</script>");
        }
    }

    protected void btn_MyFriend_Click(object sender, EventArgs e)  //我的好友页
    {
        div_MyFriend.Visible = true;
        div_FindFriend.Visible = false;
        div_RequestFriend.Visible = false;
    }

    protected void btn_FindFriend_Click(object sender, EventArgs e)  //寻找好友页
    {
        div_FindFriend.Visible = true;
        div_MyFriend.Visible = false;
        div_RequestFriend.Visible = false;
    }

    protected void btn_QuestFriend_Click(object sender, EventArgs e)  //查看请求页
    {
        div_MyFriend.Visible = false;
        div_RequestFriend.Visible = true;
        div_FindFriend.Visible = false;
        DataBindTorpt_FriendsQuest();
    }

    protected void rpt_MyFriend_ItemCommand(object source, RepeaterCommandEventArgs e)  //进入好友页
    {
        if (e.CommandName == "GetIn")
        {
            string VisitingQQNum = e.CommandArgument.ToString();
            Session["VisitingQQNum"] = VisitingQQNum;
            Response.Redirect("../MainPage.aspx");
        }
        else if (e.CommandName == "Del")
        {
            string QQNum = Session["QQNum"].ToString();
            string FriendQQNum = e.CommandArgument.ToString();
            string sql = "DELETE FROM QQFriends WHERE QQNum='" + QQNum + "'AND FriendQQNum='" + FriendQQNum + "'";
            us.SQL(sql);
            Response.Redirect("Friend.aspx");
        }
    }
    protected void DataBindTorpt_ResultList(string UserName)  //寻找好友数据绑定
    {
        string QQNum = Session["QQNum"].ToString();
        //string sql = "SELECT * FROM Users WHERE UserName='" + UserName + "' AND QQNum <> '"+QQNum+"'";
        //DataTable dt = us.SQL_dt(sql);
        SqlConnection connection = new SqlConnection("server=DESKTOP-KH8JE5M;Integrated Security=SSPI;database=QZone;");
        connection.Open();
        SqlCommand cmd = new SqlCommand("SELECT * FROM Users WHERE UserName= @UserName AND QQNum <> '"+QQNum+"'", connection);
        cmd.Parameters.AddWithValue("@UserName", UserName);
        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        adapter.Fill(dt);
        connection.Close();

        rpt_ResultList.DataSource = dt;
        rpt_ResultList.DataBind();
    }
    protected void rpt_ResultList_ItemCommand(object source, RepeaterCommandEventArgs e)  //寻找好友点击事件
    {
        if (e.CommandName == "GetIn")
        {
            string VisitingQQNum = e.CommandArgument.ToString();
            Session["VisitingQQNum"] = VisitingQQNum;
            Response.Redirect("../MainPage.aspx");
        }
        else if (e.CommandName == "Request")
        {
            string[] temp = e.CommandArgument.ToString().Split(',');
            string QQNum = Session["QQNum"].ToString();
            string FriendQQNum = temp[0];
            string FriendUserName = temp[1];
            string sql = "SELECT * FROM QQFriends WHERE QQNum='" + QQNum + "' AND FriendQQNum='" + FriendQQNum + "'";
            DataTable dt = us.SQL_dt(sql);
            if (dt.Rows.Count == 0)
            {
                sql = "SELECT * FROM QQFriends_Request WHERE QQNum='" + QQNum + "' AND Status=N'申请中' AND RequestToQQNum='"+FriendQQNum+"'";
                dt = us.SQL_dt(sql);
                if (dt.Rows.Count == 0)
                {
                    sql = "SELECT * FROM QQFriends_Request WHERE RequestToQQNum='" + QQNum + "' AND QQNum='" + FriendQQNum + "'";
                    dt = us.SQL_dt(sql);
                    if (dt.Rows.Count == 0)
                    {
                        sql = "SELECT UserName FROM Users WHERE QQNum='" + QQNum + "'";
                        DataTable d = us.SQL_dt(sql);
                        string UserName = d.Rows[0][0].ToString();
                        string Time = DateTime.Now.ToString();
                        sql = "INSERT INTO QQFriends_Request(QQNum,UserName,RequestToQQNum,RequestToUserName,Time,Status) VALUES('" + QQNum + "','" + UserName + "','" + FriendQQNum + "','" + FriendUserName + "','" + Time + "',N'申请中')";
                        us.SQL(sql);
                        Response.Write("<script>alert('等待对方通过申请！');location='Friend.aspx'</script>");
                    }
                    else
                        Response.Write("<script>alert('对方已向你提出申请！\\n请到好友申请页面同意申请！')</script>");
                }
                else
                    Response.Write("<script>alert('你已提交申请，请耐心等候！')</script>");
            }
            else
                Response.Write("<script>alert('你们已是好友！')</script>");
        }
    }

    protected void btn_Find_Click(object sender, EventArgs e)  //寻找
    {
        string UserName = txtUserName.Text;
        DataBindTorpt_ResultList(UserName);
    }
    protected void DataBindTorpt_FriendsQuest()
    {
        string QQNum = Session["QQNum"].ToString();
        string sql = "SELECT * FROM QQFriends_Request WHERE RequestToQQNum='" + QQNum + "' AND Status=N'申请中' ORDER BY Time DESC";
        DataTable dt = us.SQL_dt(sql);
        rpt_FriendsQuest.DataSource = dt;
        rpt_FriendsQuest.DataBind();
    }

    protected void rpt_FriendsQuest_ItemCommand(object source, RepeaterCommandEventArgs e)  //申请处理
    {
        if (e.CommandName == "Agree")
        {
            string[] temp = e.CommandArgument.ToString().Split(',');
            int EventID = Convert.ToInt32(temp[0]);
            string QQNum = Session["QQNum"].ToString();
            string QQNumF = temp[1];
            string UserNameF = temp[2];
            string UserName = temp[3];
            string sql = "INSERT INTO QQFriends VALUES('" + QQNum + "','" + QQNumF + "','" + UserName + "')";
            us.SQL(sql);
            sql = "INSERT INTO QQFriends VALUES('" + QQNumF + "','" + QQNum + "','" + UserNameF + "')";
            us.SQL(sql);
            sql = "DELETE FROM QQFriends_Request WHERE EventID='" + EventID + "'";
            us.SQL(sql);
            Response.Redirect("Friend.aspx");
        }
        else if(e.CommandName== "Disagree")
        {
            int EventID =Convert.ToInt32(e.CommandArgument.ToString());
            string sql = "DELETE FROM QQFriends_Request WHERE EventID='" + EventID + "'";
            Response.Redirect("Friend.aspx");
        }
        else if(e.CommandName== "GetIn")
        {
            string QQNum = e.CommandArgument.ToString();
            Session["VisitingQQNum"] = QQNum;
            Response.Redirect("../MainPage.aspx");
        }
    }
}