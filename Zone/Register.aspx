<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div id="div_FirstPage" runat="server" visible="true">
            &nbsp;<span style="font-size:40px">欢迎注册QQ</span><br /><br />
            &nbsp;<span style="font-size:25px">每一天，乐在沟通。</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;<asp:LinkButton ID="btn_Create_QQNiceNum" runat="server" ForeColor="#3399ff" Style="text-decoration: none" Text="免费靓号" Font-Size="25px" OnClick="btn_Create_QQNiceNum_Click"></asp:LinkButton><br />
        </div>
        <div id="div_SecondPage" runat="server" visible="false">
            &nbsp;<span style="font-size:40px">QQ免费靓号</span><br /><br />
            &nbsp;<span>注册指引:</span><br /><br />
            &nbsp;<span style="color:#999999">1.注册完成后，登录QQ手机版，完成激活</span><br />
            &nbsp;<span style="color:#999999">2.一周内未激活帐号，系统将自动回收</span><br /><br />
            &nbsp;<span style="font-size:25px">精品靓号</span>&nbsp;&nbsp;
            <asp:Label ID="lab_QQNiceName" runat="server" ForeColor="#999999" Font-Size="30px"></asp:Label>&nbsp;&nbsp;
            <span style="font-size:15px;color:#999999">（9位靓号）</span>&nbsp;&nbsp;
            <asp:LinkButton ID="btn_Change_QQNiceNum" runat="server" ForeColor="#3399ff" Style="text-decoration: none" Text="换一个" OnClick="btn_Change_QQNiceNum_Click"></asp:LinkButton>
        </div>
        <br />
        &nbsp;<asp:TextBox ID="txtUserName" runat="server" BorderStyle="Ridge" Font-Size="20px" Height="35px" Width="400px" placeholder="昵称"></asp:TextBox><br /><br />
        &nbsp;<asp:TextBox ID="txtPassword" runat="server" BorderStyle="Ridge" Font-Size="20px" Height="35px" Width="400px" placeholder="密码"></asp:TextBox><br /><br />
        <table>
        <tr>
        <td><asp:TextBox ID="tbx_yzm" runat="server" Width="260px" placeholder="验证码" Height="35px" BorderStyle="Ridge" Font-Size="20px"></asp:TextBox></td>
        <td><asp:ImageButton ID="ibtn_yzm" runat="server" Width="70px" Height="35px"/></td>
        <td><a href="javascript:changeCode()"style="text-decoration: none; font-size:20px;">换一张</a></td>
            </tr>
            </table>
        <script type="text/javascript">
        function changeCode() 
        {
            document.getElementById('ibtn_yzm').src = document.getElementById('ibtn_yzm').src + '?';
        }
    </script>
        <br />
        &nbsp;<asp:Button ID="btn_Register" runat="server" Text="立即注册" ForeColor="#ffffff" BorderStyle="Ridge" BackColor="#3399ff" OnClick="btn_Register_Click" Width="400px" Height="40px" Font-Size="20px"/>
    </div>
    </form>
</body>
</html>
