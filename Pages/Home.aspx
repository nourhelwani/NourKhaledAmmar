<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Home.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Pages_Home" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HomeContent" runat="Server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>

    <!-- Main Map -->
    <div id="mainMap"></div>

    <!-- Geo location -->
    <button id="btnGeolocation"><span class="glyphicon glyphicon-send" aria-hidden="true"></span></button>

    <!--Weather Icon -->
    <img alt="Weather" id="weatherIcon" title="Click For More Information" />

    <!--Weather Info Div-->
    <div id="weatherInfoDiv">
        <table class="table table-striped">
            <tr>
                <td>
                    <h5 class="text-warning">Description</h5>
                </td>
                <td>
                    <p class="text-info" id="lblWeatherDesciption">
                </td>
            </tr>
            <tr>
                <td>
                    <h5 class="text-warning">Humidity</h5>
                </td>
                <td>
                    <p class="text-info" id="lblWeatherHumidity">
                </td>
            </tr>
            <tr>
                <td>
                    <h5 class="text-warning">Temperature</h5>
                </td>
                <td>
                    <p class="text-info" id="lblWeatherTemp">
                </td>
            </tr>
            <tr>
                <td>
                    <h5 class="text-warning">Pressure</h5>
                </td>
                <td>
                    <p class="text-info" id="lblWeatherPressure">
                </td>
            </tr>
            <tr>
                <td>
                    <h5 class="text-warning">Wind</h5>
                </td>
                <td>
                    <p class="text-primary" id="lblWeatherWind">
                </td>
            </tr>
        </table>
        <a href="WeatherHistory.aspx">Show History..</a>
    </div>

    <!-- Nearby Places -->

    <!--Div Search for Shop-->
    <div id="divSearchForShopInMap" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <button type="button" id="btnShopOnMap" style="width: 100%" class="btn btn-info">Search for places nearby</button>
            </div>
        </div>
    </div>

    <!-- glyphicon glyphicon-globe For Google AutoComplete -->
    <!-- glyphicon glyphicon-map-marker For JQuery AutoComplete-->
    <span id="spanSelectOp" class="glyphicon glyphicon-map-marker" aria-hidden="true" style="z-index:1;cursor: pointer; position: absolute; top: 23px; left: 390px;"></span>

    <!--Div choose Marker -->
    <div id="divChooseMarker" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <button type="button" id="btnShopByName" style="width: 50%" class="btn btn-info">Shop By Name</button>
                <button type="button" id="btnShopByGener" style="position: absolute; width: 50%" class="btn btn-info">Shop By Genre</button>
                <div id="divGenerSearch" style="display: none">
                    <label style="font-size: small">Search For : </label>
                    <asp:DropDownList ID="ddlGenerName" runat="server" class="form-control"></asp:DropDownList><br />
                    <button type="button" id="btnGenerSearch" class="btn btn-default">Search</button>
                    <asp:HiddenField runat="server" ID="lblGenerName" />
                </div>

                <div id="divNameSearch" style="display: none">
                    <label style="font-size: small">Search : </label>
                    <input type="text" class="form-control" id="tboxMarkerName" placeholder="Marker Name " /><br />
                    <p id="lblMarkerNameForSearch" style="display: none"></p>
                    <button type="button" id="btnGatDirection" class="btn btn-default">Direction To</button>

                </div>
            </div>
        </div>
    </div>
    <div id="divFadeResult" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div id="divResult">
                    <label id="lblMarkerName" style="font-size: small"></label>
                    <br />
                    <label id="lblMarkerAddress" style="font-size: small"></label>
                    <br />
                    <label id="lblMarkerDescription" style="font-size: small"></label>
                    <br />
                    <label id="lblMarkerType" style="font-size: small"></label>
                    <br />
                    <button type="button" id="btnGetDirectionFromCurrentPoss" class="btn btn-default">Get Direction</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Search Text box -->
    <input type="text" class="controls" id="tboxSearchGoogle" placeholder="Search..." />
    <input type="text" class="controls" id="tboxSearchMain" placeholder="Search..." />
    
    <button id="btnSearch" class="controls btn btn-danger"><span aria-hidden="true" class="glyphicon glyphicon-search"></span></button>
    <p id="lblSearchMainId" style="display: none"></p>

    <!--Information Div-->
    <div id="informationDiv" class="Information-Window">
    </div>

    <!--MarkerInfo Div-->
    <div id="markerInfoWindow" class="Marker-Info-Window">
        <span class="glyphicon glyphicon-remove" aria-hidden="true" id="markerInfoWindowCloseBtn"></span>
        <span style="display: none" id="markerIDCell"></span>
        <table class="table-condensed">
            <tr>
                <th rowspan="2">
                    <img id="ImageCell" height="80px" width="70px" onerror="this.src='\\Photos\\1.png'" />
                </th>
                <th id="markerNameCell" style="padding-left: 10px">
                    <h5>Marker Name</h5>
                </th>
            </tr>
            <tr>
                <td id="markerAddressCell" style="padding-bottom: 20px; padding-left: 10px">
                    <h6>Address</h6>
                </td>
            </tr>
            <tr>
                <td colspan="2" id="markerDescriptionCell" style="padding-top: 10px">
                    <p>Description</p>
                </td>
            </tr>
        </table>
        <a href="#" id="markerShowMoreLink" style="padding-left: 5px">Show More..</a>
    </div>
    <script>

        (function (window, Codepros, $) {

            //Loading Map
            var mapOption = {
                center: new google.maps.LatLng(33.51849923765608,36.287841796875),
                zoom:11,
                minZoom:12,
                geocoder:true,
                markerClusterer:false,
                panControl: false,
                zoomControl: true,
                zoomControlOptions:{
                    style: google.maps.ZoomControlStyle.SMALL,
                    position: google.maps.ControlPosition.RIGHT_BOTTOM
                },
                mapTypeControl: false,
                scaleControl: false,
                streetViewControl: false,
                overviewMapControl: false,
                styles:[{
                    featureType:'poi',
                    elementtype:'labels',
                    stylers:[
                    {	visibility:'off'	}
                    ]
                }]
            },
                mainMap = Codepros.CreateNew(document.getElementById('mainMap') , mapOption);
            
            //Loading Markers with Icons
            
            var customIcons = {
                Bank:{
                    icon:'/Icons/Bank.png'
                },
                BusStation:{
                    icon:'/Icons/BusStation.png'
                },
                Cafe:{
                    icon:'/Icons/Cafe.png'
                },
                Company:{
                    icon:'/Icons/Company.png'
                },
                CondominiumComplex:{
                    icon:'/Icons/CondominiumComplex.png'
                },
                Gym:{
                    icon:'/Icons/Gym.png'
                },
                Hospital:{
                    icon:'/Icons/Hospital.png'
                },
                MovieTheater:{
                    icon:'/Icons/MovieTheater.png'
                },
                Resort:{
                    icon:'/Icons/Resort.png'
                },
                Resturant:{
                    icon:'/Icons/Resturant.png'
                },
                Service:{
                    icon:'/Icons/Service.png'
                },
                ShoppingMall:{
                    icon:'/Icons/ShoppingMall.png'
                },
                Therapist:{
                    icon:'/Icons/Therapist.png'
                },
                University:{
                    icon:'/Icons/University.png'
                },
                Worship:{
                    icon:'/Icons/Worship2.png'
                },
                Electronic:{
                    icon:'/Icons/Electronic.png'
                },
                Clothing:{
                    icon:'/Icons/Clothing.png'
                }
            },
                markers = <%=JSONHelper.AllMarkersHome()%>;

            for(var item in markers){
                    
                var currentMarker = markers[item],
                    type = currentMarker.TYPE.replace(' ',''),
                    icon = customIcons[type];
                
                mainMap.CreateMarker({
                    id:currentMarker.MARKER_ID,
                    name:currentMarker.MARKER_NAME,
                    description:currentMarker.DESCRIPTION,
                    image:currentMarker.MAIN_IMAGE_PATH,
                    address:currentMarker.ADDRESS,
                    lat:currentMarker.LAT,
                    lng:currentMarker.LNG,
                    type:currentMarker.TYPE,
                    icon:icon.icon,
                    events:[{
                        name:'click',
                        callback:function(){
                            var markerInfoWindow = document.getElementById('markerInfoWindow'),
                                markerNameCell = document.getElementById('markerNameCell'),
                                markerAddressCell = document.getElementById('markerAddressCell'),
                                markerDescription = document.getElementById('markerDescriptionCell'),
                                markerIdCell = document.getElementById('markerIDCell'),
                                markerImageCell = document.getElementById('ImageCell');

                            markerNameCell.innerHTML = '<h5>'+arguments[1].name+'<small> ('+arguments[1].type+')</small></h5>';
                            markerAddressCell.innerHTML = '<h6>'+arguments[1].address+'</h6>';
                            markerDescription.innerHTML = '<p>'+arguments[1].description+'</p>';
                            markerIdCell.innerHTML = arguments[1].id;
                            markerImageCell.src = arguments[1].image;
                            console.clear();
                            markerInfoWindow.style.display = 'block';
                        }
                    }]
                });
            }
            document.getElementById('markerInfoWindowCloseBtn').onclick = function(){
                document.getElementById('markerInfoWindow').style.display = 'none';
            }
            document.getElementById('markerShowMoreLink').onclick = function(){
                var showMoreSelectedId = document.getElementById('markerIDCell').innerHTML;
                window.location.href = "ViewMorePage.aspx?Id="+showMoreSelectedId;
            }
            
            //Loading Weather Condition
            $.getJSON('http://api.openweathermap.org/data/2.5/weather?q=Damascus,sy&units=metric', function (response) {

                var weatherIcon = document.getElementById('weatherIcon');
                $('#weatherIcon').attr('src','http://openweathermap.org/img/w/'+response.weather[0].icon+'.png');
                document.getElementById('lblWeatherDesciption').innerText = response.weather[0].description;
                document.getElementById('lblWeatherHumidity').innerText = response.main.humidity +' %';
                document.getElementById('lblWeatherTemp').innerText = response.main.temp+' C';
                document.getElementById('lblWeatherPressure').innerText = response.main.pressure+' hpa';
                document.getElementById('lblWeatherWind').innerText = response.wind.speed +' Km/ '+response.wind.deg+' Degree';
                mainMap.PushControl(weatherIcon,'top_right');
            }, function (error) {
                console.log(error);
                alert("The Service is Off now .. Please Try again in an hour or two :)");
            });



            document.getElementById('weatherIcon').onclick = function(){
                $( "#weatherInfoDiv" ).toggle( "blind" );
            };

            //Load Source to Auto complete text box
            var allMarkersData = <%=JSONHelper.MarkersInfoForSearch()%>,
                allMarkersArray = [],
                searchResultMarker,
                finalResult;

            for(var item in allMarkersData) {
                var toAdd = {
                    label:allMarkersData[item].name,
                    value:allMarkersData[item].id,
                    address:allMarkersData[item].address
                }
                allMarkersArray.push(toAdd);
            }

            $('#tboxSearchMain').autocomplete({
                source: allMarkersArray,
                focus:function(event,ui){
                    $('#tboxSearchMain').val(ui.item.label);
                    return false;
                },
                select: function (event , ui) {
                    $('#tboxSearchMain').val(ui.item.label);
                    $('#lblSearchMainId').text(ui.item.value);
                    PageMethods.MarkerInfoViaID(ui.item.value,function(response){
                        
                        //Had Selected One
                        finalResult = $.parseJSON(response);
                        console.log(finalResult);

                    },function(error){
                        console.log(error);
                    });
                    return false;
                }
            }).data('ui-autocomplete')._renderItem = function(ul,item){
                return $('<li>').append("<a>"+item.label+"&nbsp&nbsp<small><font color='gray'>"
                    +item.address+"</font></small></a>").appendTo(ul);
            };

            document.getElementById('btnSearch').onclick = function(){
                if(document.getElementById('tboxSearchMain').value.length>0){

                    //Had Selected One
                    PageMethods.MarkerInfoViaMarkerName(document.getElementById('tboxSearchMain').value,function(reponse){
                        
                        var searchResult = $.parseJSON(reponse);
                        if(searchResult[0]){
                            console.log(searchResult[0]);
                        } else {
                            alert('Sorry no Results Found');
                        }

                    },function(error){
                        
                        alert(error);

                    });
                }
                return false;
            }

            mainMap.PushControl(document.getElementById('tboxSearchMain'),'top_left');
            mainMap.PushControl(document.getElementById('btnSearch'),'top_left');

            //End Loading Sources

            //Switching From jQuery To Google

            var mySpan = document.getElementById('spanSelectOp'),
                clicked = false,
                tboxSearchPlaces = document.getElementById('tboxSearchMain'),
                tboxSearchGoogle = document.getElementById('tboxSearchGoogle');
            
            mainMap.AutoComplete(tboxSearchGoogle);

            mySpan.onclick = function() {
                clicked = !clicked;                
                if( clicked ) {
                    mySpan.className = 'glyphicon glyphicon-globe';
                    tboxSearchPlaces.style.display = 'none';
                    tboxSearchGoogle.style.display = 'block';
                    document.getElementById('btnSearch').style.left = '415px';
                } else {
                    mySpan.className = 'glyphicon glyphicon-map-marker';
                    tboxSearchPlaces.style.display = 'block';
                    tboxSearchGoogle.style.display = 'none';
                    document.getElementById('btnSearch').style.left = '415px';
                }
            }
            mySpan.onmousemove = function(){
                mySpan.style.color = '#C91108';
            }
            mySpan.onmouseleave = function(){
                mySpan.style.color = 'black';
            }

            //End Switching From jQuery To Google

            //Geo location
            var btnGeolocation = document.getElementById('btnGeolocation'),
                pos,  //for SAve current position 
                Distence,  //for Calculate Distance between current position and Markers
                Markers,   // Array Of Markers
                id,   //Id Markers have less distance
                currentMarker,  //current position Marker
                finalResult; //for auto complete Result in Geo Location
            mainMap.PushControl(btnGeolocation,'right_bottom');
            //for Get Current Position And Show Div 
            btnGeolocation.onclick = function () {
                mainMap.GetCurrentPosition(function (position) {
                    pos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
                    mainMap.Zoom(16);
                    mainMap.Center(pos);
                    if (!currentMarker) {
                        currentMarker = new google.maps.Marker({
                            position: pos,
                            map: mainMap.gMap,
                            animation: google.maps.Animation.BOUNCE
                        });
                    }
                });
                $("#divSearchForShopInMap").modal('show');
                return false;
            };
            //button in Div
            var btnChooseMarkerOnMap = document.getElementById("btnShopOnMap");
            btnChooseMarkerOnMap.onclick = function () {
                $("#divSearchForShopInMap").modal('hide');
                $("#divChooseMarker").modal('show');
            };
            //on click button searech by Shop Name
            document.getElementById("btnShopByName").onclick = function () {
                var aallMarkersData = <%=JSONHelper.MarkersInfoForSearch()%>;
                var aallMarkersArray = [];
                for(var item in allMarkersData) {
                    var toAdd = {
                        label:aallMarkersData[item].name,
                        value:aallMarkersData[item].id,
                        address:aallMarkersData[item].address
                    }
                    aallMarkersArray.push(toAdd);
                }
                console.log(document.getElementById('tboxMarkerName'));
                $("#tboxMarkerName").autocomplete({
                    source: aallMarkersArray,
                    focus:function(event,ui){
                        $("#tboxMarkerName").val(ui.item.label);
                        return false;
                    },
                    select: function (event , ui) {
                        $("#tboxMarkerName").val(ui.item.label);
                        $("#lblMarkerNameForSearch").text(ui.item.value);
                        PageMethods.MarkerInfoViaID(ui.item.value,function(response){
                            //Had Selected One
                            finalResult = $.parseJSON(response);
                            console.log(finalResult);
                        },function(error){
                            console.log(error);
                        });
                        return false;
                    }
                }).data("ui-autocomplete")._renderItem = function( ul, item ) {
                    return $( "<li>" ).append( "<a>" + item.label + "<br>" + item.address + "</a>" )
                      .appendTo( ul );
                };
                document.getElementById("divGenerSearch").style.display = "none";
                document.getElementById("divNameSearch").style.display = "block";
            };
            //on click button searech by Gener 
            document.getElementById("btnShopByGener").onclick = function () {
                document.getElementById("divGenerSearch").style.display = "block";
                document.getElementById("divNameSearch").style.display = "none";
            };
            //on click Search By gener Button
            var btnGenerSearch = document.getElementById("btnGenerSearch");
            btnGenerSearch.onclick = function () {
                PageMethods.GetMarkerByType(document.getElementById('<%=lblGenerName.ClientID%>').value, function (response) {
                    Markers = $.parseJSON(response);
                    console.log(Markers);
                    if (Markers.length == 0) {
                        alert('dont have Marker in This gener');
                    }else {
                        //Full First Marker to Comparison
                        id = Markers[0].MARKER_ID;
                        Distence = mainMap.CalculateDistance({
                            start: new google.maps.LatLng(Markers[0].LAT, Markers[0].LNG),
                            end: pos
                        });
                        //Get less distence
                        for (var marker in Markers){
                            var toCalc = Markers[marker];
                            var newDistence = 0;
                            newDistence = mainMap.CalculateDistance({
                                start: new google.maps.LatLng(toCalc.LAT, toCalc.LNG),
                                end:pos
                            });
                            //console.log(newDistence);
                            if (Distence > newDistence) {
                                Distence = newDistence;
                                id = toCalc.MARKER_ID;
                            }
                        }
                        //Fill Div Info In Less Marker Distence Info
                        for (var marker in Markers) {
                            var toCalc = Markers[marker];
                            if (toCalc.MARKER_ID == id) { 
                                document.getElementById('lblMarkerName').innerHTML = "Marker Name : "+ toCalc.MARKER_NAME;
                                document.getElementById('lblMarkerAddress').innerHTML = "Addeess :" + toCalc.ADDRESS;
                                document.getElementById('lblMarkerDescription').innerHTML = "Description : " + toCalc.DESCRIPTION;
                                document.getElementById('lblMarkerType').innerHTML = "Type : " + toCalc.TYPE;
                                break;
                            }
                        }
                        $("#divChooseMarker").modal('hide');
                        $("#divFadeResult").modal('show');
                    }
                }, function(error) {
                    console.dir(error);
                });   
            };
            //on click Get Direction By Name
            var btnNameSearch = document.getElementById("btnGatDirection");
            btnNameSearch.onclick = function () {
                var lat,lng;
                lat=finalResult[0].LAT;
                lng=finalResult[0].LNG;
                mainMap.GetDirections({
                    start : pos,
                    end: new google.maps.LatLng(lat, lng)
                });
                $("#divChooseMarker").modal('hide');
            };
            //on click Get Direction button By Gener Search
            var btnGetDirectionToMarker = document.getElementById('btnGetDirectionFromCurrentPoss');
            btnGetDirectionToMarker.onclick = function () {
                var lat,lng;
                for(marker in Markers){
                    var toAdd=Markers[marker];
                    if(toAdd.MARKER_ID==id){
                        lat=toAdd.LAT;
                        lng=toAdd.LNG;
                    }
                }
                mainMap.GetDirections({
                    start : pos,
                    end: new google.maps.LatLng(lat, lng)
                });
                $("#divFadeResult").modal('hide');
            };

            //End Geolocation

            //Bound Map
            //SouthEast 33.41195588997615, 36.120643615722656
            //NorthWest 33.625483275965045, 36.455039978027344

            var allowedBounds = new google.maps.LatLngBounds(
                new google.maps.LatLng(33.41195588997615, 36.120643615722656), 
                new google.maps.LatLng(33.625483275965045, 36.455039978027344)
            ),
                lastValidLocation = mainMap.Center();
            
            mainMap.gMap.fitBounds(allowedBounds);
            mainMap._AttachEvents(mainMap.gMap,[{

                name:'dragend',
                callback:function(){
                    if(allowedBounds.contains(mainMap.Center())){
                        lastValidLocation = mainMap.gMap.getCenter();
                    }
                    mainMap.Center(lastValidLocation);
                }
            }]);
            //End Bounding Map
            //Creating Context Menu


            mainMap._AttachEvents(mainMap.gMap,[{
                name:'rightclick',
                callback:function(e){
                    var projection,
                        contextMenuDir,
                        latLngArray = [e.latLng.lat(),e.latLng.lng()];
                    projection = mainMap.gMap.getProjection();
                    $('.Context-Menu').remove();
                    document.getElementById('informationDiv').style.display='none';
                    contextMenuDir = document.createElement('div');
                    contextMenuDir.className = 'Context-Menu';
                    contextMenuDir.innerHTML = '<table class="table-hover" style="width:100%"><tr><td style="padding-left:15px">'+
                        '<h6 id="lblWhatsHere" onclick="WhatHere('+latLngArray+')">Whats Here</h6></td></tr><tr><td style="padding-left:15px">'+
                        '<h6 id="lblCalculateDistance" onclick="CalculateDistance('+latLngArray+')">Calculate Distance</h6></td></tr>'+
                        '<tr><td style="padding-left:15px"><h6 id="lblGetDirectionsFromHere" onclick="ContextGetDirection('+latLngArray+','+0+')">Directions To</td></tr>'+
                        '<td style="padding-left:15px"><h6 id="lblGetDirectionsFromHere" onclick="ContextGetDirection('+latLngArray+','+1+')">Directions From</td></tr></table>';
                    //contextMenuDir.innerHTML = '<a id="lblHome" onclick="getMeHome()"><div class="context">Get Me Back Home</div></a>';
                    $(mainMap.gMap.getDiv()).append(contextMenuDir);

                    var mapWidth = $('#mainMap').width(),
                        mapHeight = $('#mainMap').height(),
                        menuWidth = $('.Context-Menu').width(),
                        menuHeight = $('.Context-Menu').height(),
                        scale = Math.pow(2,mainMap.Zoom()),
                        nw = new google.maps.LatLng(
                            mainMap.gMap.getBounds().getNorthEast().lat(),
                            mainMap.gMap.getBounds().getSouthWest().lng()
                        ),
                        worldProjection = mainMap.gMap.getProjection().fromLatLngToPoint(nw),
                        worldCoordinate = mainMap.gMap.getProjection().fromLatLngToPoint(e.latLng),
                        currentLatLngOffset = new google.maps.Point(
                            Math.floor((worldCoordinate.x-worldProjection.x)*scale),
                            Math.floor((worldCoordinate.y-worldProjection.y)*scale)
                        ),
                        x = currentLatLngOffset.x,
                        y = currentLatLngOffset.y;
                    if((mapWidth - x) < menuWidth)
                        x = x - menuWidth;
                    if((mapHeight - y ) < menuHeight)
                        y = y - menuHeight;
                    $('.Context-Menu').css('left',x );
                    $('.Context-Menu').css('top',y );

                    contextMenuDir.style.visibility = 'visible';
                    document.getElementById('weatherInfoDiv').style.display='none';
                }
            },{
                name:'click',
                callback:function(){
                    $('.Context-Menu').remove();
                    document.getElementById('informationDiv').style.display='none';
                    document.getElementById('weatherInfoDiv').style.display='none';
                }
            },{
                name:'dragstart',
                callback:function(){
                    $('.Context-Menu').remove();
                }
            }])
            //EndContextMenu

            //Injecting Map
            window.mainMap = mainMap;

        })(window, window.Codepros, jQuery);

        function WhatHere(currentPosition){
            $('.Context-Menu').remove();
            var lat = arguments[0],
                lng = arguments[1],
                latLngHere = new google.maps.LatLng(lat,lng),
                whatsHereinformationDiv;
            mainMap.Geocode({
                latLng:latLngHere,
                success:function(results,status){
                    var informationWindow = document.getElementById('informationDiv'),
                        markerInfoWindow = document.getElementById('markerInfoWindow');
                    
                    informationWindow.style.display='block';
                    
                    if($(markerInfoWindow).is(':visible')){
                        informationWindow.style.marginTop = $(markerInfoWindow).height() + Number($(markerInfoWindow).css('margin-top').replace("px", "")) + 20 + 'px';
                    } else {
                        informationWindow.style.marginTop = '60px';
                    }

                    document.getElementById('informationDiv').innerHTML ='<p><span class="glyphicon glyphicon-map-marker" aria-hidden="true"> '+(results[0].address_components[0]&&results[0].address_components[0].short_name||'')+','+
                        (results[0].address_components[1] && results[0].address_components[1].short_name || '') +'</p>';
                    $(mainMap.gMap.getDiv()).append(document.getElementById('informationDiv'));
                    mainMap.PushControl(document.getElementById('infomationDiv'),'left_top');
                    

                },
                error:function(status){
                    alert("Sorry the place you pick is available in our library .. Please Try Another Place");
                    console.log(status);
                }
            })
        }

        function CalculateDistance(){
            $('.Context-Menu').remove();
            var firstPoint = new google.maps.LatLng(arguments[0],arguments[1]),
                secondPoint,
                distance;
            alert('Click on the Map to Determine your second Point');
            mainMap._OnOnce({
                obj:mainMap.gMap,
                event:'click',
                callback:function(e){
                    secondPoint = new google.maps.LatLng(e.latLng.lat(),e.latLng.lng()),
                    distance = mainMap.CalculateDistance({
                        start:firstPoint,
                        end:secondPoint
                    });
                    alert(distance/1000+" -Kilometers");
                }
            });
        }

        function ContextGetDirection(){
            $('.Context-Menu').remove();
            var firstPoint = new google.maps.LatLng(arguments[0],arguments[1]),
                secondPoint,
                operation = arguments[2];
            alert('Click on the Map to Determine your second Point');
            mainMap._OnOnce({
                obj:mainMap.gMap,
                event:'click',
                callback:function(e){
                    secondPoint = new google.maps.LatLng(e.latLng.lat(),e.latLng.lng());
                    if (operation === 0) {
                        mainMap.GetDirections({
                            start:firstPoint,
                            end:secondPoint,
                            travelMode:'driving'
                        });
                    } else if(operation === 1){
                        mainMap.GetDirections({
                            start:secondPoint,
                            end:firstPoint,
                            travelMode:'driving'
                        });
                    }
                }
            });
        }

        function ChangeLabelText() {
            var ddlSelectGenre = document.getElementById('<%=ddlGenerName.ClientID%>'),
                            tboxSelectedGenre = document.getElementById('<%=lblGenerName.ClientID%>');
            tboxSelectedGenre.value = ddlSelectGenre.options[ddlSelectGenre.selectedIndex].text;
            console.log(tboxSelectedGenre.value);
        }

        function autoComleate(elementId,label) {
            //mo s3'aleh 100%
            var tbox="#"+elementId,
                newlabel="#"+label;

            var allMarkersData = <%=JSONHelper.MarkersInfoForSearch()%>,
                allMarkersArray = [],
                //searchResultMarker,
                finalResult;
            for(var item in allMarkersData) {
                var toAdd = {
                    label:allMarkersData[item].name,
                    value:allMarkersData[item].id,
                    address:allMarkersData[item].address
                }
                allMarkersArray.push(toAdd);
            }
            $(tbox).autocomplete({
                source: allMarkersArray,
                focus:function(event,ui){
                    $(tbox).val(ui.item.label);
                    return false;
                },
                select: function (event , ui) {
                    $(tbox).val(ui.item.label);
                    $(newlabel).text(ui.item.value);
                    alert('dsa');
                    PageMethods.MarkerInfoViaID(ui.item.value,function(response){
                        //Had Selected One
                        finalResult = $.parseJSON(response);
                        console.log(finalResult);
                    },function(error){
                        console.log(error);
                    });
                    return false;
                }
            }).data('ui-autocomplete')._renderItem = function(ul,item){
                return $('<li>').append("<a"+item.label+"&nbsp&nbsp<small><font color='gray'>"
                    +item.address+"</font></small></a>").appendTo(ul);
            };
        }
        
    </script>

</asp:Content>

