<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Zone_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <span style="font-size:30px;">帐号密码登录</span><br /><br />
        &nbsp;<asp:TextBox ID="txtQQNum" runat="server" BorderStyle="Ridge" Font-Size="20px" Height="35px" Width="400px" placeholder="QQ号"></asp:TextBox><br /><br />
        &nbsp;<asp:TextBox ID="txtPassword" runat="server" BorderStyle="Ridge" Font-Size="20px" Height="35px" Width="400px" placeholder="密码" TextMode="Password"></asp:TextBox><br /><br />
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
        <asp:Button ID="btn_Login" runat="server" Text="登录" OnClick="btn_Login_Click" ForeColor="#ffffff" BackColor="#3399ff" Width="100px" Height="35px" BorderStyle="Ridge"/>&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btn_Register" runat="server" Text="注册" OnClick="btn_Register_Click" ForeColor="#ffffff" BackColor="#3399ff" Width="100px" Height="35px" BorderStyle="Ridge"/>
    </div>
    </form>
</body>
</html>
