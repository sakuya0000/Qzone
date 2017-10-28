<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChangePwd.aspx.cs" Inherits="ChangePwd" %>

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
    原密码：
        <asp:TextBox ID="txtPwd" runat="server" TextMode="Password"></asp:TextBox>
        <br />
    修改密码：
        <asp:TextBox ID="txtPwd_O" runat="server" TextMode="Password"></asp:TextBox>
        <br />
    确认密码：
        <asp:TextBox ID="txtPwd_R" runat="server" TextMode="Password"></asp:TextBox>
        <br />
        <asp:Button ID="btnChange" runat="server" Text="修改" OnClick="btnChange_Click" />
        <asp:Button ID="btnBack" runat="server" Text="返回" OnClick="btnBack_Click" />
    </div>
    </form>
</body>
</html>
