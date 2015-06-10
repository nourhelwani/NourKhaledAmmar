<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DefaultMarkerViewControl.ascx.cs" Inherits="CustomControl_DefaultMarkerViewControl" %>

<style>
    #CurrentMarkerHandler{
        border:solid 1px;
        border-color:#EEEEEE;
        border-radius:2px;
        box-shadow:.5px .5px .5px .5px gray;
    }
</style>

<div id="CurrentMarkerHandler" style="margin-left:5px;margin-bottom:5px;align-self:stretch">
    <table class="table">
        <tr>
            <td rowspan="2">
                <asp:Image ID="MarkerMainImage" runat="server" Width="70px" ImageUrl="~/Photos/1.png" />
            </td>
            <td>
                <asp:Label ID="lblMarkerName" runat="server" Text="Marker Name"></asp:Label>
            </td>
            <td>
                <span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>
                <asp:Label ID="lblCounterVisits" Text="0" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblMarkerAddress" Text="Address" runat="server"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblMarkerIsApproved" Text="Pending.." runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:Label ID="lblMarkerDescription" Text="Description" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:Button ID="btnChangeMarkerImage" Text="Change Main Image" runat="server" CssClass="btn btn-default" 
                 OnClientClick="OpenModelChange(this); return false;" />&nbsp;  
            <asp:Button ID="btnUploadImages" Text="Upload Images" runat="server" CssClass="btn btn-danger" 
                 OnClientClick="OpenModel(this); return false;"/>
            </td>
        </tr>
    </table>
</div>
