<%@ Page Title="" Language="C#" MasterPageFile="~/Zone/MasterPage.master" AutoEventWireup="true" CodeFile="SaySayList.aspx.cs" Inherits="Zone_SaySay_SaySayList" validateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br /><br />
    <div id="divMaster" runat="server">
        <div style="border:solid 1px;color:#afae88;width:500px"></div><br />
    <span style="color:#cd8611">我的说说</span><br /><br />
    <div id="Guest_Message"></div>
    <script type="text/javascript" src="../wangEditor.min.js"></script>
    <script type="text/javascript">
        var E = window.wangEditor
        var editor = new E('#Guest_Message')
        function Get() {
            var html = document.getElementById('ContentPlaceHolder1_HF_html');
            html.value = editor.txt.html();
            var txt = document.getElementById('ContentPlaceHolder1_HF_txt');
            txt.value = editor.txt.text();
        }
        editor.create()
    </script>
        <asp:HiddenField ID="HF_txt" runat="server" Value="" />
        <asp:HiddenField ID="HF_html" runat="server" Value="" />
        <asp:Button ID="btn_Submit" runat="server" ForeColor="#ffffff" BackColor="#996633" Height="30px" Width="100px" Font-Size="18px" Text="发表" OnClick="btn_Submit_Click" OnClientClick="Get()"/><br /><br />
        </div>
    <div id="divGuest" runat="server">
    <asp:LinkButton ID="btn_None" runat="server" ForeColor="#3333ff" Text="TA的说说" Style="text-decoration: none"></asp:LinkButton>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:LinkButton ID="btn_BackToMine" runat="server" ForeColor="#3333ff" Style="text-decoration: none"></asp:LinkButton><br /><br />
    <div style="border:solid 1px;color:#afae88;width:600px"></div><br /><br />
        </div>
    <asp:Repeater ID="rpt_SaySay" runat="server" OnItemCommand="rpt_SaySay_ItemCommand" OnItemDataBound="rpt_SaySay_ItemDataBound">
        <ItemTemplate>
            <div style="width:800px;color:#808080"></div>
            <div style="width:800px;border-style:ridge;color:#808080">
            <asp:LinkButton ID="btn_SaySayer" runat="server" Text='<%# Eval("OwnerName") %>' Style="text-decoration: none" ForeColor="#3333ff" CommandName="GetIn" CommandArgument='<%# Eval("QQNum") %>'></asp:LinkButton>
            <br /><br />
                <div style="color:#808080;border:dotted"></div>
                <div style="width:600px;margin-left:100px">
                <asp:Label ID="Lab_SaySay" runat="server" Text='<%# Eval("Substance") %>'></asp:Label><br />
                <asp:HiddenField ID="HF_SaySayID" runat="server" Value='<%# Eval("SaySayID") %>' />
                <asp:Label ID="Lab_Time" runat="server" Text='<%# Eval("Time") %>' ForeColor="#999999"></asp:Label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <span style="color:#808080">评论(<asp:Label ID="Lab_ComNum" runat="server" Text="1"></asp:Label>)</span>&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:LinkButton ID="btn_Del_SaySay" runat="server" ForeColor="#ff0000" Text="删除" CommandName="Delete" CommandArgument='<%# Eval("SaySayID") %>'></asp:LinkButton><br /><br />
                <asp:Repeater ID="rpt_Comment" runat="server" OnItemCommand="rpt_Comment_ItemCommand" OnItemDataBound="rpt_Comment_ItemDataBound">
                    <ItemTemplate>
                        <div style="margin-left:100px;width:500px">
                            <div style="color:#808080;border-style:dotted"></div><br />
                            <asp:HiddenField ID="HF_ComID" runat="server" Value='<%# Eval("SaySay_ComID") %>'/>
                            <asp:LinkButton ID="btn_Commenter" runat="server" Style="text-decoration: none" ForeColor="#3333ff" CommandName="GetIn" CommandArgument='<%# Eval("QQNum") %>' Text='<%# Eval("VisitorName") %>'></asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;：
                            <asp:Label ID="Lab_Substance" runat="server" Text='<%# Eval("Substance") %>'></asp:Label><br /><br />
                            <asp:Label ID="Lab_Com_Time" runat="server" Text='<%# Eval("Time") %>' ForeColor="#999999"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:LinkButton ID="btn_Res_div" runat="server" ForeColor="#ff0000" Text="回复" CommandName="Res"></asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:LinkButton ID="btn_Del_Com" runat="server" ForeColor="#ff0000" Text="删除" CommandName="Delete" CommandArgument='<%# Eval("SaySay_ComID") %>'></asp:LinkButton><br /><br />
                                    <asp:Panel ID="Pan" runat="server" Visible="false">
                                        <asp:TextBox ID="txt_Res" runat="server" TextMode="MultiLine" Height="40px" Width="200px"></asp:TextBox>
                                        <asp:Button ID="btn_Res" runat="server" Text="发表" Height="30px" Width="80px" BackColor="#cc9900" ForeColor="#ffffff" Font-Size="20px" CommandName="Res_Submit" CommandArgument='<%# Eval("SaySay_ComID")+","+ Eval("SaySayID") %>'/><br /><br />
                                    </asp:Panel>
                            <asp:Repeater ID="rpt_Response" runat="server" OnItemCommand="rpt_Response_ItemCommand" OnItemDataBound="rpt_Response_ItemDataBound">
                                <ItemTemplate>
                                    <div style="margin-left:100px;width:400px">
                                        <div style="color:#808080;border-style:dotted"></div>
                                    <asp:LinkButton ID="btn_Responser" runat="server" Style="text-decoration: none" ForeColor="#3333ff" CommandName="GetIn" CommandArgument='<%# Eval("QQNum") %>' Text='<%# Eval("VisitorName") %>'></asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;：
                                    <asp:Label ID="Lab_Response" runat="server" Text='<%# Eval("Substance") %>'></asp:Label><br /><br />
                                    <asp:Label ID="Lab_Res_Time" runat="server" Text='<%# Eval("Time") %>' ForeColor="#999999"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:LinkButton ID="btn_Del_Res" runat="server" ForeColor="#ff0000" Text="删除" CommandName="Delete" CommandArgument='<%# Eval("SaySay_ComID") %>'></asp:LinkButton><br /><br />
                                        </div>
                                    </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:TextBox ID="txt_Com" runat="server" TextMode="MultiLine" placeholder="我也来说两句" Width="300px" Height="40px"></asp:TextBox>
                <asp:Button ID="btn_Com" runat="server" Text="发表" Height="30px" Width="80px" BackColor="#cc9900" ForeColor="#ffffff" Font-Size="20px" CommandName="Com" CommandArgument='<%# Eval("SaySayID") %>'/><br /><br />
                    </div>
            </div><br /><br />
            
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

