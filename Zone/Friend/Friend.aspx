<%@ Page Title="" Language="C#" MasterPageFile="~/Zone/MasterPage.master" AutoEventWireup="true" CodeFile="Friend.aspx.cs" Inherits="Zone_Friend_Friend" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br /><br />
    <asp:Button ID="btn_MyFriend" runat="server" Text="好友首页" Height="35px" Width="150px" Font-Size="20px" BackColor="#ffff66" OnClick="btn_MyFriend_Click"></asp:Button>
    <asp:Button ID="btn_FindFriend" runat="server" Text="寻找好友" Height="35px" Width="150px" Font-Size="20px" BackColor="#ffff66" OnClick="btn_FindFriend_Click"></asp:Button>
    <asp:Button ID="btn_RequestFriend" runat="server" Text="好友请求" Height="35px" Width="150px" Font-Size="20px" BackColor="#ffff66" OnClick="btn_QuestFriend_Click"></asp:Button>
    <br /><br />
    <div id="div_MyFriend" runat="server" visible="true">
        <asp:Repeater ID="rpt_MyFriend" runat="server" OnItemCommand="rpt_MyFriend_ItemCommand">
            <ItemTemplate>
                <asp:Label ID="Lab_Count" runat="server" Text='<%# Eval("QQNum") %>' Font-Size="20px"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:LinkButton ID="btn_FriendName" runat="server" Text='<%# Eval("FriendUserName") %>' ForeColor="#999999" Font-Size="20px" CommandName="GetIn" CommandArgument='<%# Eval("FriendQQNum") %>'></asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:LinkButton ID="btn_Del" runat="server" Text="删除" ForeColor="#ff0000" Font-Size="20px" CommandName="Del" CommandArgument='<%# Eval("FriendQQNum") %>' OnClientClick="return confirm('确定删除吗？')"></asp:LinkButton><br /><br />

            </ItemTemplate>
        </asp:Repeater>
        <div id="div_Page_MyFriend" runat="server">
    <asp:Button ID="btnFirstPage1" runat="server" Text="首页" OnClick="btnFirstPage_Click" />
        <asp:Button ID="btnUpPage1" runat="server" Text="上一页" OnClick="btnUpPage_Click" />
        <asp:Button ID="btnDownPage1" runat="server" Text="下一页" OnClick="btnDownPage_Click" />
        <asp:Button ID="btnLastPage1" runat="server" Text="尾页" OnClick="btnLastPage_Click" />
        页次<asp:Label ID="NowPage1" runat="server" Text="1"></asp:Label>
        /<asp:Label ID="TotalPage1" runat="server" Text="1"></asp:Label>
        转<asp:TextBox ID="txtJumpPage1" runat="server" Width="16px"></asp:TextBox>
        <asp:Button ID="btnJump1" runat="server" Text="跳转" OnClick="btnJump_Click" />
        <br /></div>
    </div>
    <div id="div_FindFriend" runat="server" visible="false">
        <asp:TextBox ID="txtUserName" runat="server" placeholder="请输入昵称"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btn_Find" runat="server" Text="寻找" OnClick="btn_Find_Click"/><br /><br />
        <asp:Repeater ID="rpt_ResultList" runat="server" OnItemCommand="rpt_ResultList_ItemCommand">
            <ItemTemplate>
                <asp:LinkButton ID="btn_QQNum" runat="server" ForeColor="#999999" Font-Underline="false" Text='<%# Eval("QQNum") %>' Font-Size="25px" CommandName="GetIn" CommandArgument='<%# Eval("QQNum") %>'></asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:LinkButton ID="btn_UserName" runat="server" ForeColor="#999999" Font-Underline="false" Text='<%# Eval("UserName") %>' Font-Size="25px" CommandName="GetIn" CommandArgument='<%# Eval("QQNum") %>'></asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btn_Request" runat="server" ForeColor="#ffffff" BackColor="#ffcc66" Text="加好友" CommandName="Request" CommandArgument='<%# Eval("QQNum")+","+Eval("UserName") %>' />
                <%#((Container.ItemIndex+1)%5!=0) ? "&nbsp;&nbsp;&nbsp;&nbsp;":""%>
                <%#((Container.ItemIndex + 1) % 5 == 0 && Container.ItemIndex > 0) ? "<br/><br/>" : ""%>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <div id="div_RequestFriend" runat="server" visible="false">
        <asp:Repeater ID="rpt_FriendsQuest" runat="server" OnItemCommand="rpt_FriendsQuest_ItemCommand">
            <ItemTemplate>
                <span style="color:#999999"><asp:LinkButton ID="btn_RequestUserName" runat="server" Text='<%# Eval("UserName") %>' Font-Underline="false" CommandName="GetIn" CommandArgument='<%# Eval("QQNum") %>'></asp:LinkButton></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btn_Agree" runat="server" Text="同意" BackColor="#ffff99" CommandName="Agree" CommandArgument='<%# Eval("EventID")+","+Eval("QQNum")+","+Eval("RequestToUserName")+","+Eval("UserName")%>' />
                <asp:Button ID="btn_Disagree" runat="server" Text="拒绝" CommandName="Disagree" CommandArgument='<%# Eval("EventID") %>' /><br /><br />
                <div style="color:#808080;border-style:dotted;width:500px"></div><br /><br />
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>

