<%@ Page Title="" Language="C#" MasterPageFile="~/Zone/MasterPage.master" AutoEventWireup="true" CodeFile="Message_Board.aspx.cs" Inherits="Zone_Message_Board_Message_Board" validateRequest="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
    <span style="font-size:25px;color:#ffb100">留言板</span>
    <div id="divGuest" runat="server" visible="true">
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
    <asp:HiddenField ID="HF_html" runat="server" Value="" />
    <asp:HiddenField ID="HF_txt" runat="server" Value="" />
    <asp:Button ID="btn_GuestSubmit" runat="server" OnClick="btn_GuestSubmit_Click" OnClientClick="Get()" Height="30px" Width="80px" BackColor="#ff9900" ForeColor="#ffffff" Text="发表" Font-Size="18px"/>
        </div>
    <div id="divGeneral" runat="server">
        <br />
        <span style="font-size:25px;font-weight:600">留言（<asp:Label ID="Lab_Num" runat="server" Font-Size="25px" ></asp:Label>）</span><br /><br />
        
        <asp:Repeater ID="rpt_Message" runat="server" OnItemCommand="rpt_Message_ItemCommand" OnItemDataBound="rpt_Message_ItemDataBound">
            <ItemTemplate>
                <div runat="server" style="width:400px">
                    <div style="border:solid 1px;color:#ffb100"></div><br />
                    <asp:HiddenField ID="MessageID" Value='<%# Eval("Message_BoradID") %>' runat="server" />
                    <span style="color:#ffb100">(<asp:Label ID="Lab_Count" runat="server" Text='<%# Eval("ResponseToID") %>'></asp:Label>楼)</span>
                    <asp:LinkButton ID="btn_Visitor" runat="server" ForeColor="#cc9900" Style="text-decoration: none" Text='<%# Eval("UserName") %>' CommandName="GetIn" CommandArgument='<%# Eval("Owner_QQNum") %>'></asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Label ID="Lab_Time" runat="server" Text='<%# Eval("Time") %>' ForeColor="#999999"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btn_Delete" runat="server" ForeColor="#cc9900" Style="text-decoration: none" Text="删除" CommandName="Delete" CommandArgument='<%# Eval("Message_BoradID") %>'></asp:LinkButton><br /><br />
                    <asp:Label ID="Lab_Substance" runat="server" Text='<%# Eval("Substance") %>'></asp:Label><br /><br />
                    
                        
                    </div>
                    <asp:Repeater ID="rpt_Response" runat="server" OnItemCommand="rpt_Response_ItemCommand" OnItemDataBound="rpt_Response_ItemDataBound">
                        <ItemTemplate>
                            <div style="margin-left:100px;width:300px">
                            <div style="border:dashed 1px;color:#ffb100"></div><br />
                            <asp:LinkButton ID="btn_Responser" runat="server" ForeColor="#cc9900" Style="text-decoration: none" Text='<%# Eval("UserName") %>' CommandName="GetIn" CommandArgument='<%# Eval("Owner_QQNum") %>'></asp:LinkButton>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Label ID="Lab_Sub_Res" runat="server" Text='<%# Eval("Substance") %>'></asp:Label><br /><br />
                            <asp:Label ID="Lab_Time_Res" runat="server" Text='<%# Eval("Time") %>' ForeColor="#999999"></asp:Label>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:LinkButton ID="btn_Delete_Res" runat="server" Style="text-decoration: none" Text="删除" CommandName="Delete" CommandArgument='<%# Eval("Message_BoradID") %>' ForeColor="#cc9900"></asp:LinkButton><br /><br />
                                </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:TextBox ID="txt_Response" runat="server" TextMode="MultiLine" placeholder="我也来说两句吧"></asp:TextBox>
                    <asp:Button ID="btn_Response" runat="server" ForeColor="#cc9900" Text="回复" CommandName="Response" CommandArgument='<%# Eval("Message_BoradID") %>'></asp:Button><br /><br />
                    
            </ItemTemplate>
        </asp:Repeater>
        <div id="divPage" runat="server">
        <asp:Button ID="btnFirstPage" runat="server" Text="首页" OnClick="btnFirstPage_Click" />
        <asp:Button ID="btnUpPage" runat="server" Text="上一页" OnClick="btnUpPage_Click" />
        <asp:Button ID="btnDownPage" runat="server" Text="下一页" OnClick="btnDownPage_Click" />
        <asp:Button ID="btnLastPage" runat="server" Text="尾页" OnClick="btnLastPage_Click" />
        页次<asp:Label ID="NowPage" runat="server" Text="1"></asp:Label>
        /<asp:Label ID="TotalPage" runat="server" Text="1"></asp:Label>
        转<asp:TextBox ID="txtJumpPage" runat="server" Width="16px"></asp:TextBox>
        <asp:Button ID="btnJump" runat="server" Text="跳转" OnClick="btnJump_Click" />
        <br /></div>
    </div>
</asp:Content>

