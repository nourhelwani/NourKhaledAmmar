<%@ Page Language="C#" AutoEventWireup="true" CodeFile="m.ViewMore.aspx.cs" Inherits="Pages_ViewMore" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>view more</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="../CSSs/bootstrap.min.css" />
    <script type="text/javascript" src="../Scripts/jquery1.10.2.js"></script>
    <script type="text/javascript" src="../Scripts/jqueryui1.11.3.js"></script>
    <script type="text/javascript" src="../Scripts/bootstrap.min.js"></script>
    <script src="http://maps.google.com/maps/api/js?sensor=false&libraries=places,geometry"></script>
    <script type="text/javascript" src="../Scripts/MarkerClusterer.js"></script>
    <script type="text/javascript" src="../Scripts/list.js"></script>
    <script type="text/javascript" src="../Scripts/Codepros.js"></script>
    
    <style type="text/css">
         .ratingEmpty{
            background-image: url(/MainProject%20-%20Copy/Icons/ratingStarEmpty.gif);
            width:18px;
            height:18px;
            }
            
            .ratingFilled{
            background-image: url(/MainProject%20-%20Copy/Icons/ratingStarFilled.gif);
            width:18px;
            height:18px;
            }
            
            .ratingSaved{
            background-image: url(/MainProject%20-%20Copy/Icons/ratingStarSaved.gif);
            width:18px;
            height:18px;
            }
                 
        body {
            padding-top: 50px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <ajax:ToolkitScriptManager ID="ScripManager1" runat="server"/>
        <input type="hidden" runat="server" id="lat" />
        <input type="hidden" runat="server" id="lng" />

        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="m.home.aspx">
                        <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>3alyamen</a>
                </div>
            </div>
        </nav>
        <asp:HiddenField runat="server" ID="hiddenLat" />
        <asp:HiddenField runat="server" ID="hiddenLng" />

        <div class="col-md-*" id="mapDiv" style="height: 150px; width: 100%;">
        </div>

        <asp:Panel runat="server" ID="divSlider" CssClass="col-md-*">
            <div class="panel panel-default" style="border-top-width: 5px; border-top-color: #0094ff">

                <div id="myCarousel" class="carousel slide" data-interval="3000" data-ride="carousel">


                    <!-- Carousel items -->
                    <div class="carousel-inner">
                        <asp:Repeater runat="server" ID="repImages" OnItemDataBound="repImages_ItemDataBound">
                            <ItemTemplate>
                                <asp:Panel runat="server" ID="divImg">
                                    <asp:Image runat="server" ID="adsImg" ImageUrl='<%#Container.DataItem.ToString()%>' Width="100%" Height="150px" />

                                </asp:Panel>

                            </ItemTemplate>
                        </asp:Repeater>

                    </div>
                    <!-- Carousel nav -->
                    <a class="carousel-control left" href="#myCarousel" data-slide="prev">
                        <span class="glyphicon glyphicon-chevron-left"></span>
                    </a>
                    <a class="carousel-control right" href="#myCarousel" data-slide="next">
                        <span class="glyphicon glyphicon-chevron-right"></span>
                    </a>
                </div>

            </div>
        </asp:Panel>


        <div class="col-md-*">
            <div class="panel panel-default" style="border-top-width: 5px; border-top-color: #0094ff">

                <div class="panel-body">


                    <div style="position: relative">
                        <p runat="server" id="markerName">
                            <strong>Marker name :
                            </strong>
                        </p>
                        <p runat="server" id="address"><strong>Address : </strong></p>

                        <asp:Button runat="server" CssClass="btn btn-info" Text="Follow" />

                    </div>

                </div>
            </div>

        </div>

        <div class="col-md-*">
            <div class="panel panel-default" style="border-top-width: 5px; border-top-color: #0094ff">

                <div class="panel-body">

                    <h4>Basic information</h4>
                    <hr />
                    <p runat="server" id="description">
                        <strong>description :
                        </strong>
                    </p>
                    <p runat="server" id="genner">
                        <strong>Genner :
                        </strong>
                    </p>

                    <p runat="server" id="workDay">
                        <strong>Work day :
                        </strong>
                    </p>

                    <p runat="server" id="workTime">
                        <strong>Work time :
                        </strong>
                    </p>

                </div>
            </div>

        </div>

        <div class="col-md-*">
            <div class="panel panel-default" style="border-top-width: 5px; border-top-color: #0094ff">

                <div class="panel-body">

                    <h4>Call Info</h4>
                    <hr />
                    <p runat="server" id="webSite">
                        <strong>Web-site :
                        </strong>
                    </p>
                    <p runat="server" id="phoneNumber">
                        <strong>Phone number :
                        </strong>
                    </p>


                </div>
            </div>

        </div>

        <div class="col-md-*">
            <div class="panel panel-default" style="border-top-width: 5px; border-top-color: #0094ff">

                <div class="panel-body">

                    <h4>Rating</h4>
                     <asp:UpdatePanel ID="pnlRating" runat="server">
                        <ContentTemplate>
                            <table>
                                <tr>
                                    <td  >
                                        <b>Average Rating:</b>
                                    </td>
                                    <td>
                                        <ajax:Rating ID="ratingControl" AutoPostBack="true" OnChanged="RatingControlChanged" runat="server" StarCssClass="ratingEmpty" WaitingStarCssClass="ratingSaved" EmptyStarCssClass="ratingEmpty" FilledStarCssClass="ratingFilled">
                                        </ajax:Rating>
                                    </td>
                                </tr>
                                <tr>
                                    <td><b> <asp:label ID="lblRate" runat="server"/> </b></td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>

        </div>


    </form>
    <script>

        var map;
        function initialize() {
            var lat = document.getElementById("lat").value;
            var lng = document.getElementById("lng").value;

            var mapOptions = {
                zoom: 16,
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

            var marker = new google.maps.Marker({
                position: new google.maps.LatLng(lat, lng)
            });
            marker.setMap(map);
        }

        google.maps.event.addDomListener(window, 'load', initialize);
    </script>
</body>
</html>
