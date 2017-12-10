<%@ Page Title="" Language="C#" MasterPageFile="~/Zone/MasterPage.master" AutoEventWireup="true" CodeFile="JournalList.aspx.cs" Inherits="JournalList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
    <div>
    <span style="font-size:20px">我的日志</span><br /><br />
    <asp:Button ID="btn_Wirte" runat="server" ForeColor="#ffffff" BackColor="#ff9933" Height="35px" Width="100px" BorderStyle="Ridge" Text="写日志" OnClick="btn_Wirte_Click" Font-Size="15px"/><br /><br />
    <div style="border:solid 0.5px;color:#ffca00"></div><br />
    <asp:Repeater ID="rpt_Journal" runat="server" OnItemCommand="rpt_Journal_ItemCommand" OnItemDataBound="rpt_Journal_ItemDataBound">
        <ItemTemplate>
            <asp:LinkButton ID="btn_Title" runat="server" Text='<%# Eval("Title") %>' CommandName="GetIn" CommandArgument='<%# Eval("JournalID") %>'></asp:LinkButton>
            <asp:Label ID="lab_Date" runat="server" Text='<%# Eval("Date") %>' ForeColor="#999999"></asp:Label>
            <asp:LinkButton ID="btn_Del" runat="server" Text="删除" ForeColor="#ff0000" CommandName="Del" CommandArgument='<%# Eval("JournalID") %>' OnClientClick="return confirm('确定删除吗？')"></asp:LinkButton><br /><br />
        </ItemTemplate>
    </asp:Repeater>
        <asp:Button ID="btnFirstPage" runat="server" Text="首页" OnClick="btnFirstPage_Click" />
        <asp:Button ID="btnUpPage" runat="server" Text="上一页" OnClick="btnUpPage_Click" />
        <asp:Button ID="btnDownPage" runat="server" Text="下一页" OnClick="btnDownPage_Click" />
        <asp:Button ID="btnLastPage" runat="server" Text="尾页" OnClick="btnLastPage_Click" />
        页次<asp:Label ID="NowPage" runat="server" Text="1"></asp:Label>
        /<asp:Label ID="TotalPage" runat="server" Text="1"></asp:Label>
        转<asp:TextBox ID="txtJumpPage" runat="server" Width="16px"></asp:TextBox>
        <asp:Button ID="btnJump" runat="server" Text="跳转" OnClick="btnJump_Click" />
        <br />
    </div>
</asp:Content>

