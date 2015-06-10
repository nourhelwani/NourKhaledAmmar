<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MessageControl.ascx.cs" Inherits="WebUserControl_MessageControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<link rel="stylesheet" href="../CSSs/bootstrap.min.css" type="text/css" />
<link rel="stylesheet" href="../CSSs/jquery.frontbox-1.1.css" type="text/css"/>
<link rel="stylesheet" href="../CSSs/AdminLTE.css" type="text/css" />
<link rel="stylesheet" href="../CSSs/_all-skins.min.css" type="text/css" />
<link rel="stylesheet" href="../CSSs/_all.css" type="text/css" />
<asp:ScriptManager runat="server" ID="ScriptMessage"></asp:ScriptManager>
<asp:UpdatePanel runat="server" ID="MessageControl">
    <ContentTemplate>
<table style="width:700px;height:35px;border:1px solid lightgray;background-color:rgb(250,250,250)">
    <tr>
        <td style="width:50px;padding-left:10px;">
            <asp:CheckBox runat="server" ID="SelectMessage" />
        </td>
        <td style="width:50px;" class="mailbox-star">
            <asp:LinkButton runat="server" ID="ImportMessage" CssClass="glyphicon glyphicon-star-empty"></asp:LinkButton>
        </td>
        <td style="width:200px;padding-left:10px;text-align:center;" >
            <asp:LinkButton runat="server" ID="MessageFrom"  Width="180" Text="AMMAR" OnClick="MessageFrom_Click"></asp:LinkButton>
        </td>
        <td style="width:250px;text-align:center;">
            <asp:Label runat="server" ID="MessageTitle" Text="WHere Are YouLIve"></asp:Label>
        </td>
        <td style="margin-left:10px;text-align:center;">
            <asp:Label runat="server" ID="MessageTime" CssClass="mailbox-read-time" >22-5-2014</asp:Label>
        </td>
    </tr>
</table>
    </ContentTemplate>
 </asp:UpdatePanel>
