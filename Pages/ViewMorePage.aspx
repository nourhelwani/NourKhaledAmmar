<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewMorePage.aspx.cs" Inherits="Pages_KhaledTest" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%@ Register Src="~/CustomControl/CommentControl.ascx" TagPrefix="myControl" TagName="Comments" %>
<%@ Register Src="~/CustomControl/AdvertismentsControl.ascx" TagPrefix="myControl" TagName="Advertisment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="HandheldFriendly" content="true"/>
    <link rel="stylesheet" href="../CSSs/bootstrap-dropdown-checkbox.css" />
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
            
        </style>
    <title></title>
</head>
<body style="background-color:#e8e1e1">
    <form id="form1" runat="server">
        <div>
            <ajax:ToolkitScriptManager ID="ScripManager1" runat="server"/>
            <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#">
                        <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>3alyamen</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                  <ul class="nav navbar-nav navbar-right">
                      <li><a href="Home.aspx" title="Home"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a></li>
                      <li><asp:Button runat="server" ID="tnLogOut" Text="LogOut" OnClick="tnLogOut_Click" /></li>
                  </ul>
           </div>
        </nav>
            <asp:HiddenField runat="server" ID="hiddenLat" />
            <asp:HiddenField runat="server" ID="hiddenLng" />
             <div id="body" style="position:absolute;top:7.3%;left:25%;width:50%;height:92.7%;">
            <div id="GeneralInfo" style="position:relative;width:100%;height:30%;background-color:white;border-radius:2px;box-shadow:0px 1px 4px gray">
                <div id="MarkerName" style="position:absolute;width:35%;height:97%;background-color:white">
                    <img src="../10865990_396493330521542_5573745645627231481_o.jpg" alt="test" style="position:absolute;top:20%;left:30%;width:40%;height:40%" class="img-circle"><br /><br /><br /><br /><br /><br />
                    <center>
                        <div style="position:relative;">
                           <asp:Label runat="server" ID="lblMarkerName"></asp:Label>
                           <br />
                           <asp:Label runat="server" ID="lblMarkerAddress"></asp:Label>
                        </div>  
                     </center>
                
                </div>
                <div id="MapDiv"  style="position:absolute;left:35%;width:65%;height:97%;border-radius:5px"></div>
            </div>
            <div  style="position:relative;width:100%;height:64%;">
                <div id="Basic-info" style="position:absolute;top:3%;background-color:white;width:45%;height:40%;border-radius:2px;box-shadow:0px 1px 4px gray">
                    <div style="position:absolute;background-color:#67e479;width:100%;height:3%"></div>
                            <h4 style="position:absolute;left:3%" >Basic information</h4><br /><br />
                            <strong style="position:relative;left:3%">Description : </strong><asp:Label style="position:relative;left:3%" runat="server" ID="lblDescription" Font-Size="Small"></asp:Label><br />
                            <strong style="position:relative;left:3%;top:1%">Gener : </strong><asp:Label style="position:relative;left:3%;top:1%" runat="server" ID="lblGener" Font-Size="Small"></asp:Label><br />
                            <strong style="position:relative;left:3%;top:1%">Work Day : </strong><asp:Label style="position:relative;left:3%;top:1%" runat="server" ID="lblAvalabileDay" Font-Size="Small"></asp:Label><br />
                            <strong style="position:relative;left:3%;top:1%">Work Time : </strong><asp:Label style="position:relative;left:3%;top:1%" runat="server" ID="lblWorkTime" Font-Size="Small"></asp:Label>        
                </div>
                <div id="call-info" style="position:absolute;top:3%;left:50%;background-color:white;width:50%;height:22%;border-radius:2px;box-shadow:0px 1px 4px gray">
                    <div style="position:absolute;background-color:#77a9fa;width:100%;height:5%"></div>
                    <div style="position:absolute;left:3%">
                        <h4 >Call Info</h4>
                        <strong >Web-Site : </strong><asp:Label style="position:relative;left:3%;top:1%" runat="server" ID="lblWebSite" Font-Size="Small"></asp:Label><br />
                        <strong >Phone-Number : </strong><asp:Label style="position:relative;left:3%;top:1%" runat="server" ID="lblPhoneNumber" Font-Size="Small"></asp:Label><br />
                    </div>
                </div>  
                <div id="Rating" style="position:absolute;top:46%;background-color:white;width:45%;height:20%;border-radius:2px;box-shadow:0px 1px 4px gray">
                    <div style="position:absolute;background-color:orange;width:100%;height:4%"></div>
                        <h4 style="position:absolute;left:3%">Rating</h4>
                        <asp:UpdatePanel ID="pnlRating" runat="server">
                        <ContentTemplate>
                            <table style="position:absolute;left:3%;top:30%" >
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
                <div id="Photo" style="position:absolute;top:28%;left:50%;background-color:white;width:50%;height:40%;border-radius:2px;box-shadow:0px 1px 4px gray">
                    <div style="position:absolute;background-color:#fb7373;width:100%;height:3%"></div>
                        <h4 style="position:absolute;left:3%">Photo</h4>
                </div>
                <div id="Comment" style="position:absolute;top:69.5%;background-color:white;width:45%;height:37%;border-radius:2px;box-shadow:0px 1px 4px gray">
                    <div style="position:absolute;background-color:pink;width:100%;height:4%"></div>
                    <h4 style="position:absolute;left:3%;" >Reviews </h4>
                    <div style="position:absolute;left:3%;top:25%;height:70%;width:97%;overflow-y: auto;">
                        <asp:LinkButton runat="server" ID="linkNocomments" OnClientClick="$('#divAddComment').modal('show'); return false;" Visible="false" ></asp:LinkButton>
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:Repeater runat="server" ID="repeterComments" >
                            <HeaderTemplate>
                                <table class="table">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr onmouseover="this.style.backgroundColor='ghostwhite'" onmouseout="this.style.backgroundColor=''">
                                    <td>
                                        <myControl:Comments runat="server" id="commentsControl" Email='<%#Eval("EMAIL") %>' Comment='<%#Eval("DESCRIPTION") %>' />
                                   </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                    <tr>
                                        <td>
                                            <a onclick="Addcomment()">Add Comment</a>
                                        </td>
                                    </tr>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnAddComment" EventName="click" />
                            </Triggers>
                        </asp:UpdatePanel>
                        
                    </div>
                </div>
                <div id="Advertisments" style="position:absolute;top:71%;left:50%;background-color:white;width:50%;height:36%;border-radius:2px;box-shadow:0px 1px 4px gray">
                    <div style="position:absolute;background-color:chocolate;width:100%;height:4%"></div>
                    <h4 style="position:absolute;left:3%;" >Advertisments</h4>
                    <div style="position:absolute;left:3%;top:25%;height:70%;width:97%;overflow-y: auto;">
                        <asp:Label runat="server" ID="lblDontHaveAdv" Visible="false"></asp:Label>
                        <asp:Repeater runat="server" ID="repeaterAdvertisment" >
                            <HeaderTemplate>
                                <table class="table">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr onmouseover="this.style.backgroundColor='ghostwhite'" onmouseout="this.style.backgroundColor=''">
                                    <td>
                                        <myControl:Advertisment runat="server" ID="myAdv" StartDate='<%#Eval("INITIALIZE_DATE") %>' EndDate='<%#Eval("EXPIRE_DATE") %>' AdvDescription='<%#Eval("DESCRIPTION") %>' />
                                   </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>

                </div>
            </div> 
        </div>   
            <div class="modal fade" id="divAddComment">
              <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Add Review</h4>
                    </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label  for="exampleInputEmail1">Email address : </label>
                        <input type="text" class="form-control" id="tboxEmail" runat="server" style="width:90%"  placeholder="Enter email" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Display="Dynamic" runat="server"  ErrorMessage="*" ControlToValidate="tboxEmail"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Font-Size="Small" ControlToValidate="tboxEmail" ErrorMessage="Invalid Email" />
                    </div>
                    <div class="form-group">
                        <label  for="exampleInputEmail1">Comment : </label>
                        <input  type="text" class="form-control" id="tboxComment" style="width:90%" runat="server" placeholder="Write Comment.." /><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" runat="server" ErrorMessage="*" ControlToValidate="tboxComment"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <asp:Button runat="server" ID="btnAddComment" OnClientClick="$('#divAddComment').modal('hide');"  CssClass="btn btn-primary" Text="Save" OnClick="AddComment_Click" />
                </div>
            </div><!-- /.modal-content -->
          </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
        </div>
    </form>
    <script>
        (function (window, Codepros, $) {
            <%--var Lat = parseFloat(document.getElementById('<%=hiddenLat.ClientID%>').value),
                Lng = parseFloat(document.getElementById('<%=hiddenLng.ClientID%>').value);
            var myMap = Codepros.CreateNew(document.getElementById('MapDiv'), {
                center: new google.maps.LatLng(Lng, Lat),
                zoom: 16,
                disableDefaultUI: true,
                draggable:false
            });
            var Marker=myMap.CreateMarker({
                lat: Lng,
                lng: Lat--%>
            
            
        })(window, window.Codepros, jQuery);
        function Addcomment() {
            if ('<%=Session["Email"]%>')
                document.getElementById('<%=tboxEmail.ClientID%>').value = '<%=Session["Email"]%>';
            $('#divAddComment').modal('show');
        }
    </script>
</body>
</html>
