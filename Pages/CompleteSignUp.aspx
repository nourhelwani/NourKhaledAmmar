<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" CodeFile="CompleteSignUp.aspx.cs" Inherits="Pages_CompleteSignUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 127px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
       <asp:Label runat="server" ID="lblUserName" ></asp:Label>
    <div id="signUp" style="position:absolute;left:200px;width:551px; top:100px; right: 348px;">
        <table>
            <tr>
                <td colspan="3" align="center"><strong >Sign-Up Here !!</strong></td>
            </tr>
            <tr>
                <td width="100px"><label >First Name :  </label></td>
                <td ><asp:TextBox ValidationGroup="v2" runat="server" EnableViewState="true" ID="tboxFirstName" Width="267px" ></asp:TextBox></td>
                <td><asp:RequiredFieldValidator ID="userNameValidatior" runat="server" ErrorMessage="*" Display="Dynamic" ControlToValidate="tboxFirstName"></asp:RequiredFieldValidator></td>
            </tr>
           <tr>
                <td width="100px"><label>Last Name :  </label></td>
                <td ><asp:TextBox ValidationGroup="v2" runat="server" EnableViewState="true" ID="tboxLastName" Width="267px" ></asp:TextBox></td>
                <td><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" Display="Dynamic" ControlToValidate="tboxLastName"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td width="100px"><label>Gender :  </label></td>
                <td>
                    <asp:DropDownList runat="server" EnableViewState="true"  ID="DropGender">
                    <asp:ListItem Text="Select Gender" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Male"></asp:ListItem>
                    <asp:ListItem Text="Female"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td></td>
                <td><asp:Label runat="server" ID="lblGenderError" Visible="false" Font-Size="Small"></asp:Label></td>
            </tr>
            <tr>
                <td width="100px"><label >Acount Type :  </label></td>
                <td><asp:DropDownList runat="server"  ID="DropAcountType"></asp:DropDownList></td>    
                <td></td>
                <td><asp:Label runat="server" ID="lblAcountError" Visible="false" Font-Size="Small"></asp:Label></td>
            </tr>
            <tr>
                <td width="100px"><label>Cell Phone :  </label></td>
                <td ><asp:TextBox ValidationGroup="v2" runat="server" ID="tboxCellPhone" EnableViewState="true" Width="267px" ></asp:TextBox></td>
                <td><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"  ErrorMessage="*" Display="Dynamic" ControlToValidate="tboxCellPhone"></asp:RequiredFieldValidator></td>
                <td class="auto-style1"><asp:RegularExpressionValidator runat="server" ID="RegulerCellPhone" ControlToValidate="tboxCellPhone" ErrorMessage="invild Number" Font-Size="Small" ValidationExpression="\d{10,14}"></asp:RegularExpressionValidator></td>
            </tr>
            <tr>
                <td><asp:Button runat="server" ID="btnSignUp" Text="Complete Sign-up" Width="127px" OnClick="btnSignUp_Click" /></td>
                <td><asp:Label runat="server" ID="lblError" ForeColor="Black" Visible="false" Font-Size="Small"></asp:Label></td>
            </tr>
        </table>
    </div>
    </div>
    </form>
</body>
</html>
