<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MainAds.ascx.cs" Inherits="CustomControl_MainAds" %>
<asp:Panel runat="server" CssClass="col-md-*" ID="mt">
    <div class="panel panel-default" runat="server" id="adsMainDiv" style="border-bottom-color: #0094ff;">
        <div class="panel-heading" style="border-bottom-color: #0094ff;padding-bottom:25px">
                    <img runat="server" id="imgAds"  class="media-object" style="width: 64px; float: left; height: 64px;margin-right:5px">
                    <h5 class="media-heading" id="lblMarkerName" runat="server" ></h5>
                    <img runat="server" id="imgGener" style="width: 20px;  height: 20px" />
                    <img runat="server" id="imgType" style="width: 20px; height: 20px" />
                    <p runat="server" id="lblDate"/>
                   
          
        </div>
                
            <div class="panel-body">
                <p runat="server" style="color: black" id="lbladsContent">
                </p>
                <asp:Button runat="server" ID="btnShowOnMap" OnClick="btnShowOnMap_Click" Text="location" CssClass="btn btn-primary btn-sm" />
                <asp:Button runat="server" OnClick="btnMarkerInfo_Click" ID="btnMarkerInfo" Text="marker info" CssClass="btn btn-primary btn-sm" />


            </div>

            <input type="hidden" runat="server" id="markerId" />
            <input type="hidden" runat="server" id="adsId" />

        </div>
</asp:Panel>




