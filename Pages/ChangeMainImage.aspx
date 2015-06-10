<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChangeMainImage.aspx.cs" Inherits="Pages_ChangeMainImage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Change Main Image</title>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="../CSSs/bootstrap.min.css" />
    <link rel="stylesheet" href="../CSSs/ChangeMainImage.css" />
    <script type="text/javascript" src="../Scripts/jquery1.10.2.js"></script>
    <script type="text/javascript" src="../Scripts/jqueryui1.11.3.js"></script>
    <script type="text/javascript" src="../Scripts/bootstrap.min.js"></script>
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
            <form id="form1" runat="server">
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li style="padding-right: 40px; margin-top: 8px;">
                            <asp:Button ID="btnSubmitChanges" Text="Apply Changes" runat="server" CssClass="btn btn-primary" OnClick="btnSubmitChanges_Click" />
                        </li>
                        <li>
                            <a href="UserControlPanel.aspx"><span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span></a>
                        </li>
                    </ul>
                </div>
        </div>
    </nav>
    <!--Controls-->

    <asp:HiddenField ID="hfSelectedImage" runat="server" />
    <asp:Panel ID="noPhotoPanel" runat="server" Visible="false">

        <h1>No Images Found</h1>
        <asp:Button ID="btnBack" runat="server" CssClass="btn-lg btn-default" Text="Back" OnClick="btnBack_Click" />

    </asp:Panel>

    <div id="imageGallary">
        <asp:Repeater ID="imagesRepeater" runat="server">
            <ItemTemplate>
                <img src='\Photos\<%#Eval("FileName") %>' alt='\Photos\<%#Eval("FileName") %>' width="200" style="cursor: pointer; padding-top: 2em;" />
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <div id="previewImage">
        <img id="bigImage" alt="" />
    </div>
    </form>

    <script>

        $(document).ready(function () {
            $('#imageGallary img').click(function () {

                var bigImagePath = $(this).attr('alt');
                document.getElementById('<%=hfSelectedImage.ClientID%>').value = bigImagePath;
                $('#bigImage').attr('src', bigImagePath);

            });
        });

    </script>

</body>
</html>

