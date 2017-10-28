<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FindPwd.aspx.cs" Inherits="FindPwd" %>

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
    密保问题：
        <asp:Button ID="btnFind" runat="server" Text="提交" OnClick="btnFind_Click" />
        <asp:Button ID="btnBack" runat="server" Text="返回" OnClick="btnBack_Click" />
    </div>
    </form>
</body>
</html>
