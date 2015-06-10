<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="ApprovePlaces.aspx.cs" Inherits="Pages_ApprovePlaces" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>

<%@ Register Src="~/CustomControl/MarkersVotingControl.ascx" TagPrefix="My" TagName="MarkerVote" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Change Main Image</title>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="../CSSs/bootstrap.min.css" />
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
    <script type="text/javascript" src="../Scripts/jquery1.10.2.js"></script>
    <script type="text/javascript" src="../Scripts/jqueryui1.11.3.js"></script>
    <script type="text/javascript" src="../Scripts/bootstrap.min.js"></script>
    <script type="text/javascript" src="../Scripts/MarkerClusterer.js"></script>
    <script type="text/javascript" src="../Scripts/list.js"></script>
    <script src="../Scripts/Codepros.js" type="text/javascript"></script>
</head>
<body>
    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="Home.aspx">
                    <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>3alyamen
                </a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="Home.aspx"><span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span></a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <form runat="server">
        <asp:ScriptManager ID="myScriptManager" EnablePageMethods="true" runat="server"></asp:ScriptManager>

        <div style="width: 25%; height: 93%; background-color: white; position: absolute;top:50px; overflow-y: scroll;">
            <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>--%>
            <asp:Repeater ID="myRepeater" runat="server">
                <HeaderTemplate>
                    <table class="table">
                </HeaderTemplate>
                <ItemTemplate>
                    <tr onmouseover="this.style.backgroundColor='ghostwhite'" onmouseout="this.style.backgroundColor=''">
                        <td>
                            <My:MarkerVote runat="server" Address='<%#Eval("ADDRESS") %>' MarkerName='<%#Eval("MARKER_NAME") %>' MarkerID='<%#Eval("MARKER_ID") %>'
                                Type='<%#Eval("TYPE") %>' ID="myControl" />
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </form>
    <div id="mapContainer" style="width: 75%; left: 25%; height: 93%;top:50px; position: absolute;">
    </div>
    <script>
        (function (window, Codepros, $) {

            var myMap = Codepros.CreateNew(document.getElementById('mapContainer'), {
                center: new google.maps.LatLng(25, 56),
                zoom: 9
            });

            window.VotingMap = myMap;

        })(window, window.Codepros, jQuery)

        function VoteUp(btn) {
            var markerUpId = document.getElementById(btn.id.replace('btnPlusVote', 'lblID')).innerHTML;
            PageMethods.GetMarkerPosition(markerUpId, function (data) {
                var Jdata = $.parseJSON(data);
                //window.VotingMap.CreateMarker({
                //    lat: Jdata[0].LAT,
                //    lng: Jdata[0].LNG
                //});
                window.VotingMap.Center(new google.maps.LatLng(Jdata[0].LAT, Jdata[0].LNG));
                PageMethods.VoteUp(markerUpId, function (response) { });
                document.getElementById(btn.id).setAttribute("disabled", "true");
            });
        }
        function VoteDown(btn) {
            var markerDownId = document.getElementById(btn.id.replace('btnMinVote', 'lblID')).innerHTML;
            PageMethods.GetMarkerPosition(markerDownId, function (data) {
                var Jdata = $.parseJSON(data);                
                //window.VotingMap.CreateMarker({
                //    lat: Jdata[0].LAT,
                //    lng: Jdata[0].LNG
                //});
                window.VotingMap.Center(new google.maps.LatLng(Jdata[0].LAT, Jdata[0].LNG));
                PageMethods.VoteDown(markerDownId, function (response) { });
                document.getElementById(btn.id).setAttribute("disabled", "true");
            });
        }
        function TableHoverd(btn) {
            console.log(btn);
        }

    </script>
</body>
</html>

