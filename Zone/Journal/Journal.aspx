<%@ Page Title="" Language="C#" MasterPageFile="~/Zone/MasterPage.master" AutoEventWireup="true" CodeFile="Journal.aspx.cs" Inherits="Zone_Journal" validateRequest="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br /><br />
    <span style="font-weight:600">日志</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:LinkButton ID="btn_Back_JournalList" runat="server" Style="text-decoration: none" Text="返回列表" ForeColor="#cc6600" OnClick="btn_Back_JournalList_Click"></asp:LinkButton><br /><br />
    <div style="border:solid 0.5px;color:#ff8c00;width:500px"></div><br />
    <asp:Label ID="Lab_JournalTitle" runat="server" Font-Size="30px"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="Lab_JournalDate" runat="server" ForeColor="#999999"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:LinkButton ID="btn_JournalEdit" runat="server" ForeColor="#cc9900" Style="text-decoration: none" OnClick="btn_JournalEdit_Click" Text="编辑"></asp:LinkButton><br /><br />
    <asp:Label ID="Lab_JournalSubstance" runat="server" Font-Size="20px"></asp:Label><br /><br />
    <div style="border:solid 1px;color:#ff8c00;width:500px"></div><br />
    <span style="font-size:20px">评论(<asp:Label ID="Lab_Num" runat="server"></asp:Label>)</span><br /><br />
    <asp:Repeater ID="rpt_Comment" runat="server" OnItemDataBound="rpt_Comment_ItemDataBound" OnItemCommand="rpt_Comment_ItemCommand">
        <ItemTemplate>
            <div id="div_Comment" runat="server" style="width:500px">
                <br />
                
            <div style="border:solid 1px;color:#999999"></div>
            <asp:Label ID="Lab_CommentID" runat="server" Visible="false" Text='<%# Eval("Journal_ComID") %>'></asp:Label>
            <span style="color:#999999">(<asp:Label ID="Lab_Count" runat="server" Text='<%# Eval("ResponseTo") %>'></asp:Label>楼)</span>
            <asp:LinkButton ID="btn_Commenter" runat="server" ForeColor="#ff0000" Style="text-decoration: none" Text='<%# Eval("VisitorName") %>' CommandName="GetIn_Comment" CommandArgument='<%#Eval("QQNum") %>'></asp:LinkButton>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <span style="color:#999999">评论时间：</span>
            <asp:Label ID="Lab_CommentDate" runat="server" ForeColor="#999999" Text='<%# Eval("Date") %>'></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:LinkButton ID="btn_CommentDelete" runat="server" ForeColor="#cc6600" Style="text-decoration: none" Text="删除" CommandName="DeleteComment" CommandArgument='<%# Eval("Journal_ComID") %>' OnClientClick="return confirm('您确定要删除吗？')"></asp:LinkButton><br /><br />
            <asp:Label ID="Lab_CommentSubstance" runat="server" Font-Size="20px" Text='<%# Eval("Substance") %>'></asp:Label><br /><br />
                <asp:Repeater ID="rpt_Response" runat="server" OnItemCommand="rpt_Response_ItemCommand" OnItemDataBound="rpt_Response_ItemDataBound">
                    <ItemTemplate>
                        <div style="margin-left:100px;width:400px">
                        <div style="border:dotted 1px;color:#999999"></div>
                        <asp:LinkButton ID="btn_Responser" runat="server" ForeColor="#ff0000" Style="text-decoration: none" Text='<%# Eval("VisitorName") %>'  CommandName="GetIn_Response" CommandArgument='<%#Eval("QQNum") %>'></asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <span style="color:#999999">评论时间：</span>
                        <asp:Label ID="CommentDate" runat="server" ForeColor="#999999" Text='<%# Eval("Date") %>'></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="btn_ResponseDelete" runat="server" ForeColor="#cc6600" Style="text-decoration: none" Text="删除" CommandName="DeleteResponse" CommandArgument='<%# Eval("Journal_ComID") %>' OnClientClick="return confirm('您确定要删除吗？')"></asp:LinkButton><br /><br />
                        <asp:Label ID="Lab_ResponseSubstance" runat="server" Font-Size="20px" Text='<%# Eval("Substance") %>'></asp:Label><br /><br />
                            </div>
                    </ItemTemplate>
                </asp:Repeater>
                </div>
            <asp:TextBox ID="txt_Com" runat="server" TextMode="MultiLine" placeholder="我也来说两句吧"></asp:TextBox>
            <asp:Button ID="btn_Com" runat="server" CommandName="Write" Text="回复" CommandArgument='<%# Eval("JournalID")+","+Eval("Journal_ComID") %>'/><br /><br />
        </ItemTemplate>
    </asp:Repeater>
    <br />
    <div id="divPage" runat="server">
        <asp:Button ID="btnFirstPage" runat="server" Text="首页" OnClick="btnFirstPage_Click" />
        <asp:Button ID="btnUpPage" runat="server" Text="上一页" OnClick="btnUpPage_Click" />
        <asp:Button ID="btnDownPage" runat="server" Text="下一页" OnClick="btnDownPage_Click" />
        <asp:Button ID="btnLastPage" runat="server" Text="尾页" OnClick="btnLastPage_Click" />
        页次<asp:Label ID="NowPage" runat="server" Text="1"></asp:Label>
        /<asp:Label ID="TotalPage" runat="server" Text="1"></asp:Label>
        转<asp:TextBox ID="txtJumpPage" runat="server" Width="16px"></asp:TextBox>
        <asp:Button ID="btnJump" runat="server" Text="跳转" OnClick="btnJump_Click" /><br /><br />
        </div>
    <span style="font-size:20px">发表评论</span><br /><br />
    <div id="divGuest" runat="server" visible="true">
    <div id="Guest_Message"></div>
    <script type="text/javascript" src="../wangEditor.min.js"></script>
    <script type="text/javascript">
        var E = window.wangEditor
        var editor = new E('#Guest_Message')
        function Get() {
            var text = document.getElementById('ContentPlaceHolder1_HF_Count');
            text.value = editor.txt.text();
            var txt = document.getElementById('ContentPlaceHolder1_HF_Substance');
            txt.value = editor.txt.html();
        }
        editor.create()
    </script>
        </div>
    <asp:HiddenField ID="HF_Substance" runat="server" Value=""/>
    <asp:HiddenField ID="HF_Count" runat="server" Value=""/>
    <asp:Button ID="btn_Submit" runat="server" ForeColor="#ffffff" BackColor="#ff9933" Height="30px" Width="80px" Font-Size="18px" Text="发表" OnClick="btn_Submit_Click" OnClientClick="Get()"/>
</asp:Content>

