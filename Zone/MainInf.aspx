<%@ Page Title="" Language="C#" MasterPageFile="~/Zone/MasterPage.master" AutoEventWireup="true" CodeFile="MainInf.aspx.cs" Inherits="MainInf" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="div_Look" runat="server">
    <span style="font-size:20px;font-weight:600">基本资料</span>
    <asp:LinkButton ID="btn_Change" runat="server" ForeColor="#cc9900" Style="text-decoration: none" Text="修改" OnClick="btn_Change_Click"></asp:LinkButton><br />
     <div style="border:solid 1px #ccc;color:#ff9f00"></div><br />
        性别：<asp:Label ID="lab_Sex" runat="server"></asp:Label><br /><br />
        年龄：<asp:Label ID="lab_Age" runat="server"></asp:Label><br /><br />
        生日：<asp:Label ID="lab_Birthday" runat="server"></asp:Label><br /><br />
        星座：<asp:Label ID="lab_Constellation" runat="server"></asp:Label><br /><br />
        血型：<asp:Label ID="lab_BloodType" runat="server"></asp:Label>
    </div>
    <div id="div_Change" runat="server" visible="false">
        <span style="font-size:20px;font-weight:600">基本资料</span><br /><br />
        昵称：<asp:TextBox ID="txt_UserName" runat="server" BorderStyle="Ridge"></asp:TextBox><br /><br />
        <div style="border:solid 1px #ccc;color:#ff9f00"></div><br />
        性别：<asp:RadioButtonList ID="SelSex" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
              <asp:ListItem ID="male" value="1" runat="server">男</asp:ListItem>
              <asp:ListItem ID="female" value="0" runat="server">女</asp:ListItem>
              </asp:RadioButtonList><br /><br />
        <div style="border:solid 1px #ccc;color:#ff9f00"></div><br />
        生日：<asp:Calendar ID="Cal_Birthday" runat="server"></asp:Calendar><br />
        <div style="border:solid 1px #ccc;color:#ff9f00"></div><br />
        星座：<asp:Label ID="lab_Con" runat="server"></asp:Label><br /><br />
        <div style="border:solid 1px #ccc;color:#ff9f00"></div><br />
        血型：<asp:RadioButtonList ID="SelType" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
              <asp:ListItem ID="LT_A" value="A型" runat="server">A型</asp:ListItem>
              <asp:ListItem ID="LT_B" value="B型" runat="server">B型</asp:ListItem>
              <asp:ListItem ID="LT_O" value="O型" runat="server">O型</asp:ListItem>
              <asp:ListItem ID="LT_AB" value="AB型" runat="server">AB型</asp:ListItem>
              <asp:ListItem ID="LT_其他" Value="其他 " runat="server">其他</asp:ListItem>
              </asp:RadioButtonList><br /><br />
         <asp:Button ID="btn_Submit" runat="server" BackColor="#ff9900" ForeColor="#ffffff" BorderStyle="Ridge" Text="保存" OnClick="btn_Submit_Click" Height="30px" Width="100px" Font-Size="15px"></asp:Button>
    </div>
</asp:Content>

