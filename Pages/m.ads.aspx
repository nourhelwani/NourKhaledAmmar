<%@ Page Language="C#" AutoEventWireup="true" CodeFile="m.ads.aspx.cs" Inherits="Pages_Default" EnableEventValidation="false" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>

<%@ Register TagName="ads" TagPrefix="my" Src="~/CustomControl/MainAds.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript" src="../Scripts/jquery1.10.2.js"></script>
    <script type="text/javascript" src="../Scripts/jqueryui1.11.3.js"></script>
    <script type="text/javascript" src="../Scripts/bootstrap.min.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
    <link rel="stylesheet" type="text/css" href="tautocomplete.css" media="screen" />
    <script src="http://maps.google.com/maps/api/js?sensor=false&libraries=places,geometry&language=ar"></script>
    <script type="text/javascript" src="../Scripts/MarkerClusterer.js"></script>
    <script type="text/javascript" src="../Scripts/list.js"></script>
    <script type="text/javascript" src="../Scripts/Codepros.js"></script>
    <link rel="stylesheet" href="../CSSs/bootstrap.min.css" />
    <link rel="stylesheet" href="../CSSs/Home.css" />
    <style>
        .ui-state-hover, .ui-widget-content .ui-state-hover, .ui-widget-header .ui-state-hover, .ui-state-focus, .ui-widget-content .ui-state-focus, .ui-widget-header .ui-state-focus {
            background: #4caace;
            border: none;
            color: #000;
            border-radius: 0;
            font-weight: normal;
        }
    </style>
    <title>advertisment</title>


    <style>
        body {
            padding-top: 60px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">

        <asp:LinkButton runat="server" ID="hiddenSearchBtn" OnClick="hiddenSearchBtn_Click1" />
        <input runat="server" type="hidden" id="hiddenSearchParm" />
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" EnablePartialRendering="true"></asp:ScriptManager>
        <asp:UpdatePanel runat="server">
            <Triggers>
            </Triggers>
            <ContentTemplate>

                <nav class="navbar navbar-inverse navbar-fixed-top">
                    <div class="navbar-header">
                        <a class="navbar-brand " href="m.Home.aspx">3alyamen</a>
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                    </div>
                    <div class="navbar-collapse collapse">
                        <ul class="nav navbar-nav">
                            <li><a href="#">my panel</a></li>

                            <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" runat="server" id="btnSelectSortBy" href="#">Sort by <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <asp:Button ID="btnSortNewest" runat="server" ToolTip="NEWEST" OnClick="SelectSortChange_Click" Text="newest" data-role="none" Style="border: hidden; background-color: white; margin: 0px; padding: 5px; text-align: left"
                                            Font-Bold="true" Width="100%" /></li>

                                    <li>
                                        <asp:Button ID="btnSortOldest" runat="server" ToolTip="OLDEST" OnClick="SelectSortChange_Click" Text="oldest" data-role="none" Style="border: hidden; background-color: white; margin: 0px; padding: 5px; text-align: left"
                                            Font-Bold="true" Width="100%" /></li>

                                    <li>
                                        <asp:Button ID="btnSortCategory" runat="server" ToolTip="CATEGORY" OnClick="SelectSortChange_Click" Text="category" data-role="none" Style="border: hidden; background-color: white; margin: 0px; padding: 5px; text-align: left"
                                            Font-Bold="true" Width="100%" /></li>

                                    <li>
                                        <asp:Button ID="btnSortType" runat="server" ToolTip="MOSTVISTED" OnClick="SelectSortChange_Click" Text="visit" data-role="none" Style="border: hidden; background-color: white; margin: 0px; padding: 5px; text-align: left"
                                            Font-Bold="true" Width="100%" /></li>


                                </ul>
                                <li class="dropdown"><a class="dropdown-toggle" id="btnSelectType" runat="server" data-toggle="dropdown" href="#">type <span class="caret"></span></a>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <asp:Button ID="btnAds" runat="server" OnClick="SelectTypeChange_Click" ToolTip="Normal" Text="advertisment" data-role="none" Style="border: hidden; background-color: white; margin: 0px; padding: 5px; text-align: left"
                                                Font-Bold="true" Width="100%" />

                                        <li>
                                            <asp:Button ID="btnEvent" runat="server" OnClick="SelectTypeChange_Click" ToolTip="Event" Text="event" data-role="none" Style="border: hidden; background-color: white; margin: 0px; padding: 5px; text-align: left"
                                                Font-Bold="true" Width="100%" />
                                        <li>
                                            <asp:Button ID="btnAll" runat="server" OnClick="SelectTypeChange_Click" Text="all type" data-role="none" Style="border: hidden; background-color: white; margin: 0px; padding: 5px; text-align: left"
                                                Font-Bold="true" Width="100%" />
                                    </ul>

                                </li>

                        </ul>
                    </div>
                </nav>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="row" style="margin: 10px">
            <div class="col-md-4">
                <div class="input-group" >
                    <span class="input-group-btn">
                        <asp:Button ID="btnSearch" Style="padding: 6px; color: black" CssClass="btn btn-default" Text="search" runat="server" OnClick="btnSearch_Click" />
                    </span>
                    <input type="text" id="searchBox" runat="server" class="form-control" placeholder="Search for...">
                </div>

            </div>


            <div class="btn-group" id="divViewMode" role="group" style="margin-top: 5px;float:right " aria-label="">

                <asp:LinkButton runat="server" ID="btnLineView" OnClick="btnLineView_Click" CssClass="btn btn-default">
                                  <span class="glyphicon glyphicon-align-justify" aria-hidden="true"></span>
                </asp:LinkButton>
                <asp:LinkButton ID="btnGraidView" runat="server" Visible="false" OnClick="btnGraidView_Click" CssClass="btn btn-default">
  <span class="glyphicon glyphicon-th" aria-hidden="true"></span>
           
                </asp:LinkButton>

                <asp:LinkButton ID="btnCategotisView" runat="server" OnClick="btnCategotisView_Click" CssClass="btn btn-default">
                                     <span class="glyphicon glyphicon-th-large" aria-hidden="true"></span>
                </asp:LinkButton>
            </div>

        </div>
        <hr>
        <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnLineView" />
                <asp:AsyncPostBackTrigger ControlID="btnGraidView" />
                <asp:AsyncPostBackTrigger ControlID="btnCategotisView" />
                <asp:AsyncPostBackTrigger ControlID="btnSortNewest" />
                <asp:AsyncPostBackTrigger ControlID="btnSortOldest" />
                <asp:AsyncPostBackTrigger ControlID="btnSortCategory" />
                <asp:AsyncPostBackTrigger ControlID="btnSortType" />
                <asp:AsyncPostBackTrigger ControlID="btnAds" />
                <asp:AsyncPostBackTrigger ControlID="btnEvent" />
                <asp:AsyncPostBackTrigger ControlID="btnAll" />
            </Triggers>
            <ContentTemplate>

                <asp:Panel runat="server" ID="PanelAds" class="container">
                    <div class="row" style="padding-right: 3%; padding-left: 3%">
                        <asp:Repeater runat="server" ID="repAds" OnItemDataBound="repAds_ItemDataBound">
                            <ItemTemplate>
                                <my:ads runat="server" OnclickInfo="adsCustomContro_clickInfo" ID="adsCustomContro"  MarkerIdPro='<%#Eval("MARKER_ID")%>' AdsIdpro='<%#Eval("ADVERTISMENT_ID")%>' LblMarkerNamePro='<%#Eval("MARKER_NAME")%>' Type='<%#Eval("ADS_TYPE") %>' Gener='<%#Eval("GENERS") %>' LbladsContentPro='<%#Eval("ADS_CONTENT")%>' />

                            </ItemTemplate>
                        </asp:Repeater>

                    </div>
                </asp:Panel>

                <asp:Panel ID="divSearchResualt" runat="server">
                    <div runat="server" id="divSearchRuseltStatus" class="alert alert-info" role="alert">
                        <asp:Label runat="server" ID="searchResultlbl">search resualt</asp:Label>
                        <br />
                        <asp:LinkButton runat="server" ID="btnBackToAds" OnClick="btnBackToAds_Click">back to advertisment</asp:LinkButton>
                    </div>




                    <asp:Repeater runat="server" ID="repSearchRuslt" OnItemDataBound="repSearchRuslt_ItemDataBound">
                        <ItemTemplate>
                            <my:ads runat="server" OnclickInfo="adsCustomContro_clickInfo" ID="adsCustomContro" MarkerIdPro='<%#Eval("MARKER_ID")%>' AdsIdpro='<%#Eval("ADVERTISMENT_ID")%>' LblMarkerNamePro='<%#Eval("MARKER_NAME")%>' Type='<%#Eval("ADS_TYPE") %>' Gener='<%#Eval("GENERS") %>' LbladsContentPro='<%#Eval("ADS_CONTENT")%>' />
                        </ItemTemplate>

                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:Repeater>

                </asp:Panel>
            </ContentTemplate>

        </asp:UpdatePanel>


        <asp:UpdatePanel ID="updatePanel2" runat="server">
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnCategotisView" />
            </Triggers>
            <ContentTemplate>
                <!--category rep-->
                <asp:Panel runat="server" ID="panelCat" class="container">
                    <div class="row">

                        <asp:Repeater runat="server" ID="repCat" OnItemDataBound="repCat_ItemDataBound">
                            <ItemTemplate>
                                <asp:Panel runat="server" ID="panelCategory" class="col-md-4">
                                    <div class="panel panel-primary" style="border-style: none">
                                        <div class="panel-heading" style="border-radius: 7px">
                                            <asp:Label runat="server" ID="lblCatName" Text='<%#Eval("DESCRIPTION")%>'></asp:Label>

                                        </div>
                                        <div class="panel-body">
                                            <asp:Repeater runat="server" OnItemDataBound="repAdstitle_ItemDataBound" ID="repAdstitle">
                                                <ItemTemplate>
                                                    <asp:LinkButton runat="server" OnClick="linkAdsContent_Click" CommandArgument='<%#Eval("ADVERTISMENT_ID") %>' ID="linkAdsContent" class="list-group-item" Style="border-style: none" Text='<%#Eval("ADS_CONTENT") %>'></asp:LinkButton>
                                                    <asp:LinkButton runat="server" ID="linkMarkerName" Style="border-style: none; display: none" Text='<%#Eval("MARKER_NAME") %>'></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                            <div class="list-group" style="border-style: none; width: 100%">
                                            </div>
                                        </div>
                                    </div>
                                </asp:Panel>

                            </ItemTemplate>
                        </asp:Repeater>

                    </div>

                </asp:Panel>

            </ContentTemplate>
        </asp:UpdatePanel>


        <!--/categorys rep-->
        <!--slider-->

        <div class="modal fade" id="popupMap">
            <div class="modal-dialog">

                <div class="modal-body">
                    <div id="adsMapConatiner" style="width: 100%; height: 80%"></div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="myModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">marker album</h4>
                    </div>
                    <div class="modal-body">
                        <div id="myCarousel" class="carousel slide" data-interval="3000" data-ride="carousel">

                            <ol class="carousel-indicators">
                                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                                <li data-target="#myCarousel" data-slide-to="1"></li>
                                <li data-target="#myCarousel" data-slide-to="2"></li>
                            </ol>
                            <!-- Carousel items -->
                            <div class="carousel-inner">
                                <div class="item active">

                                    <asp:Image runat="server" ID="adsImg1" Width="100%" Height="60%" />
                                    <div class="carousel-caption">
                                        <h3>First slide label</h3>
                                        <p>Lorem ipsum dolor sit amet consectetur…</p>
                                    </div>
                                </div>
                                <div class="item">

                                    <asp:Image runat="server" ID="adsImg2" Width="100%" Height="60%" />
                                    <div class="carousel-caption">
                                        <h3>Second slide label</h3>
                                        <p>Aliquam sit amet gravida nibh, facilisis gravida…</p>
                                    </div>
                                </div>
                                <div class="item">
                                    <asp:Image runat="server" ID="adsImg3" Width="100%" Height="60%" />
                                    <div class="carousel-caption">
                                        <h3>Third slide label</h3>
                                        <p>Praesent commodo cursus magna vel…</p>
                                    </div>
                                </div>
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

                    <div class="modal-footer">
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->


        <!--end slider-->
    </form>

    <script>
        
        var allMarkerData = <%=JSONHelper.AllMarkers()%> 
           
        $(function () {
            
            var allGenersData = <%=JSONHelper.GetAllGeners()%>,  
              
          Array = [];
            ////searchResultMarker,
            ////finalResult;

            for (var item in allGenersData) {
                var toAdd = {
                    label: allGenersData[item].DESCRIPTION,
                    value: allGenersData[item].DESCRIPTION

                }

                
                Array.push(toAdd);
            }

            for (var item in allMarkerData) {
                var toAdd = {
                    label: allMarkerData[item].MARKER_NAME+" (marker)",
                    value: allMarkerData[item].MARKER_NAME
                }
                Array.push(toAdd);

            }

            $('#searchBox').autocomplete({
                autoFocus: false,
                source: Array,
                focus: function (event, ui) {
                    $('#searchBox').val(ui.item.label);
                    return false;
                },
                select: function (event, ui) {
                    event.preventDefault();
                    $('#searchBox').val(ui.item.label);
                    
                    document.getElementById('hiddenSearchParm').value=ui.item.value;
                 
                    document.getElementById('<%=hiddenSearchBtn.ClientID%>').click();
                    
                    
                }

                //  $('#lblSearchMainId').text(ui.item.value);
                //PageMethods.MarkerInfoViaID(ui.item.value,function(response){

                //    //Had Selected One
                //    finalResult = $.parseJSON(response);
                //    console.log(finalResult);

                //},function(error){
                //    console.log(error);
                //});
                //return false;

            }).data('ui-autocomplete')._renderItem = function(ul,item){
                return $('<li>').append("<a  style='width:100%' >"+item.label+"<small><font color='gray'></font></small></a>").appendTo(ul);

            }
        })
        
    </script>

    <script>
        $.fn.scrollTo = function( target, options, callback ){
            if(typeof options == 'function' && arguments.length == 2){ callback = options; options = target; }
            var settings = $.extend({
                scrollTarget  : target,
                offsetTop     : 50,
                duration      : 500,
                easing        : 'swing'
            }, options);
            return this.each(function(){
                var scrollPane = $(this);
                var scrollTarget = (typeof settings.scrollTarget == "number") ? settings.scrollTarget : $(settings.scrollTarget);
                var scrollY = (typeof scrollTarget == "number") ? scrollTarget : scrollTarget.offset().top + scrollPane.scrollTop() - parseInt(settings.offsetTop);
                scrollPane.animate({scrollTop : scrollY }, parseInt(settings.duration), settings.easing, function(){
                    if (typeof callback == 'function') { callback.call(this); }
                });
            });
        }
    </script>
    <script>
        function scrollToDiv(id){
            $('body').scrollTo("#"+id+"");
            document.getElementById(id).style.backgroundColor="#D8D8D8";
            setTimeout(function(){ document.getElementById(id).style.backgroundColor = "white";
            },3000)
        }

    </script>

    <script>
        var openOptionDiv = false;
        $(document).ready(function () {
            $("#myCarousel").carousel();
           
        });
      
    </script>

    <script>
        function showAdsOnMap(lat,lng) {
            var map;
            $('#popupMap').on('shown.bs.modal', function () 
            { 
            
                google.maps.event.trigger(map, 'resize');  
                map.setCenter(new google.maps.LatLng(lat, lng));
            });
           
            $('#popupMap').modal('show');

            
            initialize();
        
            function initialize() {
          
                var mapOptions = {
                    center: new google.maps.LatLng(lat,lng),
                    zoom: 16,
                    draggable: false,

                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                map = new google.maps.Map(document.getElementById("adsMapConatiner"),
                 mapOptions);
                var marker = new google.maps.Marker({
                    position: new google.maps.LatLng(lat, lng)
                });
                marker.setMap(map);
              
              
            }
           
        }
     
   
    </script>

</body>
</html>



