<%@ Page Title="" Language="C#" MasterPageFile="~/Zone/MasterPage.master" AutoEventWireup="true" CodeFile="FileList.aspx.cs" Inherits="Zone_Album_FileList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="divFileList" runat="server">
        <span style="font-size:25px">相册</span><br /><br />
        <div id="div_FirstPage" runat="server">
        <asp:Button ID="btn_CreateAlbum" runat="server" BackColor="#996633" ForeColor="#ffffff" Font-Size="20px" Width="100px" Height="30px" Text="创建相册" OnClick="btn_CreateAlbum_Click"/><br />
        <br />
            <asp:Repeater ID="rpt_FileList" runat="server" OnItemCommand="rpt_FileList_ItemCommand" OnItemDataBound="rpt_FileList_ItemDataBound1">
                <ItemTemplate>
                    <asp:LinkButton ID="btn_Album" runat="server" Font-Size="20px" ForeColor="#ff3300" Text='<%# Eval("QQNum") %>' CommandName="GetIn" CommandArgument='<%# Eval("FileName") %>'></asp:LinkButton>&nbsp;&nbsp;
                    <asp:LinkButton ID="btn_Delete" runat="server" Font-Size="15px" ForeColor="#999999" Text="删除" OnClientClick="return confirm('删除相册后您所相册所在文件也将全部删除！您确定要删除吗？')" CommandName="Delete" CommandArgument='<%# Eval("FileName") %>'></asp:LinkButton>
                    <%#((Container.ItemIndex+1)%9!=0) ? "&nbsp;&nbsp;&nbsp;&nbsp;":""%>
                    <%#((Container.ItemIndex + 1) % 9 == 0 && Container.ItemIndex > 0) ? "<br/><br/>" : ""%>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <div id="div_SecondPage" runat="server" visible="false">
            <asp:TextBox ID="txt_AlbumName" runat="server"></asp:TextBox><br /><br />
            <asp:Button ID="btn_Submit" runat="server" ForeColor="#ffffff" BackColor="#cc6600" Height="25px" Width="50px" Text="创建" OnClick="btn_Submit_Click"/>
        </div>
    </div>
</asp:Content>

