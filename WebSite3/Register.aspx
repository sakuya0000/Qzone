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
    用户名：
        <asp:TextBox ID="txtUsername" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
    密码：
        <asp:TextBox ID="txtPwd_O" runat="server" TextMode="Password"></asp:TextBox>
        <br />
    确认密码：
        <asp:TextBox ID="txtPwd_R" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
        验证码：
    <asp:TextBox ID="tbx_yzm" runat="server" Width="70px"></asp:TextBox>
    <asp:ImageButton ID="ibtn_yzm" runat="server" Width="70px" />
    <a href="javascript:changeCode()"style="text-decoration: underline; font-size:10px;">换一张</a>
    <script type="text/javascript">
        function changeCode() 
        {
            document.getElementById('ibtn_yzm').src = document.getElementById('ibtn_yzm').src + '?';
        }
    </script>
         <br />
    <asp:Button ID="btnSubmit" runat="server" Text="提交" OnClick="btnSubmit_Click" />
    <asp:Button ID="btnBack" runat="server" Text="返回" OnClick="btnBack_Click" />
    </div>
    </form>
</body>
</html>
