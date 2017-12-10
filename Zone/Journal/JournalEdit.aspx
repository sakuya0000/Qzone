<%@ Page Title="" Language="C#" MasterPageFile="~/Zone/MasterPage.master" AutoEventWireup="true" CodeFile="JournalEdit.aspx.cs" Inherits="Zone_Journal_JournalEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br /><br />
    <asp:TextBox ID="txtTitle" runat="server" placeholder="请在这里输入日志标题" Height="35px" Width="800px" Font-Size="25px" BorderStyle="Ridge"></asp:TextBox><br /><br />
    <asp:TextBox ID="txtWrite" runat="server" TextMode="MultiLine" Height="400px" Width="800px" Font-Size="20px" BorderStyle="Ridge"></asp:TextBox><br /><br />
    <asp:Button ID="btn_Submit" runat="server" ForeColor="#ffffff" BackColor="#3399ff" Width="80px" Height="25px" Text="发表" OnClick="btn_Submit_Click" />&nbsp;
    <asp:Button ID="btn_Cancel" runat="server" Height="25px" Text="取消" OnClick="btn_Cancel_Click"/>
</asp:Content>

