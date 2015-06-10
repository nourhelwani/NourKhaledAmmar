<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MarkersVotingControl.ascx.cs" Inherits="CustomControl_MarkersVotingControl" %>

    <table style="width:100%" id="myTable">
        <tr>

            <td style="width:70px">
                <asp:LinkButton ID="btnPlusVote" runat="server" CssClass="btn btn-success" OnClientClick="VoteUp(this);return false;">
                <span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>
                </asp:LinkButton>
            </td>
            <td>
                <h4>
                    <asp:Label ID="lblMarkerName" runat="server" Text="MarkerName"></asp:Label></h4>
            </td>
        </tr>
        <tr>
            <td style="width:70px">
                <asp:LinkButton ID="btnMinVote" runat="server" CssClass="btn btn-danger" OnClientClick="VoteDown(this);return false;">
                <span class="glyphicon glyphicon-thumbs-down" aria-hidden="true"></span>
                </asp:LinkButton>
            </td>
            <td>
                <asp:Label ID="lblAddress" runat="server" Text="lblAddress"></asp:Label><br />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblID" runat="server" Text="mID" Style="display: none"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblType" runat="server" Text="type" ForeColor="Gray"></asp:Label>
            </td>
        </tr>
    </table>


