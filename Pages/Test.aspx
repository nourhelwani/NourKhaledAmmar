<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Test.aspx.cs" Inherits="Pages_Serilization" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title></title>
    <style>
        body,
        html {
            margin: 0px;
            padding: 0px;
        }

        #container {
            width: 100%;
            height: 100%;
            position: absolute;
        }
    </style>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC6v5-2uaq_wusHDktM9ILcqIrlPtnZgEk&sensor=false"></script>
    <script type="text/javascript" src="../Scripts/jquery1.10.2.js"></script>
    <script type="text/javascript" src="../Scripts/jqueryui1.11.3.js"></script>
    <link href="../CSSs/bootstrap.min.css" rel="stylesheet" />
    <script type="text/javascript" src="../Scripts/list.js"></script>
    <script type="text/javascript" src="../Scripts/MarkerClusterer.js"></script>
    <script type="text/javascript" src="../Scripts/Codepros.js"></script>

</head>

<body>
    <form runat="server">
        <span class="glyphicon glyphicon-align-left" aria-hidden="true" id="SpanShit"></span>
        <asp:HiddenField ID="hfUserID" runat="server" />
        <asp:HiddenField ID="hfMarkerID" runat="server" />
        <asp:ScriptManager runat="server" ID="myScriptManager" EnablePageMethods="true"></asp:ScriptManager>
        <input type="text" id="tboxPostDesc" runat="server" placeholder="Say What's in your Mind .." class="form-control" />
        <asp:Button runat="server" ID="btnSubmitPost" Text="Submit" CssClass="btn btn-primary" OnClick="btnSubmitPost_Click" />
        <asp:Repeater ID="PostsRepeater" runat="server">
            <HeaderTemplate>
                <table class="table table-hover">
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:Label ID="lblUserNamec" Text='<%#Eval("USER_ID")%>' runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblDescription" Text='<%#Eval("DESCRIPTION")%>' runat="server"></asp:Label>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
    </form>
    <script src="../Scripts/bootstrap.min.js"></script>
    <script>
        (function () {
            //#region test
           <%-- var btnSubmit = document.getElementById('<%=btnSubmitPost.ClientID%>'),
                tboxPostDesc = document.getElementById('tboxPostDesc'),
                MarkerID = document.getElementById('<%=hfMarkerID.ClientID%>').value,
                UserID = document.getElementById('<%=hfUserID.ClientID%>').value;

            btnSubmit.onclick = function () {
                PageMethods.AddPost(tboxPostDesc.value, MarkerID, UserID, function (response) {
                    alert(response);
                }, function (error) {
                    alert(error);
                });
            };--%>
            //#endregion

            var mySpan = document.getElementById('SpanShit'),
                clicked = false;
            mySpan.onclick = function () {
                if (clicked) {
                    mySpan.className = 'glyphicon glyphicon-align-right';
                } else {
                    mySpan.className = 'glyphicon glyphicon-align-left';
                }
                clicked = !clicked;
            }
        })();
    </script>

</body>

</html>
