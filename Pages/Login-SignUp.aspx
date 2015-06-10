<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login-SignUp.aspx.cs" Inherits="Pages_Default" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="../CSSs/bootstrap-dropdown-checkbox.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="../CSSs/bootstrap.min.css" />
    <script type="text/javascript" src="../Scripts/jquery1.10.2.js"></script>
    <script type="text/javascript" src="../Scripts/jqueryui1.11.3.js"></script>
    <script type="text/javascript" src="../Scripts/bootstrap.min.js"></script>
    <title>LogIn / SignUp </title>
    <style>
        a:hover {
            color:white;
        }
        a {
            color:white;
        }
            a:visited {
                color:white;
            }
    </style>
    <script type="text/javascript">
        function showSignInBtn() {
            $('#signIn').addClass('active');
            $('#SignUp').removeClass('active');
            document.getElementById('divsign-in').style.display = "block";
            document.getElementById('divsign-up').style.display = "none";
        }
        function showSignUpBtn() {
            $('#SignUp').addClass('active');
            $('#signIn').removeClass('active');
            document.getElementById('divsign-in').style.display = "none";
            document.getElementById('divsign-up').style.display = "block";
        }
        function ShowCompleateSignUpDiv() {
            document.getElementById('divsign-in').style.display = "none";
            document.getElementById('NavSignIn_SignUp').style.display = "none";
            document.getElementById('divsign-up').style.display = 'none';
            document.getElementById('CompleteSignUp').style.display = 'block';
        }
    </script>
</head>
<body style="background-color:white;color:#cccccc"><!--//e8e8e8-->
  <form id="form1" runat="server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <div>   
        <div id="mybody" style="position:absolute;left:30%;width:40%;height:100%;background-color:#323542"><!-- #323542-->
           <div id="logo" style="position:absolute;width:100%";height:35%>
               <center>
                   <a href="#" style="text-decoration:none;"><h1>3alyamen</h1></a>
                   <img src="../Icons/location.png" style="width:40%;height:100%" />
               </center>
           </div>
           <div id="subscripe" style="position:absolute;top:30%;width:100%">
               <div id="NavSignIn_SignUp" style="width:95%;margin-left:2%" >
                 <ul class="nav nav-tabs">
                    <li role="presentation" id="signIn" class="active"><a id="btnSignInNav" onclick="showSignInBtn()">Sign-in</a></li>
                    <li role="presentation" id="SignUp"><a onclick="showSignUpBtn()">Sign-up</a></li>
                 </ul>
              </div>
               <asp:UpdatePanel runat="server" ID="UpdatePanelSign_In">
                  <ContentTemplate>
                   <div id="divsign-in" style="width:95%;margin-left:2%">
                     <br />
                     <label  for="tboxUsername">UserName :</label>
                     <asp:TextBox ValidationGroup="v1" style="background:#cccccc" CssClass="form-control" runat="server"  ID="tboxUsername" Width="100%"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="validationUserName" ValidationGroup="v1" runat="server" ErrorMessage="*" ControlToValidate="tboxUsername"></asp:RequiredFieldValidator>
                     <asp:RegularExpressionValidator Display="Dynamic" runat="server" ValidationGroup="v1" ErrorMessage="inviled userName" ValidationExpression="[A-Za-z][A-Za-z0-9._]{2,50}" ControlToValidate="tboxUsername" Font-Size="Small"></asp:RegularExpressionValidator>
                     <br />
                     <label>Password : </label>
                     <asp:TextBox runat="server" style="background:#cccccc" CssClass="form-control" ValidationGroup="v1" ID="tboxPassword" Width="100%" TextMode="Password"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="validationPassword" runat="server" ValidationGroup="v1" ErrorMessage="*" ControlToValidate="tboxPassword"></asp:RequiredFieldValidator>
                     <br />
                     <asp:CheckBox runat="server" ID="cboxRememper" Font-Size="Medium" Text=" Rememper Me " />
                     <br />
                     <asp:Button runat="server" CssClass="btn btn-primary" ValidationGroup="v1" ID="btnSignIn" Text="Sign-In" Width="100px" OnClick="signinbtn_Click" />
                     <a href="#" onclick="ShowInfoDiv()" style="position:absolute;right:2%;font-weight:500;text-decoration:none;">forget your Password..</a>
                     <br /><br />
                     <asp:Label runat="server" ID="lblError" Font-Size="Small" Visible="false"></asp:Label>
                   </div>
                  </ContentTemplate>
                  <Triggers>
                     <asp:AsyncPostBackTrigger EventName="Click" ControlID="btnSignIn" />
                  </Triggers>
               </asp:UpdatePanel>
               <asp:UpdatePanel runat="server" ID="UpdatePanelSign_up">
                   <ContentTemplate>
                     <div id="divsign-up" style="display:none;width:95%;margin-left:2%">
                       <br />
                       <label>UserName : </label>
                       <asp:TextBox ValidationGroup="v2" runat="server" style="background:#cccccc"  CssClass="form-control" ID="tboxuserNameSignUp" Width="100%" ></asp:TextBox>
                       <asp:RequiredFieldValidator ID="userNameValidatior" runat="server" ValidationGroup="v2" ErrorMessage="*" Display="Dynamic" ControlToValidate="tboxuserNameSignUp"></asp:RequiredFieldValidator>
                       <asp:RegularExpressionValidator runat="server" ValidationGroup="v2" ErrorMessage="inviled userName"  ValidationExpression="[A-Za-z][A-Za-z0-9._]{2,50}" Display="Dynamic" ControlToValidate="tboxuserNameSignUp" Font-Size="Small"></asp:RegularExpressionValidator>
                       <br />
                       <label>Password : </label>
                       <asp:TextBox ValidationGroup="v2" style="background:#cccccc" runat="server" ID="tboxPasswordSignUp" CssClass="form-control" Width="100%" TextMode="Password" ></asp:TextBox>
                       <asp:RequiredFieldValidator ID="passWordValidatior" runat="server" ValidationGroup="v2" ErrorMessage="*" Display="Dynamic" ControlToValidate="tboxPasswordSignUp"></asp:RequiredFieldValidator>
                       <asp:RegularExpressionValidator runat="server" ValidationGroup="v2" Display="Dynamic" ControlToValidate="tboxPasswordSignUp" Font-Size="Small" ErrorMessage="Must Enter More than 6 char" ValidationExpression="\w{6,100}"></asp:RegularExpressionValidator>
                       <br />            
                       <label>Confirm Password : </label>
                       <asp:TextBox ValidationGroup="v2" style="background:#cccccc" runat="server" ID="tboxConfirmPassword" Width="100%" CssClass="form-control" TextMode="Password" ></asp:TextBox>
                       <asp:RequiredFieldValidator ID="ConfirmPassValidator" runat="server" ValidationGroup="v2" ErrorMessage="*" Display="Dynamic" ControlToValidate="tboxPasswordSignUp"></asp:RequiredFieldValidator>
                       <asp:CompareValidator runat="server" ID="CompareConfirmPassword" ValidationGroup="v2" ControlToCompare="tboxPasswordSignUp" Display="Dynamic" Font-Size="Small" ErrorMessage="Don't Match" ControlToValidate="tboxConfirmPassword"></asp:CompareValidator>
                       <br />
                       <label>Email : </label>
                       <asp:TextBox ValidationGroup="v2" style="background:#cccccc" runat="server" ID="tboxEmail" Width="100%" CssClass="form-control" ></asp:TextBox>
                       <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="v2" ErrorMessage="*" ControlToValidate="tboxEmail"></asp:RequiredFieldValidator>
                       <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationGroup="v2" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Font-Size="Small" ControlToValidate="tboxEmail" ErrorMessage="Invalid Email" />
                       <br />
                       <asp:Button runat="server" CssClass="btn btn-primary"   ValidationGroup="v2" ID="btnCompleteInfo" Text="Next" width="20%"  OnClick="btnCompleateInfo_Click" />
                       <asp:Label runat="server" ID="lblErrorSignUp" Visible="false" Font-Size="Small" Text="dsa" ></asp:Label>
                     </div>
                    </ContentTemplate>
                    <Triggers>
                       <asp:AsyncPostBackTrigger EventName="Click" ControlID="btnCompleteInfo" />
                    </Triggers>
               </asp:UpdatePanel>
               <asp:UpdatePanel runat="server" ID="UpdatePanelCompleateSignUp">
                  <ContentTemplate>
                     <div id="CompleteSignUp" style="display:none;width:95%;margin-left:2%">
                        <asp:Label runat="server" style="font-size:large;font-weight:300" ForeColor="#009933" ID="lblUserName" ></asp:Label><br /><br />
                        <label >First Name :  </label>
                        <asp:TextBox ValidationGroup="v3" style="background:#cccccc" CssClass="form-control" Width="100%" runat="server" EnableViewState="true" ID="tboxFirstName"  ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" Display="Dynamic" ControlToValidate="tboxFirstName"></asp:RequiredFieldValidator>
                        <br />   
                        <label>Last Name :  </label>
                        <asp:TextBox ValidationGroup="v3" style="background:#cccccc" runat="server" CssClass="form-control" Width="100%" EnableViewState="true" ID="tboxLastName" ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" Display="Dynamic" ControlToValidate="tboxLastName"></asp:RequiredFieldValidator>
                        <br />
                        <label>Gender :  </label>
                        <asp:DropDownList  runat="server" ID="DropGender">
                            <asp:ListItem Text="Select Gender" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Male"></asp:ListItem>
                            <asp:ListItem Text="Female"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:Label runat="server" ID="lblGenderError" Visible="false" Font-Size="Small"></asp:Label>
                        <br /><br />
                        <label >Acount Type :  </label>
                        <asp:DropDownList runat="server"  ID="DropAcountType"></asp:DropDownList>
                        <asp:Label runat="server" ID="lblAcountError" Visible="false" Font-Size="Small"></asp:Label>
                        <br /><br />
                        <label>Cell Phone :  </label>
                        <asp:TextBox ValidationGroup="v3" style="background:#cccccc" runat="server" ID="tboxCellPhone" CssClass="form-control" Width="100%" EnableViewState="true" ></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="v3" ID="RequiredFieldValidator4" runat="server"  ErrorMessage="*" Display="Dynamic" ControlToValidate="tboxCellPhone"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ValidationGroup="v3" runat="server" ID="RegulerCellPhone" ControlToValidate="tboxCellPhone" ErrorMessage="invild Number" Font-Size="Small" ValidationExpression="\d{10,14}"></asp:RegularExpressionValidator>
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-primary" ValidationGroup="v3" ID="btnSignUp" Text="Done" Width="25%" OnClick="btnSignUp_Click" />
                        <asp:Label runat="server" ID="lblErrorCompleateSignUP" ForeColor="Black" Visible="false" Font-Size="Small"></asp:Label>
                     </div>  
                 </ContentTemplate>
                 <Triggers>
                     <asp:AsyncPostBackTrigger ControlID="btnSignUp" EventName="Click" />
                 </Triggers>
               </asp:UpdatePanel>           
           </div>
        </div>
    </div>
 </form>   
</body>
</html>

