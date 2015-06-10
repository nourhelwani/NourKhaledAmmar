<%@ Page Language="C#" AutoEventWireup="true" CodeFile="m.home.aspx.cs" Inherits="Pages_m_home" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>

<%@ Register Src="~/CustomControl/MainAds.ascx" TagName="ads" TagPrefix="my" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>m.Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="../Scripts/mobileScript/jquery1.10.2.js"></script>
    <script src="../Scripts/mobileScript/jqueryui1.11.3.js"></script>
    <script src="http://maps.google.com/maps/api/js?sensor=false&libraries=places,geometry"></script>
    <script src="../Scripts/mobileScript/MarkerClusterer.js"></script>
    <script src="../Scripts/mobileScript/list.js"></script>
    <script src="../Scripts/mobileScript/Codepros.js"></script>
    <script src="../Scripts/mobileScript/jqueryui.codepros.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Include jQuery Mobile stylesheets -->
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
    <!-- Include the jQuery library -->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" type="text/javascript"></script>
    <!-- Include the jQuery Mobile library -->
    <script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
    <!--bootstrap-->
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script type="text/javascript">

        function clickpostCodeRecivedButton(lat, lng, userName) {
            document.getElementById('hiddenLatLng').value = lat + " " + lng;
            document.getElementById('hiddenUserName').value = userName;
            document.getElementById('btncallpostCodeRecived').click();
        }

        function clickpostCodeRecivedRequsetButton(userName, phoneNumber) {
            document.getElementById('hiddenUserName').value = userName;
            document.getElementById('hiddenPhoneNumber').value = phoneNumber;
            document.getElementById('btncallpostCodeRequsetRecived').click();
        }


    </script>
    <style>
        .ui-panel-inner {
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>
        <input type="hidden" id="hiddenPhoneNumber">
        <input type="hidden" id="hiddenLatLng">
        <input type="hidden" id="hiddenLang">
        <input type="hidden" id="hiddenUserName">
        <button type="button" id="btncallpostCodeRecived"></button>
        <button type="button" id="btncallpostCodeRequsetRecived"></button>
        <button type="button" id="btnAdsShowMarker"></button>

        <button style="margin: 20px" type="button" id="btnLocation" class="btn btn-info btn-circle">
            <i class="glyphicon glyphicon-map-marker"></i>
        </button>

        <a href="#adsPanel" style="margin: 20px" id="btnAdv" class="btn btn-default">
            <i class="glyphicon glyphicon-chevron-left"></i>
        </a>
        <div id="pan" class="row" style="width: 50%">
            <div>
                <div class="input-group">
                    <span class="input-group-btn">
                        <button class="btn btn-info" id="btnMenu" type="button">
                            <i class="glyphicon glyphicon-list" style="padding-top: 3px; padding-bottom: 3px"></i>
                        </button>
                    </span>
                    <input type="text" class="form-control" id="text-field" placeholder="Enter a Location">
                </div>
                <!-- /input-group -->
            </div>
            <!-- /.col-lg-6 -->
        </div>


        <!--main page-->
        <div data-role="page" id="pageMain" data-enhanced="false">


            <!--right \el-->
            <div data-role="panel" " id="adsPanel"  data-theme="b" data-enhance="false" data-position-fixed="false" data-position="right">
              <div  cla="row">
                  <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>

                        <div class="btn-group" role="group" data-role="none" style="width: 100%">
                            <button id="btnSelectSort" type="button" style="width: 100%" class="btn btn-default dropdown-toggle" data-role="none" data-toggle="dropdown" aria-expanded="true">
                                Newest
                                        <span class="caret"></span>
                            </button>
                            <ul data-role="none" class="dropdown-menu" role="menu">
                                <li>
                                    <asp:Button ID="btnSortNew" ToolTip="NEWEST" runat="server" Text="Newest" OnClick="SelectSortChange_Click" data-role="none" CssClass="btn-default" Style="border: hidden; padding: 5px; margin-bottom: 2px; text-align: left" Font-Bold="true" Width="100%" /></li>
                                <li>
                                    <asp:Button ID="btnSortOld" ToolTip="OLDEST" runat="server" Text="Oldest" OnClick="SelectSortChange_Click" data-role="none" CssClass="btn-default" Style="border: hidden; padding: 5px; margin-bottom: 2px; text-align: left" Font-Bold="true" Width="100%" /></li>
                                <li>
                                    <asp:Button ID="btnSortVisted" ToolTip="MOSTVISTED" runat="server" Text="Visted" OnClick="SelectSortChange_Click" data-role="none" CssClass="btn-default" Style="border: hidden; padding: 5px; margin-bottom: 2px; text-align: left" Font-Bold="true" Width="100%" /></li>
                                <li>
                                    <asp:Button ID="btnSortCategory" ToolTip="CATEGORY" runat="server" Text="Category" OnClick="SelectSortChange_Click" data-role="none" CssClass="btn-default" Style="border: hidden; padding: 5px; margin-bottom: 2px; text-align: left" Font-Bold="true" Width="100%" /></li>

                            </ul>
                        </div>

                        <div class="btn-group" role="group" data-role="none" style="width: 100%; padding-top: 5px;">
                            <button id="btnSelectType" type="button" runat="server" style="width: 100%" class="btn btn-default dropdown-toggle" data-role="none" data-toggle="dropdown" aria-expanded="true">
                                All type
                                        <span class="caret"></span>
                            </button>
                            <ul data-role="none" class="dropdown-menu" role="menu">
                                <li>
                                    <asp:Button ID="btnTypeAds" ToolTip="Normal" runat="server" Text="Advertisment" data-role="none" OnClick="SelectTypeChange_Click" CssClass="btn-default" Style="border: hidden; padding: 5px; margin-bottom: 2px; text-align: left" Font-Bold="true" Width="100%" /></li>
                                <li>
                                    <asp:Button ID="btnTypeEvent" ToolTip="Event" runat="server" Text="Event" data-role="none" OnClick="SelectTypeChange_Click" CssClass="btn-default" Style="border: hidden; padding: 5px; margin-bottom: 2px; text-align: left" Font-Bold="true" Width="100%" /></li>
                                <li>
                                    <asp:Button ID="btnTypeAll" runat="server" Text="All type" data-role="none" OnClick="SelectTypeChange_Click" CssClass="btn-default" Style="border: hidden; padding: 5px; margin-bottom: 2px; text-align: left" Font-Bold="true" Width="100%" /></li>

                            </ul>
                        </div>

                        <hr>
                        <asp:Repeater runat="server" OnItemDataBound="repAds_ItemDataBound" ID="repAds">
                            <ItemTemplate>
                             <my:ads runat="server"   Onlocation="ads_clickLocation"   OnclickInfo="adsCustomContro_clickInfo"   ID="adsCustomContro" MarkerIdPro='<%#Eval("MARKER_ID")%>' AdsIdpro='<%#Eval("ADVERTISMENT_ID")%>' LblMarkerNamePro='<%#Eval("MARKER_NAME")%>' Type='<%#Eval("ADS_TYPE") %>' Gener='<%#Eval("GENERS") %>' LbladsContentPro='<%#Eval("ADS_CONTENT")%>' />

                             </ItemTemplate>
                        </asp:Repeater>
                    </ContentTemplate>
                </asp:UpdatePanel>

                  </div>
            </div>

            <!--left panel-->

            <div data-role="panel" data-theme="b" id="navpanel" data-display="overlay">
                <ul data-role="listview" class="ui-listview-outer">

                    <li><a href="m.signIn.aspx" runat="server" data-ajax="false" id="btnSignIn">Sign-in</a></li>

                    <li data-role="collapsible" data-iconpos="right" data-shadow="false" data-corners="false">
                        <h2>Directions</h2>
                        <ul data-role="listview" data-shadow="false" data-inset="true" data-corners="false">
                            <li><a href="#" id="btn2point">2 points</a></li>
                            <li><a href="#PageGetDirection" data-ajax="false" id="btnGetDirectionMethodTwoSearchBox">search box</a></li>
                        </ul>
                    </li>

                    <li><a href="#" id="PostCode">Post code</a></li>
                    <li><a href="#" id="btnWahtsHere">whats here</a></li>

                    <li><a href="m.ads.aspx" data-ajax="false" id="">Advetisment</a></li>
                    <li data-role="collapsible" data-iconpos="right" data-shadow="false" data-corners="false">
                        <h2>Sorting</h2>
                        <ul data-role="listview" data-shadow="false" data-inset="true" data-corners="false">

                            <asp:UpdatePanel ID="UpdatePanel2"
                                UpdateMode="Conditional"
                                runat="server">
                                <ContentTemplate>

                                    <asp:Repeater ID="myRepeater" runat="server">
                                        <HeaderTemplate>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <li></li>
                                        </ItemTemplate>
                                    </asp:Repeater>

                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </ul>
                    </li>

                    <li><a href="#PageGetDirection" data-ajax="false">Help</a></li>

                </ul>
            </div>
            <!--content div-->
            <div data-role="content" style="padding: 0;">
                <!--popups-->
                <div data-role="popup" id="popupPostCode" data-theme="b" data-overlay-theme="b" data-dismissible="true">
                    <div data-role="header" data-theme="a">
                        <h5>3alymen</h5>
                    </div>
                    <div role="main" class="ui-content">
                        <p>Your name :</p>
                        <input type="text" name="userName" id="txtUserName">
                        <p>Phone number:</p>
                        <input type="text" name="phoneNum" id="txtPhoneNumber">

                        <fieldset data-role="controlgroup" data-theme="b" data-type="vertical">
                            <input type="radio" name="rad2" id="radRes" value="RES" checked="checked">
                            <label for="radRes">Send my post code</label>
                            <input type="radio" name="rad2" id="radReq" value="REQ">
                            <label for="radReq">Send Post code requst</label>
                            <input type="button" value="Send sms" class="ui-btn" id="btnSendPostCode">
                        </fieldset>

                    </div>
                </div>
                <!---------->
                <div data-role="popup" id="popupDialogDireictionMethod2Point" data-overlay-theme="b" data-theme="b" data-dismissible="false" style="max-width: 250px;">
                    <div data-role="header" data-theme="a">
                        <h5>3alymen</h5>
                    </div>
                    <div role="main" class="ui-content">
                        <p>please choose direction method.</p>
                        <button type="button" id="btnCar" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b">car</button>
                        <button type="button" id="btnWalk" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b">walk</button>
                    </div>
                </div>

                <!---------->
                <div data-role="popup" id="popInforamtion" data-overlay-theme="b" data-theme="b" data-dismissible="true" style="max-width: 250px;">
                    <p id="popInforamtionText">
                    </p>
                </div>

                <!---------->

                <div data-role="popup" id="popupText" data-overlay-theme="b" data-theme="b" data-dismissible="false" style="max-width: 300px;">
                    <div data-role="header" data-theme="a">
                        <h5>3alymen</h5>
                    </div>
                    <div role="main" class="ui-content">
                        <p id="popupTextContent"></p>
                        <button type="button" id="btnOk" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b">ok</button>
                    </div>
                </div>
                <!---------->
                <div data-role="popup" id="popupConfirm" data-overlay-theme="b" data-theme="b" data-dismissible="true" style="max-width: 300px;">
                    <div data-role="header" data-theme="a">
                        <h5>3alymen</h5>
                    </div>
                    <div role="main" class="ui-content">
                        <p id="popupConfirmContent"></p>
                        <button type="button" id="btnPostYes" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b">Yes</button>
                        <button type="button" id="btnPostNo" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b">No</button>
                    </div>
                </div>
                <!---------->
                <div data-role="popup" id="popupConfirmRequst" data-overlay-theme="b" data-theme="b" data-dismissible="true" style="max-width: 300px;">
                    <div data-role="header" data-theme="a">
                        <h5>3alymen</h5>
                    </div>
                    <div role="main" class="ui-content">
                        <p id="popupConfirmRequstContent"></p>
                        <button type="button" id="btnPostRequsetYes" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b">Yes</button>
                        <button type="button" id="btnPostRequsetNo" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b">No</button>
                    </div>
                </div>

                <!--map container-->
                <div id="container">
                </div>

            </div>
        </div>
        <div data-role="page" data-dialog="true" id="pagePanel">
            
            <div role="main" class="ui-content">


                <fieldset data-role="controlgroup" data-theme="a" data-type="horizontal">
                    <button type="button" id="btnClosePanel" data-mini="true">close</button>
                    <button type="button" id="btnMinimizePanel" data-mini="true">minus</button>

                </fieldset>

                <div id="directions">
                </div>
            </div>
        </div>


        <!--get direction page-->
        <div data-role="page" data-dialog="true" id="PageGetDirection">
            <div data-role="header">
                <h1>Directions</h1>
                <a href="#" class="ui-btn ui-btn-inline ui-icon-back ui-shadow ui-corner-all ui-btn-icon-notext" data-rel="back">Map</a>
            </div>
            <div data-role="main" class="ui-content">
                <button type="button" id="btnLocation1" class="ui-btn ui-btn-inline ui-icon-Location ui-shadow ui-corner-all ui-btn-icon-notext"></button>
                <label for="name">Choose starting point</label>
                <input type="text" name="name" id="searchBox1" value="" placeholder="Enter a Location" />

                <label for="name">Choose destinatio point</label>

                <input type="text" name="name" id="searchBox2" value="" placeholder="Enter a Location" />
                <form>
                    <fieldset data-role="controlgroup" data-theme="b" data-type="horizontal">
                        <legend>derictions way:</legend>
                        <input type="radio" name="rad1" id="radCar" value="car" checked="checked">
                        <label for="radCar">Car</label>
                        <input type="radio" name="rad1" id="radWalk" value="walk">
                        <label for="radWalk">Walk</label>

                        <button type="button" id="btnGetDirectionMethodTwoSearchBox1" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-a">
                            Get Direction
                        </button>

                    </fieldset>
                </form>
            </div>

            <div data-role="popup" id="popupText2" data-overlay-theme="b" data-theme="b" data-dismissible="false" style="max-width: 250px">
                <div data-role="header" data-theme="a">
                    <h5>3alymen</h5>
                </div>

                <div role="main" class="ui-content">
                    <p id="content2"></p>
                    <button type="button" id="btnOkSearchBox2" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b">ok</button>
                </div>
            </div>

            <div data-role="popup" id="popupText1" data-overlay-theme="b" data-theme="b" data-dismissible="false" style="max-width: 250px">
                <div data-role="header" data-theme="a">
                    <h5>3alymen</h5>
                </div>
                <div role="main" class="ui-content">
                    <p id="content1"></p>
                    <button type="button" id="btnOkSearchBox" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b">ok</button>
                </div>
            </div>

        </div>


    </form>
    <link rel="stylesheet" type="text/css" href="../CSSs/mStyle.css">
    <link href="../CSSs/Home.css" rel="stylesheet" />
    <!--mapScript-->
    <script>
        (function (window, Codepros) {
            //varablie

            var ua = navigator.userAgent.toLowerCase();
            var android = ua.indexOf("android") > -1;
            var markerPoint1;
            var markerPoint2;
            var markerBox1;
            var markerBox2;
            var markerpost1;
            var markerpost2;
            var myLocationMarker;
            var myLocation;
            var markerAds;
            var adsMarkerPoint;
            var catImgSrc;
            var MarkerPurpleModel = "http://labs.google.com/ridefinder/images/mm_20_purple.png";
            var MarkerYellowModel = "http://labs.google.com/ridefinder/images/mm_20_yellow.png";
            var MarkerBlueModel = "http://labs.google.com/ridefinder/images/mm_20_blue.png";
            var searchBoxLocationCliked = false;
            var h = window.innerHeight;
            $("#popupMarkerInfo").on({
                popupbeforeposition: function () {
                    var w = $(window).width();
                    $("#popupMarkerInfo").css({ 'width': w - 50 });
                }
            });
            //custmize the size 
            $(document).on("mobileinit", function () {
                $.mobile.ajaxEnabled = false;
            });
            document.getElementById('container').style.height = h;
            //map option
            var myMap = Codepros.CreateNew(document.getElementById("container"), {
                center: new google.maps.LatLng(33.51849923765608, 36.287841796875),
                zoom: 13,
                panControl: false,
                zoomControl: false,
                mapTypeControl: false,
                scaleControl: false,
                streetViewControl: false,
                overviewMapControl: false,
                geocoder: true,
                styles: [{
                    featureType: 'poi',
                    elementtype: 'labels',
                    stylers: [{
                        visibility: 'off'
                    }]
                }]
            });

            google.maps.event.trigger(myMap, 'resize');


            var input = document.getElementById("text-field");
            //add auto compulte to main saerch
            myMap.AutoComplete({
                element: input,
                position: function (pos) {
                    input.placeholder = input.value;
                    input.value = "";
                    initializeVariable();
                    clearListnerClick();
                    clearAllMarkes();


                },
                error: function (error) {
                    input.value = "";
                    input.placeholder = "place not found";

                },
                showMarker: true

            });
            //btn get loaction
            //   var btn    Location = document.getElementById("btnLocation");
            btnLocation.onclick = function () {
                initializeVariable();
                clearListnerClick();
                clearAllMarkes();
                getMyLocation();
                myLocationMarker = new google.maps.Marker({
                    position: myLocation,
                    map: myMap.gMap,
                    icon: MarkerPurpleModel,
                    animation: google.maps.Animation.BOUNCE
                });
                myMap.Center(myLocation);
                myMap.Zoom(15);
            }
            // push controls
            myMap.PushControl(btnAdv, "right_center");
            myMap.PushControl(pan, "top_center");
            myMap.PushControl(btnLocation, 'right_bottom');


            document.getElementById('btnWahtsHere').onclick = function () {
                $("#navpanel").panel("close");
                document.getElementById('popupTextContent').innerHTML = "drow point on the map";
                $("#popupText").popup("open");

                myMap._OnOnce({
                    obj: myMap.gMap,
                    event: 'click',
                    callback: function (e) {
                        var lat = e.latLng.lat();
                        var lng = e.latLng.lng();
                        WhatHere(lat, lng);
                    }
                })
            }

            document.getElementById('btnMenu').onclick = function () {
                $("#navpanel").panel("open");
            }
            document.getElementById('btnLocation1').onclick = function () {
                if (searchBoxLocationCliked == false) {
                    getMyLocation();
                    searchBoxLocationCliked = true;
                    document.getElementById('searchBox1').value = "My Location";
                    document.getElementById('searchBox1').disabled = "disabled";
                } else {

                    document.getElementById('searchBox1').value = "";
                    document.getElementById('searchBox1').placeholder = "Enter a Location";
                    document.getElementById('searchBox1').disabled = false;
                    searchBoxLocationCliked = false;

                }

            }

            function getMyLocation() {
                if (android == true) {
                    var location = Android.getLocationByGps("");
                    if (location) {
                        var res = location.split(" ");
                        myLocation = new google.maps.LatLng(res[0], res[1]);
                    } else {
                        myMap.GetCurrentPosition(function (position) {
                            var myLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);

                        })

                    }
                } else {
                    myMap.GetCurrentPosition(function (position) {
                        myLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);

                    })
                }
            }
            getMyLocation();
            //post Code !!
            document.getElementById('btncallpostCodeRequsetRecived').onclick = function () {
                clearAllMarkes();
                initializeVariable();
                clearListnerClick();
                var userName = document.getElementById('hiddenUserName').value;
                var PhoneNumber = document.getElementById('hiddenPhoneNumber').value;
                document.getElementById('popupConfirmRequstContent').innerHTML = "you hava recived a requset post code from " + userName + "\n do you want to approve it ?";
                $("#popupConfirmRequst").popup("open");
                document.getElementById("btnPostRequsetNo").onclick = function () {
                    $("#popupConfirmRequst").popup("close");
                }

                document.getElementById("btnPostRequsetYes").onclick = function () {
                    $("#popupConfirmRequst").popup("close");
                    var location = Android.getLocationByGps("");
                    if (location) {
                        var res = location.split(" ");
                        Android.PostCode(res[0], res[1], PhoneNumber, userName, "RES");
                    } else {

                        document.getElementById('popupTextContent').innerHTML = "can't find your location check gps setting";
                        $("#popupText").popup("open");

                    }

                }

            }
            document.getElementById('btncallpostCodeRecived').onclick = function () {
                //lat lng from sms
                var postCodeLatLng = document.getElementById('hiddenLatLng').value;
                //user name from  sms
                var postCodeUserName = document.getElementById('hiddenUserName').value;

                //lat lng from my lcation
                document.getElementById('popupConfirmContent').innerHTML = "you hava recived a post code from " + postCodeUserName + "\n do you want to show it ?";
                $("#popupConfirm").popup("open");
                document.getElementById("btnPostNo").onclick = function () {
                    $("#popupConfirm").popup("close");
                }
                document.getElementById("btnPostYes").onclick = function () {
                    $("#popupConfirm").popup("close");

                    getMyLocation();
                    if (myLocation && postCodeLatLng) {
                        markerpost1 = new google.maps.Marker({
                            position: myLocation,
                            icone: MarkerPurpleModel,
                            map: myMap.gMap,
                            title: 'my location'
                        });
                        var PostCodeRes = postCodeLatLng.split(" ");
                        var PostCodeLatlng = new google.maps.LatLng(PostCodeRes[0], PostCodeRes[1]);
                        markerpost2 = new google.maps.Marker({
                            position: PostCodeLatlng,
                            map: myMap.gMap,
                            icone: MarkerPurpleModel,
                            title: 'friend location'
                        });

                        getDirection("walk", markerpost1, markerpost2);
                        clearAllMarkes();

                    } else {

                        document.getElementById('popupTextContent').innerHTML = "Erorr on reciving post code: can't find your location check gps setting";
                        $("#popupText").popup("open");

                    }
                }

            }

            document.getElementById("btnSendPostCode").onclick = function () {

                var PhoneNumber = document.getElementById('txtPhoneNumber').value;
                var userName = document.getElementById('txtUserName').value;
                var postCodeMode = $('input:radio[name=rad2]:checked').val();
                if (postCodeMode == "RES") {


                    getMyLocation();
                    if (myLocation) {
                        Android.PostCode(myLocation.lat(), myLocation.lng(), PhoneNumber, userName, "RES");
                        $("#popupPostCode").popup("close");

                    } else {
                        document.getElementById('popupTextContent').innerHTML = "can't find your location check gps setting";
                        $("#popupPostCode").popup("close");
                        $("#popupText").popup("open");

                    }


                } else {
                    Android.PostCode("0", "0", PhoneNumber, userName, "REQ");
                    $("#popupPostCode").popup("close");
                }

            }


            document.getElementById("PostCode").onclick = function () {
                initializeVariable();
                clearAllMarkes();
                clearListnerClick();
                $("#navpanel").panel("close");
                $("#popupPostCode").popup("open");
            }
            // end of post code 



            //panel show directions  controls

            //document.getElementById('btnSignIn').onclick = function () {
            //    alert('dsa');
            //    $.mobile.pageContainer.pagecontainer("change", "#pageSignIn", {
            //        transition: "slide"
            //    });
            //}
            document.getElementById('btnMinimizePanel').onclick = function () {
                $.mobile.pageContainer.pagecontainer("change", "#pageMain", {
                    transition: "slide"
                });
            }
            document.getElementById('btnClosePanel').onclick = function () {
                $.mobile.pageContainer.pagecontainer("change", "#pageMain", {
                    transition: "slide"
                });
                clearListnerClick();
            }

            //end of panel show directions

            //get dirextions 2 saerch box page  
            var searchBox1 = document.getElementById("searchBox1");
            myMap.AutoComplete({
                element: searchBox1,
                position: function (pos) {
                    markerBox1 = new google.maps.Marker({
                        position: {
                            lat: pos.lat(),
                            lng: pos.lng()
                        },
                        map: null
                    })
                }
            });

            var searchBox2 = document.getElementById("searchBox2");
            myMap.AutoComplete({
                element: searchBox2,
                position: function (pos) {
                    markerBox2 = new google.maps.Marker({
                        position: {
                            lat: pos.lat(),
                            lng: pos.lng()
                        }

                        ,
                        map: null
                    })
                }
            });

            document.getElementById('btnGetDirectionMethodTwoSearchBox1').onclick = function () {
                //getDirection(travelModes)
                if (searchBoxLocationCliked == true) {
                    if (myLocation) {
                        markerBox1 = new google.maps.Marker({
                            position: {
                                lat: myLocation.lat(),
                                lng: myLocation.lng()
                            }

                            ,
                            map: null
                        })
                    } else {

                        document.getElementById('content2').innerHTML = "can't get current location check gps setting";
                        $("#popupText2").popup("open");
                        document.getElementById("btnOkSearchBox2").onclick = function () {
                            $("#popupText2").popup("close");
                        }
                    }
                }

                var errorGetDirections = false;
                var direictionsWay = $('input:radio[name=rad1]:checked').val()
                try {
                    if (direictionsWay == 'car') {

                        getDirection('driving', markerBox1, markerBox2);

                    } else if (direictionsWay == 'walk') {

                        getDirection('walking', markerBox1, markerBox2);

                    }
                    clearAllMarkes();

                } catch (error) {
                    errorGetDirections = true;
                }


                if (errorGetDirections == false) {
                    $.mobile.pageContainer.pagecontainer("change", "#pageMain", {
                        transition: "slide"
                    });
                } else {
                    document.getElementById('content1').innerHTML = "direction not avaliable";
                    $("#popupText1").popup("open");
                }
                var searchBox1 = document.getElementById('searchBox1');
                searchBox1.value = "";
                searchBoxLocationCliked = false;
                searchBox1.disabled = false;
                document.getElementById('searchBox2').value = "";



            }

            document.getElementById('btn2point').onclick = function () {
                clearAllMarkes();
                initializeVariable();

                $("#navpanel").panel("close");
                drowPoint1()
            }
            var btnGetDirectionMethodTwoSearchBox = document.getElementById('btnGetDirectionMethodTwoSearchBox');
            btnGetDirectionMethodTwoSearchBox.onclick = function () {
                clearAllMarkes();
                initializeVariable();
                clearListnerClick();
                alert("ok");
                $.mobile.pageContainer.pagecontainer("change", "#PageGetDirection", {

                });
            }
            document.getElementById('btnCar').onclick = function () {
                $("#popupDialogDireictionMethod2Point").popup("close")

                getDirection('driving', markerPoint1, markerPoint2);
                clearAllMarkes();
            }
            document.getElementById('btnWalk').onclick = function () {

                $("#popupDialogDireictionMethod2Point").popup("close")

                getDirection('walking', markerPoint1, markerPoint2);
                clearAllMarkes();
            }
            document.getElementById('btnOk').onclick = function () {

                $("#popupText").popup("close");
            }

            document.getElementById('btnOkSearchBox').onclick = function () {

                $("#popupText1").popup("close");
            }
            //end get directions page 

            //call GetDirections in codepros
            function getDirection(travelModes, positionStart, positionEnd) {
                myMap.GetDirections({
                    start: new google.maps.LatLng(positionStart.getPosition().lat(), positionStart.getPosition().lng()),
                    end: new google.maps.LatLng(positionEnd.getPosition().lat(), positionEnd.getPosition().lng()),
                    travelMode: travelModes,
                    panel: "directions",
                    error: function () {
                        document.getElementById('popupTextContent').innerHTML = "direction not avaliable";
                        $("#popupText").popup("open");


                    },
                    success: function () {
                        myMap._On({
                            obj: myMap.gMap,
                            event: 'click',
                            callback: function (e) {

                                $.mobile.pageContainer.pagecontainer("change", "#pagePanel", {
                                    transition: "slideup"
                                });
                            }
                        })

                    }
                });

            }

            //to drow first point1 and call drowPoont2() 
            function drowPoint1() {
                //intilize
                clearListnerClick();
                //add event to map
                myMap._OnOnce({
                    obj: myMap.gMap,
                    event: 'click',
                    callback: function (e) {
                        markerPoint1 = new google.maps.Marker({
                            position: {
                                lat: e.latLng.lat(),
                                lng: e.latLng.lng()
                            },
                            map: this.gMap,
                            animation: google.maps.Animation.DROP,
                            "icon": MarkerBlueModel
                        })
                        //call drowPoint2()

                        drowPoint2();

                    }
                })
            }

            function drowPoint2() {
                myMap._OnOnce({
                    obj: myMap.gMap,
                    event: 'click',
                    callback: function (e) {
                        markerPoint2 = new google.maps.Marker({
                            position: {
                                lat: e.latLng.lat(),
                                lng: e.latLng.lng()
                            },
                            map: this.gMap,
                            icon: MarkerBlueModel,
                            animation: google.maps.Animation.DROP
                        })
                        $("#popupDialogDireictionMethod2Point").popup("open")

                    }
                }

                );
            }

            function initializeVariable() {
                myMap.ClearRoutes();
                markerPoint1 = null;
                markerPoint2 = null;
                markerBox1 = null;
                markerBox2 = null;
                markerpost1 = null;
                markerpost2 = null;
                markerAds = null;

            }

            function clearAllMarkes() {
                if (markerAds) {
                    myMap.clearMark(markerAds);

                }
                if (markerPoint1) {

                    myMap.clearMark(markerPoint1);
                }
                if (markerPoint2) {

                    myMap.clearMark(markerPoint2);
                }
                if (markerBox1) {
                    myMap.clearMark(markerBox1);
                }
                if (markerBox2) {
                    myMap.clearMark(markerBox2);
                }
                if (markerpost1) {
                    myMap.clearMark(markerpost1);
                }
                if (markerpost2) {

                    myMap.clearMark(markerpost2);
                }
                if (myLocationMarker) {
                    myMap.clearMark(myLocationMarker);
                }
                if (window.adsMarkerPoint) {

                  
                    myMap.clearMark(window.adsMarkerPoint);

                }
                
            }

            function clearListnerClick() {
                google.maps.event.clearListeners(myMap.gMap, 'click');
            }

            //move to damscus
            myMap.Geocode({
                location: "damascus",
                success: function (results) {
                    console.log(results);
                },
                error: function () {
                    console.log("okay");
                }
            });

            function WhatHere(lat, lng) {

                var lat = lat,
                    lng = lng,
                    latLngHere = new google.maps.LatLng(lat, lng),
                    whatsHereinformationDiv;
                myMap.Geocode({
                    latLng: latLngHere,
                    success: function (results, status) {


                        document.getElementById('popInforamtionText').innerHTML = '<p><span class="glyphicon glyphicon-map-marker" aria-hidden="true"> ' + (results[0].address_components[0] && results[0].address_components[0].short_name || '') + ',' +
                            (results[0].address_components[1] && results[0].address_components[1].short_name || '') + '</p>';
                        $("#popInforamtion").popup("open");

                    },
                    error: function (status) {
                        alert("Sorry the place you pick is available in our library .. Please Try Another Place");
                        console.log(status);
                    }
                })
            }

            window.myMap = myMap;
            window.adsMarkerPoint = adsMarkerPoint;

        })(window, window.Codepros)

        function dorwMarker(lat, lng) {
            $("#adsPanel").panel("close");
            window.myMap.ClearRoutes();
            if (window.adsMarkerPoint) {
                
                window.myMap.clearMark(adsMarkerPoint);
                            }
            var myMap = window.myMap;
            window.adsMarkerPoint= new google.maps.Marker({
                position: {
                    lat: lat,
                    lng: lng
                },
                map: myMap.gMap

            })

            myMap.Center(new google.maps.LatLng(lat, lng));
        }

    </script>

</body>
</html>
