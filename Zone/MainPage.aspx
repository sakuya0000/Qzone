﻿<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="MainPage.aspx.cs" Inherits="MainPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Repeater ID="rpt_MyNewEvents" runat="server" OnItemCommand="rpt_MyNewEvents_ItemCommand">
        <ItemTemplate>
            <div style="border-style:ridge;width:800px">
                <div style="margin-left:100px;width:600px"><br />
                    <asp:LinkButton ID="btn_UserName" runat="server" Font-Size="25px" Text='<%# Eval("UserName") %>' Font-Underline="false" CommandName="GetIn" ForeColor="#ff0000"></asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Label ID="Lab_New" runat="server" Text='<%# Eval("Message") %>' Font-Size="25px"></asp:Label><br /><br />
                    <asp:Image ID="Ima1" runat="server" ImageUrl='<%# Eval("Image1") %>' Width="600px"/><br /><br />
                    <asp:Label ID="Lab_Substance" runat="server" Text='<%# Eval("Substance") %>' Font-Size="25px"></asp:Label><br /><br />
                    <asp:Label ID="Lab_Time" runat="server" Text='<%# Eval("Time") %>' ForeColor="#999999"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btn_Read" runat="server" ForeColor="#ff0000" Text="查看详情" CommandName="Read" CommandArgument='<%# Eval("EventType")+","+Eval("EventID") %>'></asp:LinkButton><br /><br />
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    <div id="div_Page" runat="server">
    <asp:Button ID="btnFirstPage" runat="server" Text="首页" OnClick="btnFirstPage_Click" />
        <asp:Button ID="btnUpPage" runat="server" Text="上一页" OnClick="btnUpPage_Click" />
        <asp:Button ID="btnDownPage" runat="server" Text="下一页" OnClick="btnDownPage_Click" />
        <asp:Button ID="btnLastPage" runat="server" Text="尾页" OnClick="btnLastPage_Click" />
        页次<asp:Label ID="NowPage" runat="server" Text="1"></asp:Label>
        /<asp:Label ID="TotalPage" runat="server" Text="1"></asp:Label>
        转<asp:TextBox ID="txtJumpPage" runat="server" Width="16px"></asp:TextBox>
        <asp:Button ID="btnJump" runat="server" Text="跳转" OnClick="btnJump_Click" />
        <br /></div>
</asp:Content>

