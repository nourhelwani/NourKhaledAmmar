<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PromoteAdvertismentControl.ascx.cs" Inherits="CustomControl_PromoteAdvertismentControl" %>
       <style type="text/css">
            .auto-style1 {
                width: 100px;
            }
        </style>
        <table style="border:solid;border-color:#EEEEEE;border-width:thin;width:40%;border-radius:10px;background-color:#F7F7F9">
            <tr style="height:30px">
                <td colspan="2">
                  <asp:Image Style="margin:10px" runat="server" CssClass="img-thumbnail" ID="imgAdvIcon" />   
                  <b><asp:Label Style="margin:10px" ForeColor="#3B5998" runat="server" ID="lblMarkerName"></asp:Label></b>
                </td>
            </tr>
            <tr style="height:25px">
                <td class="auto-style1"><div Style="margin:6px">Description :</div></td>
                <td>
                    <asp:Label  runat="server" ID="lblDescription"></asp:Label>
                </td>
            </tr>
            <tr style="height:25px">
                <td  class="auto-style1"><div Style="margin:6px">Expire Date :</div></td>
                <td>
                    <asp:Label runat="server" ID="lblExpireDate"></asp:Label>
                </td>
            </tr>
            <tr style="height:30px">
                <td colspan="2" align="center">
                    <asp:Button runat="server" ID="btnPromote" text="Promote Advertisment" CssClass="btn btn-info" OnClick="btnPromote_Click" />
                    <asp:Label runat="server" ID="AdvertismentID" Visible="false" />
                </td>
            </tr>
        </table>
       
    