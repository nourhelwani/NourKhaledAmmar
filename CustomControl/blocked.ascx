<%@ Control Language="C#" AutoEventWireup="true" CodeFile="blocked.ascx.cs" Inherits="WebUserControl_blocked" %>
<link href="../CSSs/bootstrap.min.css" type="text/css" rel="stylesheet"/>
<table >
<tr >
    <td style="width:20px;">
        <span class="glyphicon glyphicon glyphicon-stop"></span>
    </td>
    <td style="width:100px;height:20px;">
        <asp:Label runat="server" ID="NameBlocked" CssClass="container" Text=""></asp:Label>
    </td>
    <td style="width:100px;height:20px;">
        <asp:LinkButton runat="server" ID="RemoveBlock" OnClick="RemoveBlock_OnClick">Unblock</asp:LinkButton>
    </td>
</tr>
</table>
