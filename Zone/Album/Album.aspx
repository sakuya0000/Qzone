<%@ Page Title="" Language="C#" MasterPageFile="~/Zone/MasterPage.master" AutoEventWireup="true" CodeFile="Album.aspx.cs" Inherits="Zone_Album_Album" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br /><br />
    <span style="font-size:25px">相册</span>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:LinkButton ID="btn_Back" runat="server" ForeColor="#cc9900" Style="text-decoration: none" Text="返回相册列表" OnClick="btn_Back_Click"></asp:LinkButton><br /><br />
    <div>
    <div id="div_upload" runat="server" style="text-align: center"> 
        <div style="width: 200px;"> 
            <input type="file" size="50" name="File" /> 
            <span id="upload"></span> 
            <br /> 
            <input type="button" name="add" value="添加文件" onclick="addInput()"/> 
            <input type="button" name="delete" value="删除文件" onclick="deleteInput()"/> 
        </div> 
        <div style="margin: 10px 0 10px 0;width: 200px;"> 
            <asp:Button runat="server" Text="上传" ID="btnUpload" OnClick="btnUpload_Click"></asp:Button><br/> 
        </div> 
    </div> 
        <script type="text/javascript"> 
            var attachname = "uploadfile"; 
            var i = 1; 
            function addInput() { 
                if (i > 0) { 
                    var attach = attachname + i; 
                    if (createInput(attach)) 
                        i = i + 1; 
                } 
            } 
            function deleteInput() { 
                if (i > 1) { 
                    i = i - 1; 
                    if (!removeInput()) 
                        i = i + 1; 
                } 
            } 
            function createInput(nm) { 
                var aElement = document.createElement("input"); 
                aElement.name = nm; 
                aElement.id = nm; 
                aElement.type = "file"; 
                aElement.size = "50"; 
                if (document.getElementById("upload").appendChild(aElement) == null) 
                    return false; 
                return true; 
            } 
            function removeInput(nm) { 
                var aElement = document.getElementById("upload"); 
                if (aElement.removeChild(aElement.lastChild) == null) 
                    return false; 
                return true; 
            } 
        </script> 
        <asp:Repeater ID="rpt_Album" runat="server" OnItemCommand="rpt_Album_ItemCommand" OnItemDataBound="rpt_Album_ItemDataBound">
            <ItemTemplate>
                <asp:Image ID="pic" runat="server" ImageUrl='<%# Eval("Path") %>' Height="100px" Width="100px" />
                <asp:LinkButton ID="btn_Delete" runat="server" ForeColor="#ff0000" Text="删除" CommandName="Delete" CommandArgument='<%# Eval("PicID")+","+Eval("Path") %>'></asp:LinkButton>
                <%#((Container.ItemIndex+1)%9!=0) ? "&nbsp;&nbsp;&nbsp;&nbsp;":""%>
                <%#((Container.ItemIndex + 1) % 9 == 0 && Container.ItemIndex > 0) ? "<br/><br/>" : ""%>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>

