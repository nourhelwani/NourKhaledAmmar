<%@ Page Language="C#" AutoEventWireup="true" CodeFile="m.signIn.aspx.cs" Inherits="Pages_m_signIn" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>sign-in</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="../CSSs/bootstrap.min.css" />
    <script type="text/javascript" src="../Scripts/jquery1.10.2.js"></script>
    <script type="text/javascript" src="../Scripts/jqueryui1.11.3.js"></script>
    <script type="text/javascript" src="../Scripts/bootstrap.min.js"></script>
    <script src="http://maps.google.com/maps/api/js?sensor=false&libraries=places,geometry"></script>
    <script type="text/javascript" src="../Scripts/MarkerClusterer.js"></script>
    <script type="text/javascript" src="../Scripts/list.js"></script>
    <script type="text/javascript" src="../Scripts/Codepros.js"></script>
    <style>
        
    </style>

</head>
<body style="background-color: #0094ff">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <input type="hidden" runat="server" value="33.51849923765608" id="lat" />
        <input type="hidden" runat="server" value="36.287841796875" id="lng" />
        <div class="col-md-4" id="mapDiv" style="height: 200px; width: 100%; padding: 0px; margin: 0px; border-radius: 6px">
        </div>

        <div class="col-md-4" style="margin: 10px">
            <h3 style="margin: 5px">3alyamen</h3>
            <div>

                <asp:UpdatePanel runat="server" ID="UpdatePanelSign_In">
                  <ContentTemplate>
                   <div id="divsign-in" style="width:95%;margin-left:2%">
                     <br />
                     <label  for="tboxUsername">UserName :</label>
                     <asp:TextBox ValidationGroup="v1"  CssClass="form-control" runat="server"  ID="tboxUsername" Width="100%"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="validationUserName" ValidationGroup="v1" runat="server" ErrorMessage="*" ControlToValidate="tboxUsername"></asp:RequiredFieldValidator>
                     <asp:RegularExpressionValidator ID="RegularExpressionValidator1" Display="Dynamic" runat="server" ValidationGroup="v1" ErrorMessage="inviled userName" ValidationExpression="[A-Za-z][A-Za-z0-9._]{2,50}" ControlToValidate="tboxUsername" Font-Size="Small"></asp:RegularExpressionValidator>
                     <br />
                     <label>Password : </label>
                     <asp:TextBox runat="server" CssClass="form-control" ValidationGroup="v1" ID="tboxPassword" Width="100%" TextMode="Password"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="validationPassword" runat="server" ValidationGroup="v1" ErrorMessage="*" ControlToValidate="tboxPassword"></asp:RequiredFieldValidator>
                     <br />
                     <asp:Button runat="server" CssClass="btn btn-primary" ValidationGroup="v1" ID="btnSignIn" Text="Sign-In" Width="100px" OnClick="signinbtn_Click" />
                     <a href="#" onclick="ShowInfoDiv()" style="position:absolute;right:2%;font-weight:500;text-decoration:none;">forget your Password..</a>
                     <br /><br />
                     <asp:Label runat="server" ID="lblError" Font-Size="Small" Visible="false"></asp:Label>
                   </div>
                  </ContentTemplate>
                  <Triggers>
                     <asp:AsyncPostBackTrigger EventName="Click" ControlID="btnSignIn" />
                  </Triggers>
               </asp:UpdatePanel>
                <asp:LinkButton runat="server" OnClick="Unnamed_Click" Text="continue without sign-in" Style="margin-left: 5px" ForeColor="White"></asp:LinkButton>
            </div>
        </div>
    </form>
    <script>

        var map;
        function initialize() {
            var lat = document.getElementById("lat").value;
            var lng = document.getElementById("lng").value;

            var mapOptions = {
                zoom: 13,
                draggable: false,
                panControl: false,
                zoomControl: false,
                mapTypeControl: false,
                scaleControl: false,
                streetViewControl: false,
                overviewMapControl: false,
                center: new google.maps.LatLng(lat, lng),
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            map = new google.maps.Map(document.getElementById('mapDiv'),
                mapOptions);

        }

        google.maps.event.addDomListener(window, 'load', initialize);
    </script>
</body>
</html>
