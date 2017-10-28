<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Main.aspx.cs" Inherits="test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div >
        用户名：
        <asp:TextBox ID="txtUsername" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
         密码：&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtPwd" runat="server" TextMode="Password"></asp:TextBox>
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
        <asp:Button ID="btnLogin" runat="server" text="登录" OnClick="btnLogin_Click"/>
          <asp:Button ID="btnReg" runat="server" text="注册" OnClick="btnReg_Click"/>
         <br />
          <asp:Button ID="btnChange1" runat="server" text="修改密码" OnClick="btnChange1_Click"/>
          <asp:Button ID="btnFind1" runat="server" text="找回密码" OnClick="btnFind1_Click"/>
    </div>
    
    </form>
</body>
</html>
