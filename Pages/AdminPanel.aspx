 <%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ADMIN_MASTER.master" AutoEventWireup="true" CodeFile="~/Pages/AdminPanel.aspx.cs" Inherits="Pages_AdminPanel"  EnableEventValidation="false"%>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
 
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/CustomControl/blocked.ascx" TagPrefix="asp" TagName="Block" %>
<%@ Register Src="~/CustomControl/AdminMang.ascx" TagPrefix="asp" TagName="_AdminManger" %>
<script runat="server">

   
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <!---->
    <script type="text/javascript">
        google.load('visualization', '1', { packages: ['corechart'] });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json;charset:utf-8',
                url: 'AdminPanel.aspx/GETCHARTDATA',
                data: '{}',
                async: false,
                success:
                    function (response) {
                        drawVisualization(response.d);
                    },
                error: function () {
                    alert('CANT LOAD DETAILS CHART');
                }
            });
        })

        function drawVisualization(dataValues) {
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Column Name');
            data.addColumn('number', 'MARKER ADDED'); 
            for (var i = 0; i < dataValues.length; i++) {
                data.addRow([dataValues[i].ColumnName, dataValues[i].Value]);
            }
            new google.visualization.LineChart(document.getElementById('MAINCHARTMARK')).
                draw(data, { title: "NEWEST MARKS",height:350 });
        }
    </script>
    
    <!-- End Chart-->
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json;charset:utf-8',
                url: 'AdminPanel.aspx/GetChartDataForMonth',
                data: '{}',
                async: false,
                success:
                    function (response) {
                        drawVisualization(response.d);
                    },
                error: function () {
                    alert('CANT LOAD DETAILS CHART');
                }
            });
        })

        function drawVisualization(dataValues) {
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Column Name');
            data.addColumn('number', 'MARKER ADDED'); 
            for (var i = 0; i < dataValues.length; i++) {
                data.addRow([dataValues[i].ColumnName, dataValues[i].Value]);
            }
            new google.visualization.AreaChart(document.getElementById('MonthChart')).
                draw(data, { title: "NEWEST MARKS PER MONTH",height:350 });
        }
    </script>
    <script type="text/javascript">
        function Proved(ID)
        {
            try
            {
                $.ajax({
                    type:'Post',
                    url:'AdminPanel.aspx/SetApprove',
                    contentType:'application/json;charset:utf-8',
                    dataType:'json',
                    data:'{ID:'+ID+'}',
                    async:false,
                    success:function()
                    {
                        alert('add Success');
                    },
                    error:function()
                    {
                        alert('some thing wrong');
                    
                    }
                    
                });
            }
            catch(err)
            {
                console.log(err.message);
            }
            finally
            {
                console.log(ID);
                console.log(SetApprove);
            }
        }
        
        function Waiting(ID)
        {
            try
            {
                $.ajax({
                    type:'Post',
                    url:'AdminPanel.aspx/SetWait',
                    contentType:'application/json;charset:utf-8',
                    dataType:'json',
                    data:'{ID:'+ID+'}',
                    async:false,
                    success:function()
                    {
                        alert('add For Waiting Success');
                    },
                    error:function()
                    {
                        alert('som thing wrong');
                    
                    }
                    
                });
            }
            catch(err)
            {
                console.log(err.message);
            }
            finally
            {
                console.log(ID);
                console.log(SetApprove);
            }
                        
        }
        
        function Denied(ID)
        {
            $.ajax({
                type:"POST",
                url:"AdminPanel.aspx/Denied",
                data:"{ID:"+ID+"}",
                contentType:"application/json;charset=utf-8",
                dataType:"json",
                sync:false,
                success:function(){alert ("Done");},
                error:function (){alert('not delete');}
            });
        }
        function ADS_Approve(ID)
        {
            try{
                $.ajax({
                    type:"POST",
                    url:'AdminPanel.aspx/SetApproveAds',
                    dataType:"json",
                    data:"{ID:"+ID+"}",
                    contentType:'application/json; charset=utf-8',
                    async:false,
                    success:function (){alert('DONE');},
                    error:function (){alert('Some Thing Wrong');}
                });
            }
            catch(err)
            {
                console.log(err.message)
            }
            finally
            {
                console.log(ID);
                console.log(SetApproveAds);
            }
        }
        function ADS_Delete(ID)
        {
            try{
                $.ajax({
                    type:"POST",
                    url:'AdminPanel.aspx/DeleteAds',
                    dataType:"json",
                    data:"{ID:"+ID+"}",
                    contentType:'application/json; charset=utf-8',
                    async:false,
                    success:function (){alert('Delete Success');},
                    error:function (){alert('Some Thing Wrong');}
                });
            }
            catch(err)
            {
                console.log(err.message)
            }
            finally
            {
                console.log(ID);
                console.log(SetApproveAds);
            }
        }
        </script>
    <style type="text/css">
        #MapContent {
            position: absolute;
            top: 53px;
            right: 0px;
            height: 100%;
            width: 100%;
            z-index: -1;
        }

        #MapContentAPP {
            position: absolute;
            top: 53px;
            right: 0px;
            height: 100%;
            width: 100%;
            z-index: -1;
        }

        #MapContentWait {
            position: absolute;
            top: 53px;
            right: 0px;
            height: 100%;
            width: 100%;
            z-index: -1;
        }

        #ALLADS_CONTENT {
            position: absolute;
            top: 53px;
            right: 0px;
            height: 100%;
            width: 100%;
            z-index: -1;
        }

        #ALLEVENT_CONTENT {
            position: absolute;
            top: 53px;
            right: 0px;
            height: 100%;
            width: 100%;
            z-index: -1;
        }

        .modalPopup /*Modal Edit Category*/ {
            background-color: #FFFFFF;
            border-width: 3px;
            border-style: solid;
            border-color: Gray;
            padding-top: 10px;
            padding-left: 10px;
            width: 380px;
            height: 250px;
        }

        .modalBackground /*Modal Edit Category*/ {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }

        .Modal_CancelDeleteCateBg {
            background-color: red;
            filter: alpha(opacity=60);
            opacity: 0.6;
        }

        .Modal_CancelDeleteCatePopUp {
            background-color: #ffffff;
            border-width: 1px;
            border-style: hidden;
            border-top: 10px;
            border-left: 10px;
            width: 350px;
            height: 160px;
        }

        .ModalInfoCateBg {
            background-color: navy;
            filter: alpha(opacity=75);
            opacity: 0.7;
        }

        .ModalInfoCatePopup {
            background-color: #ffffff;
            border-width: 3px;
            border-style: solid;
            border-color: aqua;
            border-top: 10px;
            border-left: 10px;
            width: 420px;
            height: 320px;
        }

        .ModalNewCateBg {
            background-color: olive;
            filter: alpha(opacity=40);
            opacity: 0.5;
        }

        .ModalNewCatePopup {
            background-color: #ffffff;
            border-width: 2px;
            border-color: none;
            border-top: -25px;
            border-left: -25px;
            width: 450px;
            height: 500px;
        }

        .ModalGenerEditBg {
            background-color: lightgray;
            filter: alpha(opacity=50);
            opacity: 0.7;
        }

        .ModalGenerEditPopup {
            background-color: #ffffff;
            border-width: 3px;
            border-color: Gray;
            width: 340px;
            height: 180px;
        }

        .ModalConfirmAddAdminBg {
            background-color: white;
            filter: alpha(opacity=85);
            opacity: 0.8;
        }

        .ModalConfirmAddAdminpopUp {
            background-color: gray;
            border-width: 3px;
            border-color: red;
            width: auto;
            height: auto;
        }

        .blue {
            color: blue;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptAdmin" runat="server"></asp:ScriptManager>
    <asp:MultiView runat="server" ID="MV_ADMIN" ActiveViewIndex="0">
        <%--0 Main --%>
        <asp:View runat="server" ID="V_MAIN" >
            <label  style="font-family:arial;font-size:20px;width:50%;color:lightgray">THE NEWEST IN SITE</label>
            <hr />
             <div class="form-control container" style="width:100%;height:15%;">
        <table style="width:100%;height:100%;">
          <tr>
              <td style="height:100%;width:20%;padding-right:10px;padding-left:10px">
                  <table style="width:100%;height:100%;background-color:#19D1FF">
                      <tr>
                          <td  rowspan="4" style="width:20%;height:100%;padding:5px;background-color:#00CCFF"><img src="../Icons/1432854502_04_maps.png" /></td>
                      </tr>
                      <tr>
                          <td  style="width:80%;"><label style="text-align:center;font-family:Arial,Verdana;font-size:20px;width:100%;color:white">NEW MARKERS</label></td>
                      </tr>
                      <tr>
                          <td style="width:80%;"><p style="width:100%;text-align:center;font-family:Arial,Verdana;font-size:16px"><asp:label runat="server" ID="NEWMARKNum" style="text-align:center;width:100%;color:#FFFF99;font-family:Arial,Verdana;font-size:20px;font-weight:bold"></asp:label></p></td>
                      </tr>
                      <tr>
                          <td style="width:80%;"><label style="text-align:center;font-family:Arial;font-size:16px;width:100%;text-decoration:none;"><asp:LinkButton runat="server" ID="LB_NEWMARK" OnClick="LB_NEWMARK_Click" >VIEW DETAILS &nbsp;&nbsp;<span class="glyphIcons glyphIcons-circle-arrow-right"></span></asp:LinkButton></label></td>
                      </tr>
                  </table>

              </td>
              <td style="height:100%;width:20%;padding-right:10px;padding-left:10px;">
                 <table style="width:100%;height:100%;background-color:#85ADAD">
                      <tr>
                          <td  rowspan="4" style="width:20%;height:100%;padding:5px;background-color:#669999"><img src="../Icons/Ads1.png" /></td>
                      </tr>
                      <tr>
                          <td  style="width:80%;"><label style="text-align:center;font-family:Arial,Verdana;font-size:20px;width:100%;color:white">NEW ADVERTISES</label></td>
                      </tr>
                      <tr>
                          <td style="width:80%;"><p style="width:100%;text-align:center;font-family:Arial,Verdana;font-size:16px"><asp:label runat="server" ID="NEWADSNum" style="text-align:center;width:100%;color:#FFFF99;font-family:Arial,Verdana;font-size:20px;font-weight:bold"></asp:label></p></td>
                      </tr>
                      <tr>
                          <td style="width:80%;"><label style="text-align:center;font-family:Arial;font-size:16px;width:100%;text-decoration:none;"><asp:LinkButton runat="server" ID="LinkButton1" OnClick="LinkButton1_Click" >VIEW DETAILS &nbsp;&nbsp;<span class="glyphIcons glyphIcons-circle-arrow-right"></span></asp:LinkButton></label></td>
                      </tr>
                  </table>
              </td>
              <td style="height:100%;width:20%;padding-right:10px;padding-left:10px;">
                  <table style="width:100%;height:100%;background-color:#999966">
                      <tr>
                          <td  rowspan="4" style="width:20%;height:100%;padding:5px;background-color:#7A7A52"><img src="../Icons/1432855232_private_mail.png" /></td>
                      </tr>
                      <tr>
                          <td  style="width:80%;"><label style="text-align:center;font-family:Arial,Verdana;font-size:20px;width:100%;color:white">NEW USERS</label></td>
                      </tr>
                      <tr>
                          <td style="width:80%;"><p style="width:100%;text-align:center;font-family:Arial,Verdana;font-size:16px"><asp:label runat="server" ID="NEWUSERSNUM" style="text-align:center;width:100%;color:#FFFF99;font-family:Arial,Verdana;font-size:20px;font-weight:bold"></asp:label></p></td>
                      </tr>
                      <tr>
                          <td style="width:80%;"><label style="text-align:center;font-family:Arial;font-size:16px;width:100%;text-decoration:none;"><asp:LinkButton runat="server" ID="LB_NEWUSERS" OnClick="LB_NEWUSERS_Click" >VIEW DETAILS &nbsp;&nbsp;<span class="glyphIcons glyphIcons-circle-arrow-right"></span></asp:LinkButton></label></td>
                      </tr>
                  </table>
              </td>
              <td style="height:100%;width:20%;padding-left:10px;padding-right:10px">
                  <table style="width:100%;height:100%;background-color:#CCCCFF">
                      <tr>
                          <td  rowspan="4" style="width:20%;height:100%;padding:5px;background-color:#A3A3CC"><img src="../Icons/Ads1.png" /></td>
                      </tr>
                      <tr>
                          <td  style="width:80%;"><label style="text-align:center;font-family:Arial,Verdana;font-size:20px;width:100%;color:white">UNKWOUN</label></td>
                      </tr>
                      <tr>
                          <td style="width:80%;"><label style="text-align:center;font-family:Arial;font-size:16px;width:100%;color:#FFFF99">2500</label></td>
                      </tr>
                      <tr>
                          <td style="width:80%;"><label style="text-align:center;font-family:Arial;font-size:16px;width:100%;text-decoration:none;"><asp:LinkButton runat="server" ID="LinkButton3" >VIEW DETAILS &nbsp;&nbsp;<span class="glyphIcons glyphIcons-circle-arrow-right"></span></asp:LinkButton></label></td>
                      </tr>
                  </table>
              </td>
          </tr>

        </table>

            </div>
         <div style="width:100%;height:auto;">
            <div class="container" style="width:70%;height:40%;text-align:center;float:left" id="MonthChart">
                <!--Chart-->
            </div>
            
            <div class="container" style="width:30%;float:right;height:auto">
               <asp:Repeater runat="server" ID="REP_BESTMARKERS">
                   <HeaderTemplate>
                       <label class="form-control container label-default" style="color:lightyellow;font-size:20px;text-align:center">TOP 6 MARKERS </label>
                  <table style="border:ridge 1px gray;">
                   <tr class="success">
                    <td class="active" width="200" height="50" style="border:ridge 1px lightgray;text-align:center;background-color:#1975D1;color:white;font-family:Arial Black">MARKER NAME</td>
                    <td width="100" height="50" style="border:ridge 1px lightgray;text-align:center;background-color:#1975D1;color:white;font-family:Arial Black"> Visits</td>
                    <td width="75" height="50" style="border:ridge 1px lightgray;text-align:center;background-color:#1975D1;"><span style="color:yellow" class="glyphIcons glyphIcons-star"></span></td>
                   </tr>
                  </table>
                   </HeaderTemplate>
                 <ItemTemplate>
                  <table style="border:ridge 1px gray;">
                   <tr class="success">
                    <td class="active" width="200" height="50" style="border:ridge 1px lightgray;text-align:center;"><asp:Label runat="server" ID="Label1" Text='<%#Eval("MARKERNAME") %>' style="font-family:'Impact';font-size:16px;color:#4775D1"></asp:Label></td>
                    <td width="100" height="50" style="border:ridge 1px lightgray;text-align:center"> <asp:Label runat="server" ID="sas" Text='<%#Eval("VISITS_COUNTER") %>' style="font-family:'Impact';font-size:16px"></asp:Label></td>
                    <td width="75" height="50" style="border:ridge 1px lightgray;text-align:center;background-color:#1975D1"><span style="color:yellow" class="glyphIcons glyphIcons-star"></span></td>
                   </tr>  
                  </ItemTemplate>
                </asp:Repeater> 
            </div>
           
<%--             <div class="container form-control" style="float:right;height:auto;width:auto;">
                 <table class=" container" style="height:auto;width:auto">
                     <tr>
                         <td width ="200" height="100" style="background-color:#3333FF;text-align:center">
                            <img src="../Icons/1433038219_Facebook.png" /><br />
                             <label style="color:white;font-family:Arial,Verdana;font-size:25px;">3,500</label>
                         </td>
                         <td width ="200" height="100" style="background-color:#0099CC;text-align:center">
                            <img src="../Icons/1433039193_Twitter.png" /><br />
                             <label style="color:white;font-family:Arial,Verdana;font-size:25px;">3,500</label>
                        </td>
                     </tr>
                 </table>
             </div>--%>
         </div>
        </asp:View>
        <!--1 show all mark -->
        <asp:View runat="server" ID="V_MARK">
            <div id="MapContent"></div>
            <script type="text/javascript">
                (function (window, Codepros) {
                    document.getElementById('ShowMenu').style.display="block";
                    var markers = <%= JSONHelper.AllMarkers() %>;
                    var myMap = Codepros.CreateNew(document.getElementById('MapContent'), {
                        center : new google.maps.LatLng(33.5108033,36.3004907),
                        zoom:12
                    });
                       
                    for(var marker in markers){
                        var toAdd = markers[marker];
                        myMap.CreateMarker({
                            lat:toAdd.lat,
                            lng:toAdd.lng,
                            content:"<div class='form-group'><label class='alert alert-info'>This User's Request To Add Marker Of The Site</label>"+
                                                  "<label class='form-control'>marker name: <b style='color:blue'>"+toAdd.content+"</b></label>"+
                                                  "<label class='btn-xs'>ID:"+toAdd.id+"</label><br/>"+
                                                  "<label class='btn-xs'>Latitiud:"+toAdd.lat+"</label><br/>"+
                                                  "<label class='btn-xs'>Lngtitud:"+toAdd.lng+"</label>"  ,
                            Icons:{
                                url:'../Icons/Green_Flag .ico',
                                width:2,
                                height:2
                            }
                    
                        });
                          
                    }
                })(window, window.Codepros);
            </script>
        </asp:View>
        <!--2 sHOW APPROVE MARK-->
        <asp:View runat="server" ID="V_MarkApp">
            
            <div id="MapContentAPP"></div>
            <script type="text/javascript">
                (function (window, Codepros) {
                    document.getElementById('ShowMenu').style.display="block";
                    var markers = <%= JSONHelper.GetAllMarkerForApprov() %>;
                    var myMap = Codepros.CreateNew(document.getElementById('MapContentAPP'), {
                        center : new google.maps.LatLng(33.5108033,36.3004907),
                        zoom:12
                    });
                       
                    for(var marker in markers){
                        var toAdd = markers[marker];
                        myMap.CreateMarker({
                            lat:toAdd.lat,
                            lng:toAdd.lng,
                            content:"<div class='form-group'><label class='alert alert-info'>This User's Request To Add Marker Of The Site</label>"+
                                                          "<label class='form-control'>marker name: <b style='color:blue'>"+toAdd.content+"</b></label>"+
                                                          "<label class='btn-xs'>ID:"+toAdd.id+"</label><br/>"+
                                                          "<label class='btn-xs'>Latitiud:"+toAdd.lat+"</label><br/>"+
                                                          "<label class='btn-xs'>Lngtitud:"+toAdd.lng+"</label>"+
                                                          "<br/><button id='Approv'  class='btn btn-xs btn-success btn-block btn-large' onclick='Proved("+toAdd.id+")'>Approve</button>"+
                                                          "<button id='no' class='btn btn-xs btn-danger btn-block btn-large' disabled>Not Approve</button>"+
                                                          "<button id='Later' class='btn btn-xs btn-primary btn-block btn-large' onclick='Waiting("+toAdd.id+")'>Approve Later</button></div>",
                            Icons:{
                                url:'../Icons/Red_Flag.ico',
                                width:1,
                                height:1
                            }                               
                    
                        });
                          
                    }
                })(window, window.Codepros);
            </script>
        </asp:View>
        <!--3 show wait mark-->
        <asp:View runat="server" ID="V_MarkWait">
            <div id="MapContentWait"></div>
            <script type="text/javascript">
                (function (window, Codepros) {
                    document.getElementById('ShowMenu').style.display="block";
                    var markers=<%=JSONHelper.GetAllMarkerWaitingApprov()%>;
                    var myMap=Codepros.CreateNew(document.getElementById('MapContentWait'),{
                        zoom:9,
                        center:new google.maps.LatLng(33.5108033,36.3004907)
                    });
                    for (var marker in markers)
                    {
                        var toAdd=markers[marker];
                        myMap.CreateMarker({
                            lat:toAdd.lat,
                            lng:toAdd.lng,
                            content:'<div class="form-group"><label class="alert alert-info">THIS USER REQUEST TO ADD MARK </label>'+
                                    '<label class="form-control">marker name: <b style="color:blue">'+toAdd.content+'</b></label>'+
                                    '<label class="btn-xs">Latitiud:'+toAdd.lat+'</label><br/>'+
                                    '<label class="btn-xs">Lngtitud:'+toAdd.lng+'</label>'+
                                    "<br/><button id='Approv'  class='btn btn-xs btn-success btn-block btn-large' onclick='Proved("+toAdd.id+")'>Approve</button>"+
                                    "<button id='no' class='btn btn-xs btn-danger btn-block btn-large' disabled>Not Approve</button>"+
                                    '</div>',
                            Icons:{
                                url:"../Icons/Blue_Flag.ico",
                                width:1,
                                height:1
                            }
                        });
                    }
                })(window, window.Codepros);
            </script>
        </asp:View>
        <!--4  event -->
        <asp:View runat="server" ID="SHOWALLADS">
            <div id="ALLEVENT_CONTENT" ></div>
            <script type="text/javascript">
                (function (window, Codepros) { 
                    document.getElementById('ShowMenu1').style.display="block";
                    var markers=<%=JSONHelper.GetAllMarkerEventForApprove()%>;
                    var MyMap = Codepros.CreateNew(document.getElementById('ALLEVENT_CONTENT'), {
                        center: new google.maps.LatLng(33.5108033, 36.3004907),
                        zoom:9
                    });
                    for(var marker in markers){
                        var toAdd = markers[marker];
                        MyMap.CreateMarker({
                            lat:toAdd.MLA,
                            lng:toAdd.MLN,
                            content:"<div class='form-control' style='width:225px;height:300px;'><label class='form-control alert-danger'>"+toAdd.ADST_T+"</label>"+
                                    "<br><label><strong>NAME : <span  style='color:red'>"+toAdd.MN+"</span></strong></label><hr/>"+
                                    "<label  style='color:navy' >Small Description About  "+toAdd.ADST_T+"</label>"+
                                    "<br><div class='form-control' style='width:200px;height:75px;'>"+toAdd.DESCRIPTION+"</div>"+
                                    "<br><button id='ads_approve' class='btn btn-success btn-larg btn-xs' onclick='ADS_Approve("+toAdd.ADVERTISMENT_ID+");'>Approve</button>"+
                                    "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button id='not_approve' class='btn btn-danger btn-larg btn-xs' onclick='ADS_Delete("+toAdd.ADVERTISMENT_ID+")'>Reject</button></div>"
                        });
                    }
                })(window, window.Codepros);
            </script>
        </asp:View>
        <!--5 ADS Approve -->
        <asp:View runat="server" ID="ShowAdsApp">
            <div id="ALLADS_CONTENT"></div>
            <script type="text/javascript">
                (function (window, Codepros) { 
                    document.getElementById('ShowMenu1').style.display="block";
                    var MARKERS =<%=JSONHelper.GetAllMarkerAdsForApprove()%>;
                    var MyMap = Codepros.CreateNew(document.getElementById('ALLADS_CONTENT'), {
                        center: new google.maps.LatLng(33.5108033, 36.3004907),
                        zoom:9
                    });
                    for(var marker in MARKERS)
                    {
                        var TOADD = MARKERS[marker];
                        MyMap.CreateMarker({
                            lat:TOADD.MLA,
                            lng:TOADD.MLN,
                            content:"<div class='form-control' style='width:225px;height:300px;'><label class='form-control alert-danger'>"+TOADD.ADST_T+"</label>"+
                                    "<br><label><strong>NAME : <span  style='color:red'>"+TOADD.MN+"</span></strong></label><hr/>"+
                                    "<label  style='color:navy' >Small Description About  "+TOADD.ADST_T+"</label>"+
                                    "<br><div class='form-control' style='width:200px;height:75px;'>"+TOADD.DESCRIPTION+"</div>"+
                                    "<br><button id='ads_approve' class='btn btn-success btn-larg btn-xs' onclick='ADS_Approve("+TOADD.ADVERTISMENT_ID+");'>Approve</button>"+
                                    "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button id='not_approve' class='btn btn-danger btn-larg btn-xs' onclick='ADS_Delete("+TOADD.ADVERTISMENT_ID+")'>Reject</button></div>"
                        });

                    }
                })(window, window.Codepros);
                </script>
        </asp:View>
        <!--6 Categories -->
        <asp:View runat="server" ID="ShowEvent">
            <!-- div For Mangement Current C & G -->
            <div class="container form-control" style="width:20%;height:95%;min-width:120px;position:absolute;left:0px;">
                    <label class="alert-info form-control" style="height:auto;width:auto;min-width:80px;">Category List</label>
                <asp:ListBox runat="server" ID="lb_Current_Cate" SelectionMode="Single" AutoPostBack="true" style="width:100%;height:35%;" CssClass="form-control" OnSelectedIndexChanged="lb_Current_Cate_SelectedIndexChanged"></asp:ListBox><br />
                <div class="form-group">
                    <asp:LinkButton runat="server" ID="btn_EditCate" CssClass="btn btn-warning " ToolTip="Edit Category" style="width:32%" OnClick="btn_EditCate_Click"><span class="glyphIcons glyphIcons-pencil"></span></asp:LinkButton>
                    <asp:LinkButton runat="server" ID="btn_DeleteCate" CssClass="btn btn-danger" ToolTip="Delete Category" style="width:32%;" OnClick="btn_DeleteCate_Click"><span class="glyphIcons glyphIcons-trash"></span></asp:LinkButton>
                    <asp:LinkButton runat="server" ID="btn_ShowGenerCate" CssClass="btn  btn-default" ToolTip="Show Gener For This Category" style="width:32%;" OnClick="btn_ShowGenerCate_Click"><span class="glyphIcons glyphIcons-eye-open"></span></asp:LinkButton>
                </div>
                <label class="form-control alert-info" style="height:auto;width:auto;min-width:80px;">Gener For Determind Category</label>
                
                <asp:ListBox runat="server" ID="lb_CurrentGener" SelectionMode="Single" AutoPostBack="true" style="width:100%;height:30%;" CssClass="form-control" OnSelectedIndexChanged="lb_CurrentGener_SelectedIndexChanged"></asp:ListBox>
                   <br />
                <div class="form-group">
                    <asp:LinkButton ID="btn_AddGener" runat="server" CssClass="btn btn-success" ToolTip="Add Gener For This Category" style="width:32%;"><span class="glyphIcons glyphIcons-plus"></span></asp:LinkButton>
                    <asp:LinkButton ID="btn_EditGener" runat="server" CssClass="btn btn-warning" ToolTip="Edit This Gener" style="width:32%"><span class="glyphIcons glyphIcons-pencil"></span></asp:LinkButton>
                    <asp:LinkButton ID="btn_DeleteGener" runat="server" CssClass="btn btn-danger" ToolTip="Edit This Gener" style="width:32%;"><span class="glyphIcons glyphIcons-trash"></span></asp:LinkButton>
                </div>
            </div>
            <!-- Div for add New Cate -->
            <div>

            </div>
            <div style="">
                <!-- modal edit current cate-->
                <asp:Panel runat="server" ID="Panel_CateEdit" CssClass="modalPopup form-control">
                    <div style="width:350px;height:250px;">
                    <label class="form-control alert-info">Category Edit</label>
                    <hr />
                        <label style="font-family:Verdana;">Insert the New Name For This Category</label>
                        <asp:TextBox runat="server" ID="CateNewName" CssClass="form-control"></asp:TextBox>
                        <hr />
                        <asp:Button runat="server" ID="btn_CompleteEdit" CssClass="btn btn-success btn-sm" Text="Save" OnClick="btn_CompleteEdit_Click" />&nbsp;&nbsp&nbsp;&nbsp;
                         <button id="Cancel_EditCate" type="button" class="btn btn-danger btn-sm">Cancel</button>
                    </div>
                </asp:Panel>
                <asp:ModalPopupExtender ID="ModalCateEdit" runat="server" BackgroundCssClass="modalBackground" TargetControlID="btn_EditCate" PopupControlID="Panel_CateEdit" CancelControlID="Cancel_EditCate" OnOkScript="yes();"></asp:ModalPopupExtender>
                <!--end Modal-->
                <!--modal delete Cate-->
                <asp:Panel runat="server" ID="Panel_CateDelete" CssClass="Modal_CancelDeleteCatePopUp">
                        <div style="width:350px;height:180px;">
                            <label class="form-control alert-danger">Delete This Category</label>
                            <p style="font-family:Arial;padding-left:20px;">Are You Sure Want Delete This Category And All Genere Content .</p>
                            <img src="../Icons/1428767663_10-48.png" style="position:absolute;top:65px;right:25px;" />
                            <hr />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button runat="server" ID="DeleteCateComplete" Text="Ok" CssClass="btn btn-danger btn-sm" OnClick="DeleteCateComplete_Click"/>
                           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button id="CancelDeleteCate" type="button" class="btn btn-default btn-sm">Cancel</button>
                        </div>
                    </asp:Panel>
                    <asp:ModalPopupExtender ID="MoalCateDelete" runat="server" BackgroundCssClass="Modal_CancelDeleteCateBg" TargetControlID="btn_DeleteCate" PopupControlID="Panel_CateDelete"  CancelControlID="CancelDeleteCate" OnOkScript="yes();" ></asp:ModalPopupExtender>
               <%--End Modal Delete Category --%>
                <!-- modal Add Gener-->
                <asp:Panel runat="server" ID="Panel_NewGenerCate" CssClass="ModalNewCatePopup">
                        <div style="width:450px;height:500px;padding:0px 10px 0px 10px;">
                            <label class="form-control alert-success" ">Add New Genre For Category</label>
                            <label class="form-control" >Category name:<%=lb_Current_Cate.SelectedItem%></label><p class="form-control">Gener Name: <strong>Please Insert Name For New Category</strong></p>
                            <asp:TextBox runat="server" ID="NewGener_Name" CssClass="form-control"></asp:TextBox><br />
                            <asp:button runat="server" ID="GnerToListAddModal" Text="Add Gener To List" CssClass="btn btn-xs btn-primary" OnClick="GnerToListAddModal_Click"  /><br /><br />
                            <p class="form-control">This Gener Has Added</p>
                            <asp:UpdatePanel runat="server" ID="Panel_GenerAddModel">
                                <ContentTemplate>
                            <asp:ListBox CssClass="form-control" runat="server" ID="lbGenerNew" Width="270" Height="150"></asp:ListBox>
                                 </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="GnerToListAddModal" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>
                            <hr />
                            <asp:Button runat="server" ID="btn_AddNewGenerForCate" CssClass="brn btn-sm btn-success" Text="Save" OnClick="btn_AddNewGenerForCate_Click" />
                            <button type="button" id="Cancel_GenerNewCate" class="btn btn-sm btn-danger">Cancel</button>
                        </div>
                    </asp:Panel>
                    <asp:ModalPopupExtender runat="server" ID="ModalAddGener" BackgroundCssClass="ModalNewCateBg" CancelControlID="Cancel_GenerNewCate" TargetControlID="btn_AddGener" PopupControlID="Panel_NewGenerCate" OnOkScript="yes();" ></asp:ModalPopupExtender>
                    <%-- End Modal New Gener--%>     
                <%-- Modal Gener Edit--%>
                    
                    <asp:Panel runat="server" ID="Panel_ModalEditGener" CssClass="ModalGenerEditPopup">
                        <div style="width:350px;height:200px;">
                            <label class="form-control" style="background-color:gray;color:white;width:340px;">Edit This Gener</label>
                            <p style="width:320px;padding-left:10px;padding-right:10px;"><b>Gener Name :</b>
                           
                            <asp:TextBox runat="server" ID="NameGenerModal" CssClass="form-control"></asp:TextBox>
                               </p> 
                            <br /><br />
                           &nbsp;&nbsp;&nbsp;&nbsp; <asp:Button runat="server" ID="btn_saveModalEditGener" CssClass="btn btn-sm btn-success" Text="Save" OnClick="btn_saveModalEditGener_Click"  />
                            &nbsp;&nbsp;&nbsp;&nbsp;<button type="button" id="btn_CancelModalGenerEdit" class="btn btn-danger btn-sm">Cancel</button>
                        </div>
                    </asp:Panel>
                    <asp:ModalPopupExtender runat="server" ID="Modal_GenerEdit" BackgroundCssClass="ModalGenerEditBg" TargetControlID="btn_EditGener" CancelControlID="btn_CancelModalGenerEdit" PopupControlID="Panel_ModalEditGener"></asp:ModalPopupExtender>
                    <%-- End Modal Gener Edit--%>
                    <%-- Modal Delete Gener--%>
                 <asp:Panel runat="server" ID="Panel_DeleteGener" CssClass="Modal_CancelDeleteCatePopUp">
                            <div style="width:350px;height:180px;">
                            <label class="form-control alert-danger">Delete This Gener</label>
                            <p style="font-family:Arial;padding-left:20px;">Are You Sure Want Delete <%=lb_CurrentGener.SelectedItem %> From Category <%=lb_Current_Cate.SelectedItem %>.</p>
                            <img src="../Icons/1428767663_10-48.png" style="position:absolute;top:65px;right:25px;" />
                            <hr />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button runat="server" ID="SaveDeleteGener" Text="Ok" CssClass="btn btn-danger btn-sm" OnClick="SaveDeleteGener_Click" />
                           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button id="CancelDeleteGener" type="button" class="btn btn-default btn-sm">Cancel</button>
                            </div>
                        </asp:Panel>
                    <asp:ModalPopupExtender ID="ModalDeleteGener" runat="server" CancelControlID="CancelDeleteGener" TargetControlID="btn_DeleteGener" PopupControlID="Panel_DeleteGener" OnOkScript="yes();" BackgroundCssClass="Modal_CancelDeleteCateBg"></asp:ModalPopupExtender>
                    <%--End Modal Delete Gener --%>     
            </div>
            <div class="form-control container" style="width:60%;height:95%;min-width:90px;position:absolute;right:10%;">
                <label class="form-control alert-success" style="width:auto;height:auto;">Add New Category</label>
                <div class="form-group" style="width:400px auto;margin-left:180px auto;" >
                    <label class="label label-primary" style="width:auto;height:auto;">New Category Name</label><br /><br />
                    <asp:TextBox runat="server" ID="txt_NwCateName" style="width:auto;" placeholder="Enter new Cate Name" CssClass="container form-control"></asp:TextBox>
                    <hr />
                </div>
                 <div style="width:400px;margin-left:180px;" class="form-group">
                    <label class="label label-info">Gener Name For Category </label><br /><br />
                    <asp:TextBox runat="server" ID="txt_NwGenerName" cssclass="form-control container" placeholder="New Gener Name For New Category" style="width:auto;"></asp:TextBox><br /><br />
                   <p style="margin-left:130px;"> <asp:LinkButton runat="server" ID="AddGenerToList" CssClass="btn btn-sm btn-success" OnClick="AddGenerToList_Click"><span class="glyphIcons glyphIcons-plus"></span> Add Gener To List</asp:LinkButton></p>
                    <p style="margin-left:80px;"><asp:ListBox runat="server" ID="lb_NewGener" Width="250" Height="250" BackColor="Lightgray" ></asp:ListBox></p>
                    <hr />
                </div>
                <div class="btn-group" style="margin-left:280px;">
                    <asp:Button runat="server" ID="btn_SaveForm" Text="Save" CssClass="btn btn-success" OnClick="btn_SaveForm_Click" />
                    <asp:Button runat="server" ID="btn_CancelForm" Text="Cancel" CssClass="btn btn-primary" />
                    <button type="reset" id="btn_ResetForm" class="btn btn-default">Reset</button>
                </div>
            </div>
            
        </asp:View>
        <!-- 7 admin Manger setting-->
        <asp:View runat="server" ID="V_AdminMangerSetting">
            <script type="text/javascript">
                document.getElementById('MainSlide').style.display="block";
            </script>
            <label class="container label-info form-control" style="width:40%;text-align:center;color:white;width:40%auto;height:auto;font-size:30px;">Admin Manger</label>
            <div class="form-control container" style="width:50%;height:auto;">
                <label style="font-family:Arial Black,Verdana;text-align:center;font-size:large;color:gray;">Mange Admin From List </label>
                <hr />
                <asp:Repeater runat="server" ID="REP_AdminMang">
                    <ItemTemplate>
                         <asp:_AdminManger runat="server" ID="AdminMangCurrent" ADMINNAME='<%#Eval("USERNAME") %>' OnLoad="AdminName_OnLoad" OnChanged="ChangeType_OnSelectChange"  OnAddClick="btn_RemoveAdmin_Click"    />
                    </ItemTemplate>
                </asp:Repeater>
                <br />
                <asp:label runat="server" ID="lb_adMinSettingMessage" style="color:red;font-size:22px;"  Visible="true" Text=""></asp:label>
                <hr />
                   <asp:Button runat="server" ID="btn_SaveMangeAdmin" CssClass="btn btn-primary" Text="Save" Enabled="true" style="width:13%;" OnClick="btn_SaveMangeAdmin_Click"/>
                <asp:Button runat="server" ID="btn_CancelMangeAdmin" CssClass="btn btn-default" Text="Cancel" Enabled="false" style="width:13%" />
            </div>
            
        </asp:View>
        <!-- 8 AdminManger add-->
        <asp:View runat="server" ID="V_AdminMangerAdd">
            <div class="container form-control" style="width:60%;height:auto;"">
                <label class="container" style="height:auto;font-family:Impact,Verdana;font-size:35px;color:#0099FF;vertical-align:sub" >RIGSTER NEW ADMIN IN SITE
                <img style="float:right;" src="../Icons/1433207132_button-add_blue.png" /></label>
                <hr />
                <span class="badge">1</span>
                <label ><strong>New Admin User Name </strong></label>

                 <asp:UpdatePanel runat="server" ID="RefrachAvalibale">
                    <ContentTemplate>
                <asp:TextBox runat="server" ID="NewAdminUserName" placeholder="Enter Admin User Name ..." CssClass="container form-control" style="width:50%;"  ></asp:TextBox><br />
                            
                      <center>  <asp:label runat="server" ID="AdminUserNameValibale" CssClass="container" style="width:15%;height:auto;min-width:75px;" Visible="false" ></asp:label></center>
                      <center><asp:Button runat="server" ID="CheckAvalibale" Text="Check From User Name" OnClick="btn_CheckAvalibale_Click"  CssClass="btn btn-success btn-sm"/></center>
                           </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger  ControlID="CheckAvalibale" EventName="Click"/>
                    </Triggers>
                </asp:UpdatePanel>
               
                <hr />
                <span class="badge">2</span>
                <label><strong>New Admin Password</strong></label><br /><br />
                <label><strong>Insert New Password </strong></label>
                <asp:TextBox runat="server" ID="NewAdminPassword" placeholder="Insert New Password" CssClass="form-control container" style="width:50%;" type="password" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="ReqFirstNewAdminPassword" runat="server" ControlToValidate="NewAdminPassword"  Display="Dynamic" ErrorMessage="This Filed Is Required" ValidationGroup="ADMIN1"></asp:RequiredFieldValidator>             
                <label><strong> Repeate Insert Password</strong></label>
                <asp:TextBox runat="server" ID="NewAdminPasswordAgin" AutoPostBack="true" placeholder="Repeate The Password" CssClass="form-control container" style="width:50%;" type="password" OnTextChanged="NewAdminPasswordAgin_TextChanged"></asp:TextBox>
                <asp:RequiredFieldValidator ID="ReqFirstNewAdminAginPassword" runat="server" ControlToValidate="NewAdminPasswordAgin" Display="Dynamic" ErrorMessage="This Filed Is Required" ValidationGroup="ADMIN"></asp:RequiredFieldValidator>
                <asp:CompareValidator runat="server" ID="CompareNewAdminPassword" ControlToCompare="NewAdminPasswordAgin" ControlToValidate="NewAdminPassword" ErrorMessage="PASSWORD IS NOT MUTCH" Display="Dynamic" ValidationGroup="ADMIN1"></asp:CompareValidator>
                <center><asp:Label runat="server" ID="PassMatchState" CssClass="container" style="color:red;"></asp:Label></center>
                <hr />
                <span class="badge">3</span>
                <label><strong>New Admin Validation</strong></label><br /><br />
               <center> <label><strong>Choose Valid For New Admin From List</strong></label></center><br />
                <asp:DropDownList runat="server" ID="DDL_NewAdminAllRole" CssClass="container form-control" style="width:25%;"  ></asp:DropDownList>
                <hr />
                <center><asp:Button runat="server" ID="SaveNewAdmin" CssClass="btn btn-primary container " style="width:10%;" Text="Save" OnClick="SaveNewAdmin_Click"/>
                    <asp:Button runat="server" ID="CancelNewAdmin" CssClass="btn btn-default container" style="width:10%;" Text="Cancel" />
                </center>
            </div>
            <script type="text/javascript">
                document.getElementById('MainSlide').style.display="block";
            </script>
            
        </asp:View>
        <!-- 9 viewBlock-->
        <asp:View runat="server" ID="V_BlockUser">
          
            <div class="container form-control" style="width:50%;height:auto;">
                <label class="form-control container label-info" style="text-align:center;color:white;font-size:30px;width:auto;height:auto;">BLOCK MANGER </label>
                 <label class="container label-danger form-control" style="width:50%;height:auto;color:white;text-align:center;min-width:30%">Admin Block </label>
                
                <div class="form-control" style="width:auto;height:auto;" id="ss">
                   <label>Insert the UserName For Name You Want To Block </label>
                    <asp:TextBox runat="server" ID="txt_UserNameAdminForBlock" CssClass="form-control container" style="width:35%;" placeholder="Insert Admins UserName"></asp:TextBox>
                    <asp:LinkButton runat="server" ID="LB_BlockAdmin" CssClass="btn  btn-sm" OnClick="LB_BlockAdmin_Click">Block</asp:LinkButton> 
                    <%--Message Confirm block Admin --%>
                    
                        
                    <%-- End Message--%>
                     <asp:label style="color:red;" runat="server" id="lb_AdminBlockState"></asp:label><br />
                   <asp:Repeater runat="server" ID="REP_AdminHasBlocked">
                       <HeaderTemplate>
                           <p style="margin-left:5%"><label>Admin Blocked</label></p>
                       </HeaderTemplate>
                       <ItemTemplate>
                          <asp:Block runat="server" ID="B_Admin" NAME='<%#Eval("USERNAME") %>' OnAddClick="AdminUnblock_OnClick" />
                       </ItemTemplate>
                   </asp:Repeater>
                </div><br />
                
                <label class="container label-danger form-control" style="width:50%;height:auto;color:white;text-align:center;min-width:30%">Users Block </label>
                <div class="form-control" style="width:auto;height:auto;">
                   <label>Insert the UserName For Name You Want To Block </label>
                    <asp:TextBox runat="server" ID="txt_UserNameUserForBlock" CssClass="form-control container" style="width:35%;" placeholder="Insert User UserName"></asp:TextBox>
                    <asp:LinkButton runat="server" ID="LB_BlockUser" CssClass="btn  btn-sm" OnClick="LB_BlockUser_Click">Block</asp:LinkButton> 
                    <asp:UpdatePanel runat="server" ID="Panel_UPUserBlock"><ContentTemplate>
                    <asp:label style="color:red;" runat="server" id="lb_UserBlockState"></asp:label>
                        <asp:Repeater runat="server" ID="REP_UserHasBlocked">
                            <ItemTemplate>
                                <asp:Block runat="server" ID="B_User" NAME='<%#Eval("USERNAME")%>' OnAddClick="UserUnblock_OnClick" />
                            </ItemTemplate>
                        </asp:Repeater>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div><br />
                 <label class="container label-danger form-control" style="width:50%;height:auto;color:white;text-align:center;min-width:30%">Markers Block </label>
                <div class="form-control" style="width:auto;height:auto;">
                   <label>Insert the UserName For Name You Want To Block </label>
                    <asp:TextBox runat="server" ID="txt_MarkerNameForBlock" CssClass="form-control container" style="width:35%;" placeholder="Insert Marke Name "></asp:TextBox>
                    <asp:LinkButton runat="server" ID="LB_BlockMark" CssClass="btn  btn-sm" OnClick="LB_BlockMark_Click">Block</asp:LinkButton>  
                   <asp:Label runat="server" ID="lb_MarkBlockState" ></asp:Label>
                    <asp:Repeater runat="server" ID="REP_MarkerHasBlocked">
                        <ItemTemplate>
                            <asp:Block runat="server" ID="B_Mark" NAME='<%#Eval("MARKER_NAME") %>'  OnAddClick="MarkUnblock_OnClick"/>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div> 
            <script type="text/javascript">
                document.getElementById('MainSlide').style.display="block";
            </script>
        </asp:View>
        <!--10 AdminInfo-->
        <asp:View runat="server" ID="V_AdminInfo">
            <div class="container form-control" style="width:50%;height:auto;">
                <label class="container" style="width:100%;height:auto;min-width:100px;color:#0099FF;font-size:22px;font-family:Arial,Verdana"><span class="glyphIcons glyphIcons-pencil"></span>&nbsp;&nbsp;Admin Information Form For Edit</label><hr />
                <span class="badge">1</span><label class="container" style="height:auto;width:50%;">Verification  INFORMATION</label><br /><br />
                <label class="container" >USERNAME : </label><asp:Label runat="server" ID="AdminUserNameEdit" CssClass="form-control container" style="width:50%;height:auto;" ></asp:Label><br />
                <%-- Password CHange --%>
                <asp:UpdatePanel runat="server" ID="UPPassEditAdmin"><ContentTemplate>
                <div  class="container form-control"  style="width:auto;height:auto">
           <label>PassWord</label>
          <asp:LinkButton runat="server" ID="EditPassActive" style="float:right;" OnClick="EditPassActive_Click">EDIT</asp:LinkButton>
          <div class="container" id="AdminPassInfoEdit" runat="server"  visible="false" style="background-color:lightgray;width:auto;height:auto">
              <table >
                  <tr >
                      <td width="200" style="padding:5px;"></td>
                      <td width="200" style="padding:5px;">Old Password</td>
                      <td style="padding:5px;"><asp:TextBox runat="server" ID="OldAdminPassword" placeholder="Old Password" style="width:auto;height:auto" OnTextChanged="OldAdminPassword_TextChanged" AutoPostBack="true" type="password"></asp:TextBox></td>
                      <asp:RequiredFieldValidator ID="ReqOldPass" runat="server" ControlToValidate="OldAdminPassword" Display="Dynamic" ErrorMessage="* Password Required" ValidationGroup="AdminPass"></asp:RequiredFieldValidator>
                      <td width="200" style="padding:5px;"><asp:Label runat="server" ID="AdminOldPassWrong" style="color:red"></asp:Label></td>
                  </tr>
                  
                  <tr>
                      <td width="200" style="padding:5px;"></td>
                      <td width="200" style="padding:5px;">New Password</td>
                      <td style="padding:5px;"><asp:TextBox runat="server" ID="NewAdminPass" placeholder="New Password" style="width:auto;height:auto" OnTextChanged="NewAdminPass_TextChanged" AutoPostBack="true" type="password"></asp:TextBox></td>
                      <asp:RequiredFieldValidator runat="server" ID="ReqNewPassAdmin" ControlToValidate="NewAdminPass" Display="Dynamic" ErrorMessage="* New PassWord Required" ValidationGroup="AdminPass"></asp:RequiredFieldValidator>
                      <td width="200" style="padding:5px;"><asp:Label runat="server" ID="AdminPassNewWrong" Style="color:red"></asp:Label> </td>
                  </tr>
                  <tr>
                      <td width="200" style="padding:5px;"></td>
                      <td width="200" style="padding:5px;">New Password</td>
                      <td style="padding:5px;"><asp:TextBox runat="server" ID="NewAdminPassA" placeholder="New Password Again" style="width:auto;height:auto" OnTextChanged="NewAdminPassA_TextChanged" AutoPostBack="true" type="password"></asp:TextBox></td>
                      <asp:RequiredFieldValidator ID="ReqAginPass" runat="server" ControlToValidate="NewAdminPassA" Display="Dynamic" ErrorMessage="* Can Not Valid Password Empty" ValidationGroup="AdminPass"></asp:RequiredFieldValidator>
                      <asp:CompareValidator ID="CPassAdmin" runat="server" ControlToCompare="NewAdminPass" ControlToValidate="NewAdminPassA" Display="dynamic" ErrorMessage="Password Not Mutch" ValidationGroup="AdminPass" ValidateRequestMode="Enabled"></asp:CompareValidator>
                      <td width="200" style="padding:5px;"><asp:Label runat="server" ID="AdminPassNewAWrong" style="color:red;"></asp:Label></td>
                  </tr>
                  <tr>
                      <td colspan="4"><hr /></td>
                  </tr>
                  <tr>
                      <td colspan="4"><asp:Label runat="server" ID="AdminPassNewAWarning"></asp:Label></td>
                  </tr>
                  <tr>
                      <td width="200" style="padding-bottom:8px;" ></td>
                      <td width="200" style="padding-bottom:8px;"></td>
                      <td width="300" style="padding-bottom:8px;"><asp:Button runat="server" ID="btn_SaveAdminEditPassword" Text="Save"  CssClass="btn btn-primary" Enabled="false" OnClick="btn_SaveAdminEditPassword_Click"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          <asp:Button runat="server" ID="btn_CancelEditAdminPass" Text="cancel" CssClass="btn btn-default" OnClick="btn_CancelEditAdminPass_Click" />
                      </td>
                  </tr>
              </table>
          </div>
             </ContentTemplate>
             <Triggers>
                 <asp:AsyncPostBackTrigger ControlID="EditPassActive" EventName="Click" />
                 <asp:AsyncPostBackTrigger ControlID="OldAdminPassword" EventName="TextChanged" />
             </Triggers>
         </asp:UpdatePanel>
        </div>
                <!--Info Edit F&L Name-->
                 <asp:UpdatePanel runat="server" ID="UpdatePanel1"><ContentTemplate>
                <div class="container form-control"  style="width:auto;height:auto">
             <label>AdminName</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="AdminInfoView" runat="server" Text=""  ></asp:Label>
            <asp:LinkButton runat="server" ID="EditAdminInfo" style="float:right;" OnClick="EditAdminInfo_Click" >EDIT</asp:LinkButton>
            <div class="container" id="EditInfoAdmin" runat="server"  visible="false" style="background-color:lightgray;height:auto;width:auto;">
                <table>
                    <tr>
                        <td width="200" style="padding:5px;"></td>
                        <td width="200" style="padding:5px;">First Name</td>
                        <td width="200" style="padding:5px;"><asp:TextBox runat="server" ID="FNameAdmin" OnTextChanged="FNameAdmin_TextChanged" AutoPostBack="true"></asp:TextBox></td>
                        <td width="200" style="padding:5px;"><asp:Label ID="FNameWarning" runat="server" style="color:red;"></asp:Label></td>
                    </tr>
                     <tr>
                        <td width="200" style="padding:5px;"></td>
                        <td width="200" style="padding:5px;">LastName</td>
                        <td width="200" style="padding:5px;"><asp:TextBox runat="server" ID="LNameAdmin" OnTextChanged="LNameAdmin_TextChanged"  AutoPostBack="true"></asp:TextBox></td>
                        <td width="200" style="padding:5px;"><asp:Label runat="server" ID="LNameWarning" style="color:red"></asp:Label></td>
                    </tr>
                    <tr>
                      <td colspan="4"><hr /></td>
                  </tr>
                    <tr>
                        <td colspan="4"><asp:Label ID="InfoEditWarning" runat="server" ></asp:Label></td>
                    </tr>
                    <tr>
                      <td width="200" style="padding-bottom:8px;" ></td>
                      <td width="200" style="padding-bottom:8px;"></td>
                      <td width="300" style="padding-bottom:8px;"><asp:Button runat="server" ID="SaveEditInfoAdmin" Text="Save"  CssClass="btn btn-primary" Enabled="false" OnClick="SaveEditInfoAdmin_Click"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                       <asp:Button runat="server" ID="CancelEditInfoAdmin" Text="cancel" CssClass="btn btn-default" OnClick="CancelEditInfoAdmin_Click"  />
                      </td>
                  </tr>
                </table>
            </div>
                </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="SaveEditInfoAdmin" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="FNameAdmin" EventName="TextChanged" />
                        <asp:AsyncPostBackTrigger    ControlID="CancelEmailEditAdmin"  EventName="Click"/>
                    </Triggers>
            </asp:UpdatePanel>
        </div>
                <!--Email-->
                <asp:UpdatePanel runat="server" ID="P_EmailEditAdmin"><ContentTemplate>
                <div class="container form-control"  style="width:auto;height:auto">
             <label>Email</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="EmailAdminView" runat="server" Text="" ></asp:Label>
            <asp:LinkButton runat="server" ID="EditAdminEmailActive" style="float:right;" OnClick="EditAdminEmailActive_Click" >EDIT</asp:LinkButton>
            <div class="container" id="AdminEmailInfoEdit" runat="server"  visible="false" style="background-color:lightgray;height:auto;width:auto;">
                <table>
                    <tr>
                        <td width="200" style="padding:5px;"></td>
                        <td width="200" style="padding:5px;">Email</td>
                        <td width="200" style="padding:5px;"><asp:TextBox runat="server" ID="AdminEmail" OnTextChanged="AdminEmail_TextChanged" AutoPostBack="true"></asp:TextBox></td>
                        <td width="200" style="padding:5px;"><asp:Label runat="server" ID="AdminEmailWRong" style="color:red"></asp:Label></td>
                    </tr>
                    <tr>
                      <td colspan="4"><hr /></td>
                  </tr>
                    <tr>
                        <td colspan="4"><asp:Label runat="server" ID="AdminEmailWarning"></asp:Label></td>
                    </tr>
                    <tr>
                      <td width="200" style="padding-bottom:8px;" ></td>
                      <td width="200" style="padding-bottom:8px;"></td>
                      <td width="300" style="padding-bottom:8px;"><asp:Button runat="server" ID="SaveEditEmailAdmin" Text="Save"  CssClass="btn btn-primary" Enabled="false" OnClick="SaveEditEmailAdmin_Click"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                       <asp:Button runat="server" ID="CancelEmailEditAdmin" Text="cancel" CssClass="btn btn-default" OnClick="CancelEmailEditAdmin_Click"  />
                      </td>
                  </tr>
                </table>
            </div>
                </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="SaveEditEmailAdmin" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="AdminEmail" EventName="TextChanged" />
                        <asp:AsyncPostBackTrigger    ControlID="CancelEmailEditAdmin"  EventName="Click"/>
                    </Triggers>
            </asp:UpdatePanel>
        </div>
                <!--Mobile-->
             <asp:UpdatePanel runat="server" ID="UpdatePanel2"><ContentTemplate>
                <div class="container form-control"  style="width:auto;height:auto">
             <label>Mobile</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="AdminMobileView" runat="server" Text="" ></asp:Label>
            <asp:LinkButton runat="server" ID="EditCillPhoneActive" style="float:right;" OnClick="EditCillPhoneActive_Click" >EDIT</asp:LinkButton>
            <div class="container" id="AdminCellPhoneEdit" runat="server"  visible="false" style="background-color:lightgray;height:auto;width:auto;">
                <table>
                    <tr>
                        <td width="200" style="padding:5px;"></td>
                        <td width="200" style="padding:5px;">MobileNumber</td>
                        <td width="200" style="padding:5px;"><asp:TextBox runat="server" ID="AdminMobile" OnTextChanged="AdminMobile_TextChanged" AutoPostBack="true"></asp:TextBox></td>
                        <td width="200" style="padding:5px;"><asp:Label runat="server" ID="AdminMobileWrong"></asp:Label></td>
                    </tr>
                    <tr>
                      <td colspan="4"><hr /></td>
                  </tr>
                    <tr>
                        <td colspan="4"><asp:Label runat="server" ID="AdminMobileWrning"></asp:Label></td>
                    </tr>
                    <tr>
                      <td width="200" style="padding-bottom:8px;" ></td>
                      <td width="200" style="padding-bottom:8px;"></td>
                      <td width="300" style="padding-bottom:8px;"><asp:Button runat="server" ID="SaveEditAdminMobile" Text="Save"  CssClass="btn btn-primary" Enabled="false" OnClick="SaveEditAdminMobile_Click"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                       <asp:Button runat="server" ID="CancelEditAdminMobile" Text="cancel" CssClass="btn btn-default" OnClick="CancelEditAdminMobile_Click"  />
                      </td>
                  </tr>
                </table>
            </div>
                </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="SaveEditAdminMobile" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="AdminMobile" EventName="TextChanged" />
                        <asp:AsyncPostBackTrigger    ControlID="CancelEditAdminMobile"  EventName="Click"/>
                        <asp:AsyncPostBackTrigger ControlID="EditCillPhoneActive" EventName="Click" />
                    </Triggers>
            </asp:UpdatePanel>
        </div>
            <!---->
              <asp:UpdatePanel runat="server" ID="UpdatePanel3"><ContentTemplate>
                <div class="container form-control"  style="width:auto;height:auto">
             <label>GENDER</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="AdminGenderView" runat="server" Text="" ></asp:Label>
            <asp:LinkButton runat="server" ID="EditGenderAdminActive" style="float:right;" OnClick="EditGenderAdminActive_Click" >EDIT</asp:LinkButton>
            <div class="container" id="AdminGenderEdit" runat="server"  visible="false" style="background-color:lightgray;height:auto;width:auto;">
                <table>
                    <tr>
                        <td width="200" style="padding:5px;">GENDER</td>
                        <td width="200" style="padding:5px;"><asp:CheckBox runat="server" ID="CK_AdmainMaleGender" Text="Male" OnCheckedChanged="CK_AdmainMaleGender_CheckedChanged" AutoPostBack="true" /></td>
                        <td width="200" style="padding:5px;"><asp:CheckBox runat="server" ID="CK_AdminFamleGender" Text="Female" OnCheckedChanged="CK_AdminFamleGender_CheckedChanged" AutoPostBack="true"/></td>
                        <td width="200" style="padding:5px;"></td>
                    </tr>
                    <tr>
                      <td colspan="4"><hr /></td>
                    </tr>
                    <tr>
                        <td colspan="4"><asp:Label runat="server" ID="AdminGenderWarning"></asp:Label></td>
                    </tr>
                    <tr>
                      <td width="200" style="padding-bottom:8px;" ></td>
                      <td width="200" style="padding-bottom:8px;"></td>
                      <td width="300" style="padding-bottom:8px;"><asp:Button runat="server" ID="SaveEditGenderAdmin" Text="Save"  CssClass="btn btn-primary" Enabled="false" OnClick="SaveEditGenderAdmin_Click"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                       <asp:Button runat="server" ID="CancelEditGenderAdmin" Text="cancel" CssClass="btn btn-default" OnClick="CancelEditGenderAdmin_Click"  />
                      </td>
                  </tr>
                </table>
            </div>
                </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="SaveEditGenderAdmin" EventName="Click" />
                       
                        <asp:AsyncPostBackTrigger    ControlID="CancelEditGenderAdmin"  EventName="Click"/>
                    </Triggers>
            </asp:UpdatePanel>
        </div>
            </div>
            <script type="text/javascript">
                document.getElementById('MainSlide').style.display="block";
            </script>
        </asp:View>
        <!--11  User info-->
        <asp:View runat="server" ID="View_Users">
            <div class="container form-control" style="width:80%;height:100%;">
                <asp:Label runat="server" ID="LB_numUser" CssClass=" label-info form-control container" style="width:auto;height:auto;color:white;font-size:25px;text-align:center" ></asp:Label>
                  <asp:UpdatePanel runat="server" ID="UPDATEINFOUSER"><ContentTemplate>
                  <asp:Repeater runat="server" ID="REP_USERS">
                    <HeaderTemplate>
                        <table>
                            <tr>
                                <td width="200" height="50" class=" container">
                                    <label class="form-control container label-primary" style="text-align:center;color:white;">USERNAME</label>
                                </td>
                                <td width="200" height="50" class=" container">
                                    <label class="form-control container label-primary" style="text-align:center;color:white">EAMIL</label>
                                </td>
                                <td width="200" height="50" class=" container">
                                    <label class="form-control container label-primary" style="text-align:center;color:white;">INITAILZE_DATE</label>
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <table>
                            <tr>
                                <td style="width:356px;" height="20" class="container">
                                    <asp:Label runat="server" ID="USERINFOUSER" style="color:white;text-align:center;" class="form-control container label-default" Text='<%#Eval("USERNAME") %>'></asp:Label>
                                </td>
                                 <td style="width:328px;" height="20" class="container">
                                    <asp:Label runat="server" ID="EMAILINFOUSER" style="color:white;text-align:center;" class="form-control container label-default" Text='<%#Eval("EMAIL") %>'>'></asp:Label>
                                </td>
                                 <td style="width:384px;" height="20" class="container">
                                    <asp:Label runat="server" ID="DATEINFOUSER" style="color:white;text-align:center;" class="form-control container label-default" Text='<%#Eval("INITIALIZE_DATE") %>'></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                    <FooterTemplate>
                        <hr />
                        
                    </FooterTemplate>
                </asp:Repeater>
                      </ContentTemplate>
                      
                  </asp:UpdatePanel>
                <asp:Button runat="server" ID="btn_ShoMoreUser" CssClass="btn btn-block btn-default" Text="Show More USERS" OnClick="btn_ShoMoreUser_Click" />
                <asp:Button runat="server" ID="btn_ShowAllUser" CssClass="btn btn-block btn-default" Text="Show ALL USERS" OnClick="btn_ShowAllUser_Click" />
            </div>
            
        </asp:View>
        <asp:View runat="server" ID="Role_Manger">
            
        </asp:View>
    </asp:MultiView>
</asp:Content>

