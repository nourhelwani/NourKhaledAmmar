<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AdminMang.ascx.cs" Inherits="WebUserControl_AdminMang" %>

<div class="container" style="width:100%;height:auto;margin-bottom:5%;background-color:#E0FFE0" >
        <asp:LinkButton runat="server" ID="LB_AdminRemove"   ToolTip="Remove This Admin" onclick="RemoveAdmin_OnClick"  ><span class="glyphicon glyphicon-remove" style="color:lightgray;" ></span></asp:LinkButton>&nbsp;&nbsp;
        <asp:Label runat="server" ID="LB_AdminName" style="font-family:Impact;font-size:18px;color:rgb(125,150,215)"></asp:Label><br />
        <asp:DropDownList runat="server" ID="AdminType" style="border-style:none;float:right;text-align:center;background-color:#E0FFE0"  OnLoad="AdminName_onload"  OnSelectedIndexChanged="ChangeType_OnSelectChange" AutoPostBack="true" ></asp:DropDownList>
        <br />
        <span class="glyphicon glyphicon-stop"></span>&nbsp;&nbsp;
        <asp:Label runat="server" ID="LB_Desc" style="color:#003366;font-family:Segoe UI"></asp:Label><br />
    </div>
