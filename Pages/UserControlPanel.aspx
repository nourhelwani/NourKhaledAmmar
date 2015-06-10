<%@ Page Title="Control Panel" Language="C#" MasterPageFile="~/Masters/NewControlPanel.master" AutoEventWireup="true" CodeFile="UserControlPanel.aspx.cs" Inherits="Pages_UserControlPanel" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%@ Register TagPrefix="MyControl" TagName="PromoteAdv" Src="~/CustomControl/PromoteAdvertismentControl.ascx" %>
<%@ Register TagName="MarkerControl" TagPrefix="My" Src="~/CustomControl/DefaultMarkerViewControl.ascx" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headHolder" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="Server">
    <ajax:ToolkitScriptManager ID="ScriptMangeraa" EnablePageMethods="true" runat="server"></ajax:ToolkitScriptManager>
    <asp:MultiView runat="server" ID="MultiUserPanal" ActiveViewIndex="7">
        <asp:View runat="server" ID="ViewAddMarker">
            <!-- DataBlock -->

            <asp:HiddenField ID="hfLat" runat="server" />
            <asp:HiddenField ID="hfLng" runat="server" />
            <asp:HiddenField ID="hfSelectedGenre" runat="server" Value="Resturant" />
            <asp:HiddenField ID="hfSelectedIndex" runat="server" Value="1" />
            <asp:HiddenField ID="hfAddress" runat="server" />
            <asp:HiddenField ID="hfDeterminOP" runat="server" />
            <asp:HiddenField ID="hfSelectedID" runat="server" />
            <asp:HiddenField ID="hfWorkingDays" runat="server" />
            <asp:HiddenField ID="hfWorkingHoursFrom" runat="server" />
            <asp:HiddenField ID="hfWorkingHoursTo" runat="server" />
            <asp:HiddenField ID="hfSelectedCategory" runat="server" />
            <asp:Label ID="queryTest" runat="server"></asp:Label>

            <!--Main Map Div-->

            <div id="divAddMarkerMapContainer"></div>
            <input type="button" id="btnAddMarker" class="btn btn-info btn-group-xs" value="Add marker" title="Add Place to the Map" />
            <input type="button" id="btnAddBranch" class="btn btn-info btn-group-xs" value="Add Branch" title="Add Branch to Existing Marker" />

            <!--End Main Div-->

            <!-- Select Category Div -->

            <div class="modal fade" id="basicInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="basicInfoLabel">Basic Information</h4>
                        </div>
                        <div class="modal-body">
                            Select a Genre :
                                    <br />
                            <asp:DropDownList runat="server" ID="ddlSelectGenre" class="form-control"></asp:DropDownList>
                            <br />
                            Enter Marker's Name :
                                    <br />
                            <input type="text" class="form-control" runat="server" id="tboxMarkerName" /><br />
                            <label id="lblErrorMakerName" style="display:none;color:red;font-size:small" >*</label>
                        </div>
                        <div class="modal-footer">
                            <button id="btnSelectCategorySubmit" type="button" class="btn btn-primary">Continue</button>
                        </div>
                    </div>
                </div>
            </div>

            <!--End Select Category Div -->
            <!--Markers Info-->

            <div class="modal fade" id="MarkersInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="AllInfoLabel1"></h4>
                        </div>
                        <div class="modal-body">
                            <table class="table">
                                <tr>
                                    <td>
                                        <h4>Category</h4>
                                    </td>
                                    <td>
                                        <select id="ddlSubCategories" class="form-control"></select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4>Phone</h4>
                                    </td>
                                    <td>
                                        <div class="input-group">
                                            <span class="input-group-addon" id="basic-addon1">011</span>
                                            <input id="tboxPhone" type="text" runat="server" class="form-control" />
                                        </div>
                                        <label id="lblErrorPhoneNumberReq" style="color:red;font-size:small;display:none">*</label>
                                        <label id="lblErrorPhoneNumberRegular" style="color:red;font-size:12px;display:none">Not Valid PhoneNumber</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4>Website</h4>
                                    </td>
                                    <td>
                                        <div class="input-group">
                                            <span class="input-group-addon" id="basic-addon2">www.</span>
                                            <input id="tboxWebsite" type="text" runat="server" class="form-control" />
                                        </div>
                                        <label id="lblErrorWebsiteReq" style="color:red;font-size:small;display:none">*</label>
                                        <label id="lblErrorWebsiteRegular" style="color:red;font-size:12px;display:none">Not Valid WebSite</label>
                                    </td>
                                </tr>
                                <table class="table">
                                    <tr>
                                        <td>
                                            <h4>Working Hours<small> Optional</small></h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div id="ddcWeekDays" class="myDropdownCheckbox">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>From
                                            <select id="ddlAddMarkerTimeFrom" class="form-control">
                                            </select> To
                                            <select id="ddlAddMarkerTimeTo" class="form-control" disabled="disabled">
                                            </select> </td>
                                    </tr>
                                </table>
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <input type="button" id="btnSubmitMarkersInfo" value="Continue" class="btn btn-primary" />
                        </div>
                    </div>
                </div>
            </div>

            <!--Markers Info -->
            <!--All Info-->

            <div class="modal fade" id="AllInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="AllInfoLabel"></h4>
                        </div>
                        <div class="modal-body">
                            <table class="table">
                                <tr>
                                    <td>
                                        <h4>Name</h4>
                                    </td>
                                    <td>
                                        <h5 id="lblMarkerName">test</h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4>Address</h4>
                                    </td>
                                    <td>
                                        <h5 id="lblMarkerAddress"></h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4>Genre</h4>
                                    </td>
                                    <td>
                                        <h5 id="lblMarkerGenre"></h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4>Description</h4>
                                    </td>
                                    <td>
                                        <textarea id="tboxDescription" rows="9" class="form-control" runat="server"></textarea>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="Button1" Text="Add" class="btn btn-primary" runat="server" OnClick="btnSubmitMarker_Click"></asp:Button>
                        </div>
                    </div>
                </div>
            </div>

            <!--End All Info-->


        </asp:View>
        <asp:View ID="ViewEditMarker" runat="server">
            <!--Data Block-->

            <input type="button" id="btnEditMarkerPrev" value="Previous" class="btn btn-primary" />
            <input type="button" value="Edit This" id="btnEditMarkerSelect" class="btn btn-danger" />
            <input type="button" id="btnEditMarkerNext" value="Next" class="btn btn-primary" />
            <asp:HiddenField ID="hfSelectedIDforEdit" runat="server" />
            <asp:HiddenField ID="hfEditDescription" runat="server" />

            <asp:Label ID="lblEditMarkerId" runat="server" Style="display: none;"></asp:Label>

            <div id="editMarkerMapContainer"></div>

            <!--End Data Block-->

            <!--Edit Data Div-->

            <div class="modal fade" id="editinfo" tabindex="-1" role="dialog" aria-labelledby="mymodallabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="editinfolbl"></h4>
                        </div>
                        <div class="modal-body">
                            <table class="table">
                                <tr>
                                    <td>
                                        <h4>Marker Name</h4>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tboxMarkerNameEdit" runat="server" CssClass="form-control"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4>Address</h4>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tboxMarkerAddressEdit" runat="server" CssClass="form-control"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4>Phone</h4>
                                    </td>
                                    <td>
                                        <div class="input-group">
                                            <span class="input-group-addon" id="basic-add">011</span>
                                            <asp:TextBox ID="tboxPhoneNumberEdit" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4>Description</h4>
                                    </td>
                                    <td>
                                        <textarea runat="server" id="tboxEditMarkerDescription" class="form-control">Test!</textarea>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="btnsubmitedit" Text="save changes" class="btn btn-primary" OnClick="btnsubmitedit_Click" runat="server"></asp:Button>
                        </div>
                    </div>
                </div>
            </div>


            <!--End Edit Data Div-->
        </asp:View>
        <asp:View ID="ViewUserInfo" runat="server">
            <div style="position: absolute;top:15%;left:30%;width:40%;border:thin;" id="divUserInformation" runat="server">
               <label style="color: gray">UserName : </label>
               <asp:TextBox runat="server" CssClass="form-control" style="width:100%" ID="tboxUserName" ReadOnly="true"></asp:TextBox>
               <br />
               <label style="color: gray">First Name : </label>
               <asp:TextBox runat="server" ID="tboxFirstName" CssClass="form-control" style="width:100%" ReadOnly="true"></asp:TextBox>
               <br />
               <label style="color: gray">Last Name : </label>
                <div class="input-group">
                  <asp:TextBox runat="server" ID="tboxLastName" style="width:100%" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                  <span class="input-group-addon" style="background-color:#337AB7" ><asp:LinkButton runat="server" ID="lbtnEditLastName" Text="Edit Personal Info" OnClick="lbtnEditLastName_Click" Style="text-decoration: none; color: white" Font-Size="Small"></asp:LinkButton></span>
               </div>
               <br />
               <label style="color: gray">Email : </label>
               <div class="input-group">
                  <asp:TextBox runat="server" CssClass="form-control" ID="tboxEmail" style="width:100%" ReadOnly="true"></asp:TextBox>
                  <span class="input-group-addon" style="background-color:#337AB7" ><asp:LinkButton runat="server" Font-Size="Small" ID="lbtnEditEmail" Text="Edit Email" OnClick="lbtnEditEmail_Click" Style="text-decoration: none; color: white"></asp:LinkButton></span>
               </div>
               <br />
               <label style="color: gray">Cell-Phone : </label>
               <div class="input-group">
                  <asp:TextBox runat="server" ID="tboxCellPhone" CssClass="form-control" style="width:100%" ReadOnly="true"></asp:TextBox>
                  <span class="input-group-addon" style="background-color:#337AB7" ><asp:LinkButton runat="server" ID="lbtnEditCellPhone" Font-Size="Small" Text="Edit Cell-Phone" OnClick="lbtnEditCellPhone_Click" Style="text-decoration: none; color: white"></asp:LinkButton></span>
               </div>
               <br />
               <label style="color: gray">Password : </label>
               <asp:LinkButton runat="server" ID="lbtnEditPassword" Text="Edit Password" Font-Size="Small" OnClick="lbtnEditPassword_Click" Style="text-decoration: none; color: gray"></asp:LinkButton>
               <br />
            </div>
            <asp:MultiView runat="server" ID="MultiUserInfo">
                <asp:View ID="viewEditPersonalInfo" runat="server">
                    <div style="position: absolute;top:15%;left:30%;width:40%"> 
                       <label style="color: gray">First Name :</label>
                       <asp:TextBox runat="server" CssClass="form-control" Width="70%" ValidationGroup="Personal" ID="tboxEditFirstName"></asp:TextBox>
                       <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="v1" ControlToValidate="tboxEditFirstName" ErrorMessage="*" Display="Dynamic" ForeColor="Red" Font-Size="Small"></asp:RequiredFieldValidator>
                       <br />         
                       <label style="color: gray">First Name :</label>
                       <asp:TextBox runat="server" ValidationGroup="Personal" Width="70%" CssClass="form-control" ID="tboxEditLastName"></asp:TextBox>
                       <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="v1" ControlToValidate="tboxEditLastName" ErrorMessage="*" Display="Dynamic" ForeColor="Red" Font-Size="Small"></asp:RequiredFieldValidator>
                       <br />        
                       <asp:Button runat="server" CssClass="btn btn-info btn-group-xs" ID="btnBackPerosnal" Text="Back" OnClick="btnBackPerosnal_Click" Width="10%" />
                       <asp:Button runat="server" CssClass="btn btn-info btn-group-xs" ID="btnDonePersonalInfo" ValidationGroup="Personal" Text="Save" OnClick="btnDonePersonalInfo_Click" />
                       <asp:Label runat="server" ID="lblErrorPersonal" Font-Size="Small" ForeColor="Red"></asp:Label>
                    </div>
                </asp:View>
                <asp:View ID="viewEditEmail" runat="server">
                     <div style="position: absolute;top:15%;left:30%;width:40%">
                        <label style="color: gray">Email : </label>
                        <asp:TextBox CssClass="form-control" runat="server" Width="100%" ValidationGroup="Email" ID="tboxEditEmail"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="Email" ControlToValidate="tboxEditEmail" ErrorMessage="*" Display="Dynamic" ForeColor="Red" Font-Size="Small"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationGroup="Email" ControlToValidate="tboxEditEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ForeColor="Red" ErrorMessage="Invild-Email" Font-Size="Small" Display="Dynamic"></asp:RegularExpressionValidator>
                        <label style="color: gray">Password :</label>
                        <asp:TextBox runat="server" CssClass="form-control" ValidationGroup="Password" ID="tboxPasswordOnEmail" Width="100%" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ValidationGroup="Password" runat="server" ControlToValidate="tboxPasswordOnEmail" ErrorMessage="*" Display="Dynamic" ForeColor="Red" Font-Size="Small"></asp:RequiredFieldValidator>
                        <br />
                        <asp:Button runat="server" Width="10%" CssClass="btn btn-info btn-group-xs" ID="btnBackEmail" Text="Back" OnClick="btnBackPerosnal_Click" />
                        <asp:Button runat="server" CssClass="btn btn-info btn-group-xs" ID="btnDoneEmail" Text="Done" ValidationGroup="Email" OnClick="btnDoneEmail_Click" />
                        <asp:Label runat="server" ID="lblErrorEmail" Font-Size="Small" ForeColor="Red"></asp:Label>        
                    </div>
                </asp:View>
                <asp:View ID="viewEditCellPhone" runat="server">
                    <div style="position: absolute;top:15%;left:30%;width:40%">
                       <label style="color: gray">Cell-Phone : </label>
                       <asp:TextBox runat="server" CssClass="form-control" ValidationGroup="Phone" Width="100%" ID="tboxEditCellPhone"></asp:TextBox>
                       <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="Phone" ControlToValidate="tboxEditCellPhone" Display="Dynamic" ErrorMessage="*" ForeColor="Red" Font-Size="Small"></asp:RequiredFieldValidator>
                       <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationGroup="Phone" ControlToValidate="tboxEditCellPhone" ValidationExpression="\d{10,14}" ForeColor="Red" ErrorMessage="Invild-Number" Font-Size="Small" Display="Dynamic"></asp:RegularExpressionValidator>
                       <br />
                       <asp:Button runat="server" Width="10%" CssClass="btn btn-info btn-group-xs" ID="btnBackCellPhone" Text="Back" OnClick="btnBackPerosnal_Click" />
                       <asp:Button runat="server" CssClass="btn btn-info btn-group-xs" ID="btnDoneCellPhone" Text="Save" ValidationGroup="Phone" OnClick="btnDoneCellPhone_Click" />
                       <asp:Label runat="server" ID="lblErrorCellPhone" Font-Size="Small" ForeColor="Red"></asp:Label> 
                    </div>
                </asp:View>
                <asp:View ID="viewChangePassword" runat="server">
                    <div style="position: absolute;top:15%;left:30%;width:40%">
                       <label style="color: gray">Old Password :</label>
                       <asp:TextBox runat="server" CssClass="form-control" ValidationGroup="Password" ID="tboxOldPassword" Width="100%" TextMode="Password"></asp:TextBox>
                       <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="Password" runat="server" ControlToValidate="tboxOldPassword" ErrorMessage="*" Display="Dynamic" ForeColor="Red" Font-Size="Small"></asp:RequiredFieldValidator>
                       <br />
                       <label style="color: gray">New Password :</label>
                       <asp:TextBox CssClass="form-control" runat="server" ValidationGroup="Password" ID="tboxNewPassword" Width="100%" TextMode="Password"></asp:TextBox>         
                       <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="Password" runat="server" ControlToValidate="tboxNewPassword" ErrorMessage="*" Display="Dynamic" ForeColor="Red" Font-Size="Small"></asp:RequiredFieldValidator>
                       <asp:RegularExpressionValidator runat="server" ValidationGroup="v2" Display="Dynamic" ControlToValidate="tboxNewPassword" Font-Size="Small" ErrorMessage="Must Enter More than 6 char" ValidationExpression="\w{6,100}"></asp:RegularExpressionValidator>
                       <br />
                       <label style="color: gray">Confirm Password :</label>
                       <asp:TextBox runat="server" CssClass="form-control" ID="tboxConfirmPassword" Width="100%" ValidationGroup="Password" TextMode="Password"></asp:TextBox>
                       <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="tboxConfirmPassword" ValidationGroup="Password" ErrorMessage="*" Display="Dynamic" ForeColor="Red" Font-Size="Small"></asp:RequiredFieldValidator>
                       <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="tboxConfirmPassword" ControlToCompare="tboxNewPassword" ValidationGroup="Password" ErrorMessage="Don't Match" Display="Dynamic" ForeColor="Red" Font-Size="Small"></asp:CompareValidator>
                       <br />
                       <asp:Button runat="server" Width="10%" CssClass="btn btn-info btn-group-xs" ID="btnBackPassword" Text="Back" OnClick="btnBackPerosnal_Click" />
                       <asp:Button runat="server" CssClass="btn btn-info btn-group-xs" ID="btnDoneEditPassword" Text="Save" ValidationGroup="Password" OnClick="btnDoneEditPassword_Click" />
                       <asp:Label runat="server" ID="lblErrorPassword" Font-Size="Small" ForeColor="Red"></asp:Label>         
                    </div>
                </asp:View>
            </asp:MultiView>
        </asp:View>
        <asp:View ID="ViewAddAdvertisment" runat="server">
            <!--Choose Adv type-->
             <div class="modal fade" id="divAdvertismentType" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Advertisment Type</h4>
                        </div>
                        <div class="modal-body">
                            <!--for Choose ADvertisment type -->
                            <div id="divChosoeAdvertismentType" >
                                <label >Add : </label>
                                <label class="radio-inline">
                                  <input type="radio" name="AdvType" id="radioAdvertisment" onchange="radioAdvertismentType()" checked="checked" value="option1">Advertisment                                    
                                </label>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label class="radio-inline"><input type="radio" name="AdvType" id="radioEvent" onchange="radioAdvertismentType()" value="option2">Event
                                </label>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
                            <br />
                            <!--Div Event Type-->
                            <div id="divEventType" style="display: none;">
                                <label >Event On : </label>
                                <label class="radio-inline">
                                    <input type="radio" name="EventType" id="radioEventOldMarker" title="If you want to Add Your Event For Old marker  !!" checked="checked" value="option1">in Old Marker                                    
                                </label>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label class="radio-inline"><input type="radio" name="Eventtype" id="radioEventNewMarker" title="If your Event have New Marker !!" value="option2">In New Marker
                                </label>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>            
                        </div>
                        <div class="modal-footer">
                            <input type="button" id="btnShowMap" class="btn btn-info btn-group-xs" value="Show Map" title="Show My Map To Add Advertisment" />
                        </div>
                    </div>
                </div>
            </div>
            <!--Map DIv-->
            <div id="divAddAdvertismentContainer" style="width: 100%;height: 100%; display: none"></div>
            <asp:Label runat="server" ID="lblResultAdv"></asp:Label>
            <%--Advertisment-Info--%>
            <div class="modal fade" id="divAdvertismentInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="basicInafoLabel">Advertisment Info</h4>
                        </div>
                        <div class="modal-body">
                            Add Description :
                            <br />
                            <textarea id="tboxAdvertismentDesciption" rows="4" style="width:100%" class="form-control" runat="server"></textarea>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator9" ControlToValidate="tboxAdvertismentDesciption" ErrorMessage="*" Font-Size="Small" ForeColor="Red"></asp:RequiredFieldValidator>
                            Expire Date :
                            <br />
                            <br />
                            <asp:TextBox runat="server" class="form-control" ID="tboxExpireDate"  style="width:100%"></asp:TextBox>
                            <ajax:CalendarExtender runat="server" TargetControlID="tboxExpireDate" ID="myCalender"></ajax:CalendarExtender>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="btnSubmitAdvertisment" Text="Submit" class="btn btn-primary" runat="server" OnClientClick="javascript:return AddAdvertismentValidate()" OnClick="btnSubmitAdvertisment_Click"></asp:Button>
                        </div>
                    </div>
                </div>
            </div>

            <%--Hidden-Filed--%>
            <asp:HiddenField ID="hiddenMarkerId" runat="server" />
            <asp:HiddenField ID="hiddenExpireDate" runat="server" />
            <asp:HiddenField ID="hiddenAdvertismentType" runat="server" Value="2" />
            <asp:HiddenField ID="hfLatAdv" runat="server" />
            <asp:HiddenField ID="hfLngAdv" runat="server" />
            <asp:HiddenField ID="hfSelectedGenreAdv" runat="server" Value="Resturant" />
            <asp:HiddenField ID="hfSelectedIndexAdv" runat="server" Value="1" />
            <asp:HiddenField ID="hfAddressAdv" runat="server" />
            <asp:HiddenField ID="hfDeterminOPAdv" runat="server" />
            <asp:HiddenField ID="dfSelectedIDAdv" runat="server" />
            <asp:HiddenField ID="hfWorkingDaysAdv" runat="server" />
            <asp:HiddenField ID="hfWorkingHoursToAdv" runat="server" />
            <asp:HiddenField ID="hfWorkingHoursFromAdv" runat="server" />
            <asp:HiddenField ID="hfSelectedCategoryAdv" runat="server" />

            <!-- Marker Catagory -->
            <div class="modal fade" id="basicInfoAdvertisment" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="basicInfoLabel1">Basic Information</h4>
                        </div>
                        <div class="modal-body">
                            Select a Category :
                                                    <br />
                            <asp:DropDownList runat="server" ID="ddlSelectGenreAdv" class="form-control"></asp:DropDownList>
                            <br />
                            Enter Marker's Name :
                                                    <br />
                            <input type="text" class="form-control" runat="server" id="tboxMarkerNameAdv" />
                        </div>
                        <div class="modal-footer">
                            <button id="btnSelectCategorySubmitAdv" type="button" class="btn btn-primary">Continue</button>
                        </div>
                    </div>
                </div>
            </div>

            <!--Adv info-->

            <div class="modal fade" id="AdvInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="AllInfoLabelAdv"></h4>
                        </div>
                        <div class="modal-body">
                            <table class="table">
                                <tr>
                                    <td>
                                        <h4>Category</h4>
                                    </td>
                                    <td>
                                        <select id="ddlSubCategoriesAdv" class="form-control"></select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4>Phone</h4>
                                    </td>
                                    <td>
                                        <div class="input-group">
                                            <span class="input-group-addon" id="basic-addonAdv">011</span>
                                            <input id="tboxMarkerPhoneAdv" type="text" runat="server" class="form-control" />
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4>Website</h4>
                                    </td>
                                    <td>
                                        <div class="input-group">
                                            <span class="input-group-addon" id="basic-addonAdvWeb">www.</span>
                                            <input id="Text2" type="text" runat="server" class="form-control" />
                                        </div>
                                    </td>
                                </tr>
                                <table class="table">
                                    <tr>
                                        <td>
                                            <h4>Working Hours<small> Optional</small></h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div id="ddcWeekDaysAdv" class="myDropdownCheckbox">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>From
                                            <select id="ddlAddMarkerTimeFromAdv" class="form-control">
                                            </select> To
                                            <select id="ddlAddMarkerTimeToAdv" class="form-control" disabled="disabled">
                                            </select> </td>
                                    </tr>
                                </table>
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <input type="button" id="btnSubmitMarkersInfoAdv" value="Continue" class="btn btn-primary" />
                        </div>
                    </div>
                </div>
            </div>

            <!--Adv All Info-->

            <div class="modal fade" id="AllInfoAdv" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="AllInfoLabelAdv1"></h4>
                        </div>
                        <div class="modal-body">
                            <table class="table">
                                <tr>
                                    <td>
                                        <h4>Name</h4>
                                    </td>
                                    <td>
                                        <h5 id="lblMarkerAdv">test</h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4>Address</h4>
                                    </td>
                                    <td>
                                        <h5 id="lblMarkerAddressAdv"></h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4>Genre</h4>
                                    </td>
                                    <td>
                                        <h5 id="lblMarkerGenreAdv"></h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4>Description</h4>
                                    </td>
                                    <td>
                                        <textarea id="tboxDescriptionAdv" rows="9" class="form-control" runat="server"></textarea>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="Button2" Text="Add" class="btn btn-primary" runat="server" OnClick="btnSubmitMarkerAdv_Click"></asp:Button>
                        </div>
                    </div>
                </div>
            </div>

            <!--End Adv All Info-->

        </asp:View>
        <asp:View ID="ViewPrometAdvertisment" runat="server">
            <div style="position:absolute;left:30%;top:2%;width:100%">
                <asp:Repeater runat="server"  ID="repeterPromoteAdv" >
                    <HeaderTemplate></HeaderTemplate>
                    <ItemTemplate>
                        <MyControl:PromoteAdv runat="server" MarkerName='<%# Eval("MARKER_NAME") %>' AdvertismentDiscreption='<%# Eval("Adertisment_Description") %>' ExpireDate='<%# Eval("EXPIRE_DATE") %>'  AdvertismetID='<%# Eval("ADVERTISMENT_ID") %>' OnPromote="OnPromoteAdvertisment_Click" />
                        <br />
                    </ItemTemplate>
                    <FooterTemplate></FooterTemplate>
                </asp:Repeater>
                <asp:Label runat="server" ID="lblerrorPromote" Text="No Advertisment to Promote" Visible="false"></asp:Label>
            </div>
            
        </asp:View>
        <asp:View ID="ViewEditAdvertisment" runat="server">
            <!--Hidden Filed-->
            <asp:HiddenField runat="server" ID="hiddenEditAdvId" />
            <!--Map Div-->
            <div id="divEditAddAdvertismentContainer" style="width: 100%; height: 100%"></div>
            <!--Advertisment Info-->
            <div class="modal fade" id="divEditAdvertismentInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Advertisment Info</h4>
                        </div>
                        <div class="modal-body">
                            Add Description :
                           <br />
                            <textarea id="tboxEditAdvertismentDesc" Width="100%" rows="4" class="form-control" runat="server"></textarea>
                            Expire Date :
                            <br />
                            <asp:TextBox runat="server" class="form-control" ID="tboxExpiteDateAdvEdit" Width="100%"></asp:TextBox>
                            <ajax:CalendarExtender runat="server" TargetControlID="tboxExpiteDateAdvEdit" ID="myCalenderEdit"></ajax:CalendarExtender>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="btnSubmitEditAdv" Text="Save" class="btn btn-primary" runat="server" OnClientClick="javascript:return EditAdvertismentValidate()" OnClick="btnSubmitEditAdv_Click"></asp:Button>
                        </div>
                    </div>
                </div>
            </div>
        </asp:View>
        <asp:View ID="ViewEditEvent" runat="server">
            <!--Map Div-->
            <div id="divMapEditEvent" style="width:100%;height:100%"></div>
            <!--Hidden Filed-->
            <asp:HiddenField runat="server" ID="hiddenEventIdEditEvent" />
            <!--Advertisment Info-->
            <div class="modal fade" id="divEditEventInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Advertisment Info</h4>
                        </div>
                        <div class="modal-body">
                            Event Description :
                            <br />
                            <textarea id="tboxEventDescEdit" Width="100%" rows="4" class="form-control" runat="server"></textarea>
                            Expire Date :
                            <br />
                            <asp:TextBox runat="server" class="form-control" ID="tboxExpireDateEventEdit" Width="100%"></asp:TextBox>
                            <ajax:CalendarExtender runat="server" TargetControlID="tboxExpireDateEventEdit" ID="CalendarExtender1"></ajax:CalendarExtender>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="btnSaveEventEdit" Text="Save" class="btn btn-primary" runat="server" OnClientClick="javascript:return EditEventValidate()" OnClick="btnSubmitEditEvent_Click"></asp:Button>
                        </div>
                    </div>
                </div>
            </div>
        </asp:View>
        <asp:View ID="viewDefault" runat="server">

            <!-- DataFields -->
            <asp:HiddenField ID="hFieldMarkerAddress" runat="server" />
            <asp:HiddenField ID="hFieldMarkerName" runat="server" />

            <!-- Upload Photos Model -->

            <div class="modal fade" id="uploadPhotosModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Upload Photos</h4>
                        </div>
                        <div class="modal-body">
                            Select Images :
                            <br />
                            <!--First Image -->
                            <asp:FileUpload ID="FileUploadfirst" runat="server" CssClass="form-control" />
                            <asp:RegularExpressionValidator ID="regexValidator" runat="server"
                                ControlToValidate="FileUploadFirst"
                                ErrorMessage="Only JPEG images are allowed"
                                ValidationExpression="(.*\.([Jj][Pp][Gg])|.*\.([Jj][Pp][Ee][Gg])$)">
                            </asp:RegularExpressionValidator>
                            <!--Second Image -->
                            <asp:FileUpload ID="FileUploadSecond" runat="server" CssClass="form-control" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server"
                                ControlToValidate="FileUploadSecond"
                                ErrorMessage="Only JPEG images are allowed"
                                ValidationExpression="(.*\.([Jj][Pp][Gg])|.*\.([Jj][Pp][Ee][Gg])$)">
                            </asp:RegularExpressionValidator>
                            <!--Third Image -->
                            <asp:FileUpload ID="FileUploadThird" runat="server" CssClass="form-control" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server"
                                ControlToValidate="FileUploadThird"
                                ErrorMessage="Only JPEG images are allowed"
                                ValidationExpression="(.*\.([Jj][Pp][Gg])|.*\.([Jj][Pp][Ee][Gg])$)">
                            </asp:RegularExpressionValidator>

                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="btnUploadSubmit" Text="Upload" runat="server" CssClass="btn btn-primary" OnClick="btnUploadSubmit_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- End Upload Photos Model -->

            <!--Charts Banner -->

            <div id="divChartsBanner">
                <div id="LastWeekMarkers">
                    
                </div>
            </div>

            <!--End Charts Banner -->
            <!-- Markers Display -->
            <h1>My Markers</h1>
            <div id="divUserMarkers">

                <asp:DataList ID="DefaultDataList" RepeatColumns="4" RepeatDirection="Horizontal" ItemStyle-VerticalAlign="Top" CellPadding="100"
                    CellSpacing="100" runat="server">
                    <ItemTemplate>
                        <My:MarkerControl ID="currentMarker" MarkerName='<%#Eval("MARKER_NAME") %>' MarkerAddress='<%#Eval("ADDRESS") %>'
                            MarkerDescription='<%#Eval("DESCRIPTION") %>' MarkerVisits='<%#Eval("VISITS_COUNTER") %>'
                            MarkerStatus='<%#CheckIfMarkersApproved(Eval("IS_APPORVED"))%>' ImageUrl='<%#CheckIfPhotoExists(Eval("MAIN_IMAGE_PATH")) %>'
                            runat="server"></My:MarkerControl>
                    </ItemTemplate>
                </asp:DataList>
                <asp:GridView ID="qwe" runat="server"></asp:GridView>
            </div>
            <!-- End Display -->
        </asp:View>
    </asp:MultiView>
    <!--Script-->
    <script src="../Scripts/bootstrap-dropdown-checkbox.min.js"></script>
    <script>
        (function(window, Codepros, $) {



            var index = getParameterByName('index'),
                myMap,
                editMap,
                myMapAdv,
                myMapEditAdv,
                myMapEditEvent;

            if (index == 0) {
                    
                var btnAddMarker = document.getElementById('btnAddMarker'),
                    btnAddBranch = document.getElementById('btnAddBranch'),
                    mapContainer = document.getElementById('divAddMarkerMapContainer'),
                    divSelectCategory = document.getElementById('divSelectCategory'),
                    btnSubmitBasicInfo = document.getElementById('btnSelectCategorySubmit'),
                    allInfoHeaderLabel = document.getElementById('AllInfoLabel'),
                    allInfoHeaderLabel1 = document.getElementById('AllInfoLabel1'),
                    ddlSubCategories = document.getElementById('ddlSubCategories'),
                    lblMarkerName = document.getElementById('lblMarkerName'),
                    lblMarkerAddress = document.getElementById('lblMarkerAddress'),
                    lblMarkerCategory = document.getElementById('lblMarkerGenre'),
                    ddlTimeTo = document.getElementById('ddlAddMarkerTimeTo'),
                    ddlTimeFrom = document.getElementById('ddlAddMarkerTimeFrom'),
                    btnSubmitMarkersInfo = document.getElementById('btnSubmitMarkersInfo'),
                    tboxLat = document.getElementById('<%=hfLat.ClientID%>'),
                    tboxLng = document.getElementById('<%=hfLng.ClientID%>'),
                    tboxSelectedGenreIndex = document.getElementById('<%=hfSelectedIndex.ClientID%>'),
                    ddlSelectGenre = document.getElementById('<%=ddlSelectGenre.ClientID%>'),
                    tboxSelectedGenre = document.getElementById('<%=hfSelectedGenre.ClientID%>'),
                    tboxMarkerName = document.getElementById('<%=tboxMarkerName.ClientID%>'),
                    tboxAddress = document.getElementById('<%=hfAddress.ClientID%>'),
                    tboxDeterminOP = document.getElementById('<%=hfDeterminOP.ClientID%>'),
                    tboxSelectedCategoryIndex = document.getElementById('<%=hfSelectedCategory.ClientID%>'),
                    tboxWorkingDays = document.getElementById('<%=hfWorkingDays.ClientID%>'),
                    tboxWorkingHoursFrom = document.getElementById('<%=hfWorkingHoursFrom.ClientID%>'),
                    tboxWorkingHoursTo = document.getElementById('<%=hfWorkingHoursTo.ClientID%>');

                myMap = Codepros.CreateNew(mapContainer, {
                    center: new google.maps.LatLng(35, 35),
                    zoom: 9,
                    geocoder: true
                });

                myMap.PushControl(btnAddMarker, 'top');
                myMap.PushControl(btnAddBranch, 'top');

                btnAddMarker.onclick = function() {
                    myMap.gMap.setOptions({
                        draggableCursor: 'cursor'
                    });
                    myMap._OnOnce({
                        obj: myMap.gMap,
                        event: 'click',
                        callback: function(e) {
                            tboxLat.value = e.latLng.lat();
                            tboxLng.value = e.latLng.lng();
                            $('#basicInfo').modal('show');
                        }
                    })
                }

                btnSubmitBasicInfo.onclick = function() {
                    if(tboxMarkerName.value.length>0){
                    var address = '',
                        subCats,
                        weekDays,
                        workingHours = [];

                    $('#basicInfo').modal('hide');

                    $("#ddlSubCategories").empty();

                    //Calling WebMethod to Add SubCategories Dynamically
                    PageMethods.GetAllSubCats(parseInt(tboxSelectedGenreIndex.value), function(response) {
                        var subCat;
                        subCat = $.parseJSON(response);
                        for (var item in subCat) {
                            var subSubCat = subCat[item];
                            ddlSubCategories.options[ddlSubCategories.options.length] = new Option(subSubCat.DESCRIPTION,
                                subSubCat.CATEGORY_ID);
                        }
                    }, function(error) {
                        console.log(error);
                    });



                    //Adding Week Days To DropDownSelect Menu
                    weekDays = [{
                        id: 1,
                        label: 'Saturday'
                    }, {
                        id: 2,
                        label: 'Sunday'
                    }, {
                        id: 3,
                        label: 'Monday'
                    }, {
                        id: 4,
                        label: 'Tuesday'
                    }, {
                        id: 5,
                        label: 'Wednesday'
                    }, {
                        id: 6,
                        label: 'Thursday'
                    }, {
                        id: 7,
                        label: 'Friday'
                    }];

                    workingHours = [{
                        text: '',
                        value: -1
                    }, {
                        text: '00:00',
                        value: 0
                    }, {
                        text: '00:30',
                        value: 1
                    }, {
                        text: '01:00',
                        value: 2
                    }, {
                        text: '01:30',
                        value: 3
                    }, {
                        text: '02:00',
                        value: 4
                    }, {
                        text: '02:30',
                        value: 5
                    }, {
                        text: '03:00',
                        value: 6
                    }, {
                        text: '03:30',
                        value: 7
                    }, {
                        text: '04:00',
                        value: 8
                    }, {
                        text: '04:30',
                        value: 9
                    }, {
                        text: '05:00',
                        value: 10
                    }, {
                        text: '05:30',
                        value: 11
                    }, {
                        text: '06:00',
                        value: 12
                    }, {
                        text: '06:30',
                        value: 13
                    }, {
                        text: '07:00',
                        value: 14
                    }, {
                        text: '07:30',
                        value: 15
                    }, {
                        text: '08:00',
                        value: 16
                    }, {
                        text: '08:30',
                        value: 17
                    }, {
                        text: '09:00',
                        value: 18
                    }, {
                        text: '09:30',
                        value: 19
                    }, {
                        text: '10:00',
                        value: 20
                    }, {
                        text: '10:30',
                        value: 21
                    }, {
                        text: '11:00',
                        value: 22
                    }, {
                        text: '11:30',
                        value: 23
                    }, {
                        text: '12:00',
                        value: 24
                    }, {
                        text: '12:30',
                        value: 25
                    }, {
                        text: '13:00',
                        value: 26
                    }, {
                        text: '13:30',
                        value: 27
                    }, {
                        text: '14:00',
                        value: 28
                    }, {
                        text: '14:30',
                        value: 29
                    }, {
                        text: '15:00',
                        value: 30
                    }, {
                        text: '15:30',
                        value: 31
                    }, {
                        text: '16:00',
                        value: 32
                    }, {
                        text: '16:30',
                        value: 33
                    }, {
                        text: '17:00',
                        value: 34
                    }, {
                        text: '17:30',
                        value: 35
                    }, {
                        text: '18:00',
                        value: 36
                    }, {
                        text: '18:30',
                        value: 37
                    }, {
                        text: '19:00',
                        value: 38
                    }, {
                        text: '19:30',
                        value: 39
                    }, {
                        text: '20:00',
                        value: 40
                    }, {
                        text: '20:30',
                        value: 41
                    }, {
                        text: '21:00',
                        value: 42
                    }, {
                        text: '21:30',
                        value: 43
                    }, {
                        text: '22:00',
                        value: 44
                    }, {
                        text: '22:30',
                        value: 45
                    }, {
                        text: '23:00',
                        value: 45
                    }, {
                        text: '23:30',
                        value: 47
                    }];

                    for (var hour in workingHours) {

                        ddlTimeFrom.options[ddlTimeFrom.options.length] = new Option(workingHours[hour].text, workingHours[hour].value);
                        ddlTimeTo.options[ddlTimeTo.options.length] = new Option(workingHours[hour].text, workingHours[hour].value);

                    }

                    $("#ddcWeekDays").dropdownCheckbox({
                        data: weekDays,
                        title: "Days of Work",
                        btnClass: 'btn btn-default dropdown-toggle'
                    });

                    ddlTimeFrom.onchange = function() {
                        if (ddlTimeFrom.options[ddlTimeFrom.selectedIndex].text != '') {
                            $('#ddlAddMarkerTimeTo').attr('disabled', false);
                        } else {
                            ddlAddMarkerTimeTo.selectedIndex = 0;
                            $('#ddlAddMarkerTimeTo').attr('disabled', true);
                        }
                    }

                    allInfoHeaderLabel1.innerHTML = "Adding " + tboxSelectedGenre.value;

                    $('#MarkersInfo').modal('show');
                } else{
                                document.getElementById('lblErrorMakerName').style.display='block';
                    return false;
                 }
                }

                btnSubmitMarkersInfo.onclick = function() {
                    var tboxPhone=document.getElementById('<%=tboxPhone.ClientID%>').value,
                                tboxWebsite=document.getElementById('<%=tboxWebsite.ClientID%>').value,
                                lblErrorWebsiteReq=document.getElementById('lblErrorWebsiteReq'),
                                lblErrorWebsiteRegular=document.getElementById('lblErrorWebsiteRegular'),
                                lblErrorPhoneNumberReq=document.getElementById('lblErrorPhoneNumberReq'),
                                lblErrorPhoneNumberRegular=document.getElementById('lblErrorPhoneNumberRegular'),
                                tboxPhoneLength=false,
                                validPhone=false
                    regularPhone=/^\d{7}$/,
                    tboxWebSiteLength=false,
                    validWebSite=false
                    regularWebSite=/(http(s)?:\\)?([\w-]+\.)+[\w-]+[.com|.in|.org|.sy|.edu]+(\[\?%&=]*)?/;
                    if(tboxPhone.length>0){
                        tboxPhoneLength=true;
                        if(regularPhone.test(tboxPhone))
                            validPhone=true;
                    }
                    if(tboxWebsite.length>0){
                        tboxWebSiteLength=true;
                        if(regularWebSite.test(tboxWebsite))
                            validWebSite=true;
                    }
                    if(tboxPhoneLength==true && tboxWebSiteLength==true && validWebSite==true && validPhone==true){
                    var checkedDays,
                        checkedDaysString = '',
                        timeFrom,
                        timeTo;

                    //Saving Values of Markers Info
                    checkedDays = $('#ddcWeekDays').dropdownCheckbox('checked');
                    if (checkedDays.length > 0) {
                        for (var day in checkedDays) {
                            checkedDaysString += checkedDays[day].label + ",";
                        }
                    }
                    tboxWorkingDays.value = checkedDaysString;

                    if (ddlTimeFrom.options[ddlTimeFrom.selectedIndex].text != '') {
                        timeFrom = ddlTimeFrom.options[ddlTimeFrom.selectedIndex].text;
                    }
                    if (ddlTimeTo.options[ddlTimeTo.selectedIndex].text != '') {
                        timeTo = ddlTimeTo.options[ddlTimeTo.selectedIndex].text;
                    }
                    if (timeTo) {
                        tboxWorkingHoursFrom.value = timeFrom;
                        tboxWorkingHoursTo.value = timeTo;
                    }
                    tboxSelectedCategoryIndex.value = ddlSubCategories.options[ddlSubCategories.selectedIndex].value;

                    $('#MarkersInfo').modal('hide');
                    lblMarkerName.innerHTML = tboxMarkerName.value;
                    allInfoHeaderLabel.innerHTML = "Adding " + tboxSelectedGenre.value;

                    myMap.Geocode({
                        latLng: new google.maps.LatLng(tboxLat.value, tboxLng.value),
                        success: function(results) {
                            if (results[0].address_components) {
                                address = [
                                    (results[0].address_components[0] && results[0].address_components[0].short_name || ''),
                                    (results[0].address_components[1] && results[0].address_components[1].short_name || ''),
                                    (results[0].address_components[2] && results[0].address_components[2].short_name || '')
                                ].join(' ');
                            }
                            lblMarkerAddress.innerHTML = address;
                            tboxAddress.value = address;
                        }
                    })
                    lblMarkerGenre.innerHTML = tboxSelectedGenre.value;
                    $('#AllInfo').modal('show');
                    } else if (tboxPhoneLength==true && tboxWebSiteLength==true && validWebSite==true && validPhone==false) {
                        lblErrorWebsiteRegular.style.display='none';
                        lblErrorWebsiteReq.style.display='none';
                        lblErrorPhoneNumberReq.style.display='none';
                        lblErrorPhoneNumberRegular.style.display='block';
                        return false;
                    } else if (tboxPhoneLength==true && tboxWebSiteLength==true && validWebSite==false && validPhone==true) {
                        lblErrorWebsiteRegular.style.display='block';
                        lblErrorWebsiteReq.style.display='none';
                        lblErrorPhoneNumberReq.style.display='none';
                        lblErrorPhoneNumberRegular.style.display='none';
                        return false;
                    }else if (tboxPhoneLength==true && tboxWebSiteLength==true && validWebSite==false && validPhone==false) {
                        lblErrorWebsiteRegular.style.display='block';
                        lblErrorWebsiteReq.style.display='none';
                        lblErrorPhoneNumberReq.style.display='none';
                        lblErrorPhoneNumberRegular.style.display='block';
                        return false;
                    } else if (tboxPhoneLength==true && tboxWebSiteLength==false && validWebSite==false && validPhone==false) {
                        lblErrorWebsiteRegular.style.display='none';
                        lblErrorWebsiteReq.style.display='block';
                        lblErrorPhoneNumberReq.style.display='none';
                        lblErrorPhoneNumberRegular.style.display='block';
                        return false;
                    } else if (tboxPhoneLength==false && tboxWebSiteLength==true && validWebSite==false && validPhone==false) {
                        lblErrorWebsiteRegular.style.display='block';
                        lblErrorWebsiteReq.style.display='none';
                        lblErrorPhoneNumberReq.style.display='block';
                        lblErrorPhoneNumberRegular.style.display='none';
                        return false;
                    } else if (tboxPhoneLength==false && tboxWebSiteLength==true && validWebSite==true && validPhone==false) {
                        lblErrorWebsiteRegular.style.display='none';
                        lblErrorWebsiteReq.style.display='none';
                        lblErrorPhoneNumberReq.style.display='block';
                        lblErrorPhoneNumberRegular.style.display='none';
                        return false;
                    }
                    else if (tboxPhoneLength==true && tboxWebSiteLength==false && validWebSite==false && validPhone==true) {
                        lblErrorWebsiteRegular.style.display='none';
                        lblErrorWebsiteReq.style.display='block';
                        lblErrorPhoneNumberReq.style.display='none';
                        lblErrorPhoneNumberRegular.style.display='none';
                        return false;
                    }else if(tboxPhoneLength==false && tboxWebSiteLength==false){
                        lblErrorWebsiteRegular.style.display='none';
                        lblErrorWebsiteReq.style.display='block';
                        lblErrorPhoneNumberReq.style.display='block';
                        lblErrorPhoneNumberRegular.style.display='none';
                        return false;
                    }
                }

                btnAddBranch.onclick = function() {
                    var markers,
                        markerToAdd,
                        counter = 0;

                    markers = <%= JSONHelper.GetMasterMarkerByUserId(18) %> ;

                    for (var marker in markers) {
                        counter = counter + 1;
                        markerToAdd = markers[marker];
                        myMap.CreateMarker({
                            lat: markerToAdd.LAT,
                            lng: markerToAdd.LNG,
                            id: counter,
                            name: markerToAdd.MARKER_NAME,
                            animation: google.maps.Animation.DROP,
                            content: markerToAdd.MARKER_NAME + "<br/>" + markerToAdd.DESCRIPTION + "<br/>Pin this Master<input type='button' id='submit" + counter + "' value='Submit' class = 'btn btn-primary' onClick = 'DetermineMaster(" + counter + ")'/>"
                        });
                    }
                }
                //EditMarker
            } else if (index == 1) {

                var markers,
                    markerToAdd,
                    counter = 0,
                    markersArray = [],
                    markerToPush,
                    defaultLatLngBounds,
                    btnNext = document.getElementById('btnEditMarkerNext'),
                    btnPrev = document.getElementById('btnEditMarkerPrev'),
                    btnSelect = document.getElementById('btnEditMarkerSelect'),
                    lblEditMarkerName = document.getElementById('<%=tboxMarkerNameEdit.ClientID%>'),
                    lblEditMarkerAddress = document.getElementById('<%=tboxMarkerAddressEdit.ClientID%>'),
                    lblEditMarkerHeader = document.getElementById('editinfolbl'),
                    editMarkerMapContainer = document.getElementById('editMarkerMapContainer'),
                    tboxEditMarkerDescription = document.getElementById('<%=tboxEditMarkerDescription.ClientID%>'),
                            lblEditMarkerId = document.getElementById('<%=lblEditMarkerId.ClientID%>');

                        editMap = Codepros.CreateNew(editMarkerMapContainer, {
                            center: new google.maps.LatLng(35, 35),
                            zoom: 9,
                            geocoder: true,
                            clickable: false,
                            draggable: false,
                            maxZoom: 17,
                            panControl: false,
                            zoomControl: true,
                            zoomControlOptions:{
                                style: google.maps.ZoomControlStyle.SMALL,
                                position: google.maps.ControlPosition.RIGHT_BOTTOM
                            },
                            mapTypeControl: false,
                            scaleControl: false,
                            streetViewControl: false,
                            overviewMapControl: false
                        });

                        editMap.PushControl(btnNext, 'top');
                        editMap.PushControl(btnSelect, 'top');
                        editMap.PushControl(btnPrev, 'top');


                        markers = <%= JSONHelper.MarkersViaUser(18) %> ;

                        for (var marker in markers) {

                            markerToAdd = markers[marker];
                            markerToPush = editMap.CreateMarker({
                                lat: markerToAdd.LAT,
                                lng: markerToAdd.LNG,
                                id: markerToAdd.MARKER_ID,
                                name: markerToAdd.MARKER_NAME,
                                description: markerToAdd.DESCRIPTION,
                                customAddress: markerToAdd.ADDRESS,
                                animation: google.maps.Animation.DROP,
                                content: markerToAdd.MARKER_NAME + "<br />" + markerToAdd.DESCRIPTION + "<br />" + markerToAdd.address
                            });
                            
                            markersArray.push(markerToPush);
                        }

                        defaultLatLngBounds = new google.maps.LatLngBounds();
                        defaultLatLngBounds.extend(markersArray[counter].position);
                        editMap.gMap.fitBounds(defaultLatLngBounds);

                        btnNext.onclick = function() {

                            if (counter < markersArray.length - 1)
                                counter += 1;
                            defaultLatLngBounds = new google.maps.LatLngBounds();
                            defaultLatLngBounds.extend(markersArray[counter].position);
                            editMap.gMap.fitBounds(defaultLatLngBounds);

                        }
                        btnPrev.onclick = function() {

                            if (counter > 0)
                                counter -= 1;
                            defaultLatLngBounds = new google.maps.LatLngBounds();
                            defaultLatLngBounds.extend(markersArray[counter].position);
                            editMap.gMap.fitBounds(defaultLatLngBounds);

                        }

                        btnSelect.onclick = function() {

                            lblEditMarkerName.value= markersArray[counter].name;
                            lblEditMarkerAddress.value= markersArray[counter].customAddress;
                            tboxEditMarkerDescription.value= markersArray[counter].description;
                            lblEditMarkerHeader.innerText = "Editing " + markersArray[counter].name;
                            lblEditMarkerId.innerText = markersArray[counter].id;
                            $('#editinfo').modal('show');

                        }

                    } else if (index == 3) {
                        var newMarker = false;
                        var btnShowMap = document.getElementById('btnShowMap');
                        var markers;
                        $("#divAdvertismentType").modal('show');
                        //for Event New or Old
                        document.getElementById('radioEventNewMarker').onchange = function() {
                            if (document.getElementById('radioEventNewMarker').checked) {
                                newMarker = true;
                            }
                        }
                        document.getElementById('radioEventOldMarker').onchange = function() {
                            if (document.getElementById('radioEventOldMarker').checked) {
                                newMarker = false;
                                alert('Old Makrer');
                            }
                        }
                        btnShowMap.onclick = function() {
                            $("#divAdvertismentType").modal('hide');
                            document.getElementById('divAddAdvertismentContainer').style.display = 'block';
                            myMapAdv = Codepros.CreateNew(document.getElementById('divAddAdvertismentContainer'), {
                                zoom: 13,
                                center: new google.maps.LatLng(33.511300, 3636.291000),
                                geocoder: true
                            });
                            markers = <%= JSONHelper.GetMarkerNotEventByUserId(3) %> ;
                            console.log(markers.length);
                            if (!newMarker) {
                                if (markers.length == 0)
                                    alert('dont have maker');
                            }
                            for (var marker in markers) {
                                //console.log(markers[marker]);
                                var toAdd = markers[marker];
                                myMapAdv.CreateMarker({
                                    lat: toAdd.LAT,
                                    lng: toAdd.LNG,
                                    animation: google.maps.Animation.DROP,
                                    content: '<div style="width:300px;height:150px"><h4><center>' + toAdd.MARKER_NAME + '</center></h4><br>' +
                                        '<strong>Description :</strong></td><td> ' + toAdd.DESCRIPTION + '<br>' +
                                        '<tr><td><strong>Address :</strong></td><td> ' + toAdd.ADDRESS + '<br>' +
                                        '<strong>Visit Counter :</strong></td><td> ' + toAdd.VISITS_COUNTER + '<br>' +
                                        '<button type="button" class="btn btn-primary" data-toggle="button" id="btnAddAdvertisment' + toAdd.MARKER_ID + '" onclick="AddAdvertismentInfo(this.id)" aria-pressed="false" autocomplete="off" value="Go" tyle="width:40%px;height:10%px;font-size:14px">Add Advertisment</button></div>'
                                });
                            }
                            //////////
                            /////////
                            ////////
                            ///////
                            /////
                            ///
                            //
                            //Workplace
                            if (newMarker) {
                                btnSubmitBasicInfoAdv = document.getElementById('btnSelectCategorySubmitAdv'),
                                allInfoHeaderLabelAdv = document.getElementById('AllInfoLabelAdv'),
                                allInfoHeaderLabelAdv1 = document.getElementById('AllInfoLabelAdv1'),
                                ddlSubCategoriesAdv = document.getElementById('ddlSubCategoriesAdv'),
                                lblMarkerNameAdv = document.getElementById('lblMarkerAdv'),
                                lblMarkerAddressAdv = document.getElementById('lblMarkerAddressAdv'),
                                lblMarkerCategoryAdv = document.getElementById('lblMarkerGenreAdv'),
                                ddlTimeToAdv = document.getElementById('ddlAddMarkerTimeToAdv'),
                                ddlTimeFromAdv = document.getElementById('ddlAddMarkerTimeFromAdv'),
                                btnSubmitMarkersInfoAdv = document.getElementById('btnSubmitMarkersInfoAdv'),
                                tboxLatAdv = document.getElementById('<%=hfLatAdv.ClientID%>'),
                                tboxLngAdv = document.getElementById('<%=hfLngAdv.ClientID%>'),
                                tboxSelectedGenreIndexAdv = document.getElementById('<%=hfSelectedIndexAdv.ClientID%>'),
                                ddlSelectGenreAdv = document.getElementById('<%=ddlSelectGenreAdv.ClientID%>'),
                                tboxSelectedGenreAdv = document.getElementById('<%=hfSelectedGenreAdv.ClientID%>'),
                                tboxMarkerNameAdv = document.getElementById('<%=tboxMarkerNameAdv.ClientID%>'),
                                tboxAddressAdv = document.getElementById('<%=hfAddressAdv.ClientID%>'),
                                tboxDeterminOPAdv = document.getElementById('<%=hfDeterminOPAdv.ClientID%>'),
                                tboxSelectedCategoryIndexAdv = document.getElementById('<%=hfSelectedCategoryAdv.ClientID%>'),
                                tboxWorkingDaysAdv = document.getElementById('<%=hfWorkingDaysAdv.ClientID%>'),
                                tboxWorkingHoursFromAdv = document.getElementById('<%=hfWorkingHoursFromAdv.ClientID%>'),
                                tboxWorkingHoursToAdv = document.getElementById('<%=hfWorkingHoursToAdv.ClientID%>');

                                myMapAdv.gMap.setOptions({
                                    draggableCursor: 'cursor'
                                });
                                myMapAdv._OnOnce({
                                    obj: myMapAdv.gMap,
                                    event: 'click',
                                    callback: function(e) {
                                        tboxLatAdv.value = e.latLng.lat();
                                        tboxLngAdv.value = e.latLng.lng();
                                        $('#basicInfoAdvertisment').modal('show');
                                    }
                                })
                            }
                            btnSubmitBasicInfoAdv.onclick = function() {
                                var addressAdv = '',
                                subCatsAdv,
                                weekDaysAdv,
                                workingHoursAdv = [];
                                $('#basicInfoAdvertisment').modal('hide');
                                $("#ddlSubCategoriesAdv").empty();
                                
                                PageMethods.GetAllSubCats(parseInt(tboxSelectedGenreIndexAdv.value), function(response) {
                                    var subCatAdv;
                                    subCatAdv = $.parseJSON(response);
                                    for (var item in subCatAdv) {
                                        var subSubCat = subCatAdv[item];
                                        ddlSubCategoriesAdv.options[ddlSubCategoriesAdv.options.length] = new Option(subSubCat.DESCRIPTION,
                                            subSubCat.CATEGORY_ID);
                                    }
                                }, function(error) {
                                    console.log(error);
                                });

                                weekDaysAdv = [{
                                    id: 1,
                                    label: 'Saturday'
                                }, {
                                    id: 2,
                                    label: 'Sunday'
                                }, {
                                    id: 3,
                                    label: 'Monday'
                                }, {
                                    id: 4,
                                    label: 'Tuesday'
                                }, {
                                    id: 5,
                                    label: 'Wednesday'
                                }, {
                                    id: 6,
                                    label: 'Thursday'
                                }, {
                                    id: 7,
                                    label: 'Friday'
                                }];

                                workingHoursAdv = [{
                                    text: '',
                                    value: -1
                                }, {
                                    text: '00:00',
                                    value: 0
                                }, {
                                    text: '00:30',
                                    value: 1
                                }, {
                                    text: '01:00',
                                    value: 2
                                }, {
                                    text: '01:30',
                                    value: 3
                                }, {
                                    text: '02:00',
                                    value: 4
                                }, {
                                    text: '02:30',
                                    value: 5
                                }, {
                                    text: '03:00',
                                    value: 6
                                }, {
                                    text: '03:30',
                                    value: 7
                                }, {
                                    text: '04:00',
                                    value: 8
                                }, {
                                    text: '04:30',
                                    value: 9
                                }, {
                                    text: '05:00',
                                    value: 10
                                }, {
                                    text: '05:30',
                                    value: 11
                                }, {
                                    text: '06:00',
                                    value: 12
                                }, {
                                    text: '06:30',
                                    value: 13
                                }, {
                                    text: '07:00',
                                    value: 14
                                }, {
                                    text: '07:30',
                                    value: 15
                                }, {
                                    text: '08:00',
                                    value: 16
                                }, {
                                    text: '08:30',
                                    value: 17
                                }, {
                                    text: '09:00',
                                    value: 18
                                }, {
                                    text: '09:30',
                                    value: 19
                                }, {
                                    text: '10:00',
                                    value: 20
                                }, {
                                    text: '10:30',
                                    value: 21
                                }, {
                                    text: '11:00',
                                    value: 22
                                }, {
                                    text: '11:30',
                                    value: 23
                                }, {
                                    text: '12:00',
                                    value: 24
                                }, {
                                    text: '12:30',
                                    value: 25
                                }, {
                                    text: '13:00',
                                    value: 26
                                }, {
                                    text: '13:30',
                                    value: 27
                                }, {
                                    text: '14:00',
                                    value: 28
                                }, {
                                    text: '14:30',
                                    value: 29
                                }, {
                                    text: '15:00',
                                    value: 30
                                }, {
                                    text: '15:30',
                                    value: 31
                                }, {
                                    text: '16:00',
                                    value: 32
                                }, {
                                    text: '16:30',
                                    value: 33
                                }, {
                                    text: '17:00',
                                    value: 34
                                }, {
                                    text: '17:30',
                                    value: 35
                                }, {
                                    text: '18:00',
                                    value: 36
                                }, {
                                    text: '18:30',
                                    value: 37
                                }, {
                                    text: '19:00',
                                    value: 38
                                }, {
                                    text: '19:30',
                                    value: 39
                                }, {
                                    text: '20:00',
                                    value: 40
                                }, {
                                    text: '20:30',
                                    value: 41
                                }, {
                                    text: '21:00',
                                    value: 42
                                }, {
                                    text: '21:30',
                                    value: 43
                                }, {
                                    text: '22:00',
                                    value: 44
                                }, {
                                    text: '22:30',
                                    value: 45
                                }, {
                                    text: '23:00',
                                    value: 45
                                }, {
                                    text: '23:30',
                                    value: 47
                                }];

                                for (var hour in workingHoursAdv) {

                                    ddlTimeFromAdv.options[ddlTimeFromAdv.options.length] = new Option(workingHoursAdv[hour].text,
                                                                                                       workingHoursAdv[hour].value);
                                    ddlTimeToAdv.options[ddlTimeToAdv.options.length] = new Option(workingHoursAdv[hour].text,
                                                                                                   workingHoursAdv[hour].value);
                                }

                                $("#ddcWeekDaysAdv").dropdownCheckbox({
                                    data: weekDaysAdv,
                                    title: "Days of Work",
                                    btnClass: 'btn btn-default dropdown-toggle'
                                });

                                ddlTimeFromAdv.onchange = function() {
                                    if (ddlTimeFromAdv.options[ddlTimeFromAdv.selectedIndex].text != '') {
                                        $('#ddlAddMarkerTimeToAdv').attr('disabled', false);
                                    } else {
                                        ddlAddMarkerTimeToAdv.selectedIndex = 0;
                                        $('#ddlAddMarkerTimeToAdv').attr('disabled', true);
                                    }
                                }
                                allInfoHeaderLabelAdv.innerHTML = "Adding " + tboxSelectedGenreAdv.value;
                                allInfoHeaderLabelAdv1.innerHTML = "Adding " + tboxSelectedGenreAdv.value;

                                $('#AdvInfo').modal('show');

                            }
                            btnSubmitMarkersInfoAdv.onclick = function() {

                                var checkedDaysAdv,
                                    checkedDaysStringAdv = '',
                                    timeFromAdv,
                                    timeToAdv;

                                //Saving Values of Markers Info
                                checkedDaysAdv = $('#ddcWeekDaysAdv').dropdownCheckbox('checked');
                                if (checkedDaysAdv.length > 0) {
                                    for (var day in checkedDaysAdv) {
                                        checkedDaysStringAdv += checkedDaysAdv[day].label + ",";
                                    }
                                }
                                tboxWorkingDaysAdv.value = checkedDaysStringAdv;

                                if (ddlTimeFromAdv.options[ddlTimeFromAdv.selectedIndex].text != '') {
                                    timeFromAdv = ddlTimeFromAdv.options[ddlTimeFromAdv.selectedIndex].text;
                                }
                                if (ddlTimeToAdv.options[ddlTimeToAdv.selectedIndex].text != '') {
                                    timeToAdv = ddlTimeToAdv.options[ddlTimeToAdv.selectedIndex].text;
                                }
                                if (timeToAdv) {
                                    tboxWorkingHoursFromAdv.value = timeFromAdv;
                                    tboxWorkingHoursToAdv.value = timeToAdv;
                                }
                                tboxSelectedCategoryIndexAdv.value = ddlSubCategoriesAdv.options[ddlSubCategoriesAdv.selectedIndex].value;

                                $('#AdvInfo').modal('hide');
                                lblMarkerNameAdv.innerHTML = tboxMarkerNameAdv.value;
                                allInfoHeaderLabelAdv.innerHTML = "Adding " + tboxSelectedGenreAdv.value;

                                myMapAdv.Geocode({
                                    latLng: new google.maps.LatLng(tboxLatAdv.value, tboxLngAdv.value),
                                    success: function(results) {
                                        if (results[0].address_components) {
                                            addressAdv = [
                                                (results[0].address_components[0] && results[0].address_components[0].short_name || ''),
                                                (results[0].address_components[1] && results[0].address_components[1].short_name || ''),
                                                (results[0].address_components[2] && results[0].address_components[2].short_name || '')
                                            ].join(' ');
                                        }
                                        lblMarkerAddressAdv.innerHTML = addressAdv;
                                        tboxAddressAdv.value = addressAdv;
                                    }
                                })
                                lblMarkerGenreAdv.innerHTML = tboxSelectedGenreAdv.value;
                                $('#AllInfoAdv').modal('show');
                            }

                        }
                    } else if (index == 5) {
                        myMapEditAdv = Codepros.CreateNew(document.getElementById('divEditAddAdvertismentContainer'), {
                            zoom: 13,
                            center: new google.maps.LatLng(33.511300, 3636.291000),
                            geocoder: true
                        });
                    
                        var markers = <%= JSONHelper.GetMarkerHaveAvilableAdvertisment(3) %> ;
                        console.log(markers);
                        for (marker in markers) {
                            var toAdd = markers[marker];
                            //For Convert milliesecound to Date
                            var dateInMillisecound = toAdd.EXPIRE_DATE.substr(6, 13);
                            var dateinNumer = parseInt(dateInMillisecound);
                            var date = new Date(dateinNumer);
                            myMapEditAdv.CreateMarker({
                                lat: toAdd.LAT,
                                lng: toAdd.LNG,
                                animation: google.maps.Animation.DROP,
                                content: "<div style='width:300px;height:150px'><strong><center>" + toAdd.MARKER_NAME + "</center></strong><br>" +
                                    "Description : " + toAdd.DESCRIPTION + " <br>" +
                                    "Address :"+toAdd.ADDRESS+"<br>"+
                                    "Expire Date : " + date.toLocaleDateString() + " <br>" +
                                    '<button type="button" class="btn btn-primary" data-toggle="button" id="btnEditAdvertisment' + toAdd.ADVERTISMENT_ID + '" onclick="EditAdvertismentInfo(this.id)" aria-pressed="false" autocomplete="off" value="Go" style="width:40%px;height:10%px;font-size:14px">Edit Advertisment</button></div>'
                            });
                        }
                    }else if (index==6){
                        myMapEditEvent=Codepros.CreateNew(document.getElementById('divMapEditEvent'),{
                            zoom: 13,
                            center: new google.maps.LatLng(33.511300, 36.291000),
                            geocoder: true
                        });
                        var markers=<%=JSONHelper.GetMarkerHaveAvilableEvent(3)%>;  //have Session
                        console.log(markers);
                        for(marker in markers){
                            var toEdit=markers[marker];
                            //For Convert milliesecound to Date
                            var dateInMillisecound = toEdit.EXPIRE_DATE.substr(6, 13);
                            var dateinNumer = parseInt(dateInMillisecound);
                            var date = new Date(dateinNumer);
                            myMapEditEvent.CreateMarker({
                                lat:toEdit.LAT,
                                lng:toEdit.LNG,
                                animation: google.maps.Animation.DROP,
                                content: "<div style='width:300px;height:150px'><strong><center>" + toEdit.MARKER_NAME + "</center></strong><br>" +
                                    "Description : " + toEdit.DESCRIPTION + " <br>" +
                                    "Address :"+toEdit.ADDRESS+"<br>"+
                                    "Expire Date : " + date.toLocaleDateString() + " <br>" +
                                    '<button type="button" class="btn btn-primary" data-toggle="button" id="btnEditEvent' + toEdit.ADVERTISMENT_ID + '" onclick="EditEventInfo(this.id)" aria-pressed="false" autocomplete="off" value="Go" style="width:40%px;height:10%px;font-size:14px">Edit Advertisment</button></div>'
                            });
                        }
                    }

            window.editMap = editMap;
            window.myMap = myMap;
            window.myMapAdv = myMapAdv;
            window.myMapEditAdv = myMapEditAdv;
            window.myMapEditEvent = myMapEditEvent;
        })(window, window.Codepros, jQuery);

function ChangeLabelText() {
    var ddlSelectGenre = document.getElementById('<%=ddlSelectGenre.ClientID%>'),
                        tboxSelectedGenre = document.getElementById('<%=hfSelectedGenre.ClientID%>'),
                        tboxSelectedIndex = document.getElementById('<%=hfSelectedIndex.ClientID%>');

    tboxSelectedGenre.value = ddlSelectGenre.options[ddlSelectGenre.selectedIndex].text;
    tboxSelectedIndex.value = ddlSelectGenre.selectedIndex + 1;
}
function ChangeLabelTextAdv() {
    var ddlSelectGenreAdv = document.getElementById('<%=ddlSelectGenreAdv.ClientID%>'),
                        tboxSelectedGenreAdv = document.getElementById('<%=hfSelectedGenreAdv.ClientID%>'),
                        tboxSelectedIndexAdv = document.getElementById('<%=hfSelectedCategoryAdv.ClientID%>');

            tboxSelectedGenreAdv.value = ddlSelectGenreAdv.options[ddlSelectGenreAdv.selectedIndex].text;
            tboxSelectedIndexAdv.value = ddlSelectGenreAdv.selectedIndex + 1;
        }


        function DetermineMaster(counter) {
            var tboxSelectedId = document.getElementById('<%=hfSelectedID.ClientID%>'),
                        tboxLat = document.getElementById('<%=hfLat.ClientID%>'),
                        tboxLng = document.getElementById('<%=hfLng.ClientID%>');

        console.log(window.myMap);
        myMap.RemoveBy(function(marker) {
            return marker.id != counter;
        });
        tboxSelectedId.value = counter - 1;
        myMap._OnOnce({
            obj: myMap.gMap,
            event: 'click',
            callback: function(e) {
                tboxLat.value = e.latLng.lat();
                tboxLng.value = e.latLng.lng();
                $('#basicInfo').modal('show');
            }
        })
    }

    function getParameterByName(name) {
        name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
        var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
        return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
    }

    function AddAdvertismentInfo(id) {
        //for Get Id for Selected Marker (ADvdertisment)
        var MarkerId = id.substr(18);
        PageMethods.CheckMarkerToAddAvdrtisment(MarkerId, function(response) {
            var CanAdd = $.parseJSON(response);
            //console.log(CanAdd);
            if(CanAdd) {
                document.getElementById('<%=hiddenMarkerId.ClientID%>').value = MarkerId;
                    $('#divAdvertismentInfo').modal('show');
                }else 
                    alert("you Cant Add Advertisment To This Marker Because it Have old Marker")
        }, function(error) {
            console.dir(error);
        });   
        }
        function EditAdvertismentInfo(id) {
            var MarkerId = id.substr(19);
            document.getElementById('<%=hiddenEditAdvId.ClientID%>').value = MarkerId;
                        PageMethods.GetAdvertisementInformationJSON(MarkerId, function(response) {
                            var myAdvData = $.parseJSON(response);
                            //To convert Date from MilliSecuond to Date
                            var dateInMillisecound = myAdvData[0].EXPIRE_DATE.substr(6, 13);
                            var dateinNumer = parseInt(dateInMillisecound);
                            var date = new Date(dateinNumer);
                            //to Fill Advertisment Info 
                            document.getElementById('<%=tboxExpiteDateAdvEdit.ClientID%>').value = date.toLocaleDateString();
                        document.getElementById('<%=tboxEditAdvertismentDesc.ClientID%>').value = myAdvData[0].DESCRIPTION;
                    }, function(error) {
                        console.dir(error);
                    });
                    $('#divEditAdvertismentInfo').modal('show');
                }

                function EditEventInfo(id) {
                    var AdvertismentId = id.substr(12);
                    document.getElementById('<%=hiddenEventIdEditEvent.ClientID%>').value = AdvertismentId;
                    PageMethods.GetAdvertisementInformationJSON(AdvertismentId, function(response) {
                        var myAdvData = $.parseJSON(response);
                        //To convert Date from MilliSecuond to Date
                        var dateInMillisecound = myAdvData[0].EXPIRE_DATE.substr(6, 13);
                        var dateinNumer = parseInt(dateInMillisecound);
                        var date = new Date(dateinNumer);
                        //to Fill Advertisment Info 
                        document.getElementById('<%=tboxEventDescEdit.ClientID%>').value = myAdvData[0].DESCRIPTION;
                        document.getElementById('<%=tboxExpireDateEventEdit.ClientID%>').value = date.toLocaleDateString();
                    }, function(error) {
                        console.dir(error);
                    });
                    $('#divEditEventInfo').modal('show');
                }

                function radioAdvertismentType() { //for choose Advertisment type 
                    if (document.getElementById('radioEvent').checked) {
                        document.getElementById('divEventType').style.display = 'block';
                        document.getElementById('<%=hiddenAdvertismentType.ClientID%>').value = 1;
                            } else if (document.getElementById('radioAdvertisment').checked) {
                                document.getElementById('divEventType').style.display = 'none';
                                document.getElementById('<%=hiddenAdvertismentType.ClientID%>').value = 2;
                    }
            }

        //for Validation Advderisment Info
        function AddAdvertismentValidate() {
            var date = document.getElementById('<%=tboxExpireDate.ClientID%>').value,
                        description = document.getElementById('<%=tboxAdvertismentDesciption.ClientID%>').value,
                        errorDate = false,
                        errorDescription = false;
            var today = new Date();
            //get Date For Today
            //hold Date In Array And month -1 >> month 0-11
            var EditDate = date.split('/');
            EditDate[0] = EditDate[0] - 1;
            var selectedDate = new Date();
            selectedDate.setFullYear(EditDate[2], EditDate[0], EditDate[1]);
            //alert(EditDate[2])
            if (selectedDate >= today) {
                errorDate = true;
            }
            if (description.length != 0) {
                errorDescription = true;
            }
            if (errorDate == true && errorDescription == true) {
                return true;
            } else if (errorDate == true && errorDescription == false) {
                alert('Fill Description Please');
                return false;
            } else if (errorDate == false && errorDescription == true) {
                alert('choose Date After Today');
                return false;
            } else {
                alert('Fill Description And choose Date After today');
                return false;
            }
        }
        //for Validate Edit Advertismert Info DEscription And date
        function EditAdvertismentValidate() {
            var date = document.getElementById('<%=tboxExpiteDateAdvEdit.ClientID%>').value,
                description=document.getElementById('<%=tboxExpiteDateAdvEdit.ClientID%>').value,
                errorDescription=false,
                errorDate = false;
            var today = new Date();
            //get Date For Today
            //hold Date In Array And month -1 >> month 0-11
            var EditDate = date.split('/');
            EditDate[0] = EditDate[0] - 1;
            var selectedDate = new Date();
            selectedDate.setFullYear(EditDate[2], EditDate[0], EditDate[1]);
            //alert(EditDate[2])
            if (selectedDate >= today) {
                errorDate = true;
            }
            if (description.length != 0) {
                errorDescription = true;
            }
            if (errorDate == true && errorDescription == true) {
                return true;
            } else if (errorDate == true && errorDescription == false) {
                alert('Fill Description Please');
                return false;
            } else if (errorDate == false && errorDescription == true) {
                alert('choose Date After Today');
                return false;
            } else {
                alert('Fill Description And choose Date After today');
                return false;
            }
        }
            function OpenModel(btn){
                var workinId = btn.id,
                    markerName = document.getElementById(workinId.replace('btnUploadImages','lblMarkerName')).innerHTML,
                    markerAddress = document.getElementById(workinId.replace('btnUploadImages','lblMarkerAddress')).innerHTML,
                    hfieldMarkerName = document.getElementById('<%=hFieldMarkerName.ClientID%>'),
                hfieldMarkerAddress = document.getElementById('<%=hFieldMarkerAddress.ClientID%>');

                hfieldMarkerName.value = markerName;
                hfieldMarkerAddress.value = markerAddress;

                $('#uploadPhotosModel').modal('show');
            }
            function OpenModelChange(btn){
            
                var workinId = btn.id,
                    markerName = document.getElementById(workinId.replace('btnChangeMarkerImage','lblMarkerName')).innerHTML,
                    markerAddress = document.getElementById(workinId.replace('btnChangeMarkerImage','lblMarkerAddress')).innerHTML;
            
                window.location = "ChangeMainImage.aspx?name="+markerName+"&address="+markerAddress;
            }
    </script>
</asp:Content>
