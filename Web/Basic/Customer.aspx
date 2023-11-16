<%@ Page Language="C#" MasterPageFile="~/CreditEditPage.master" AutoEventWireup="true" CodeFile="Customer.aspx.cs" Inherits="Basic_Customers" Title="Customers" %>

<%@ MasterType VirtualPath="~/CreditEditPage.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content2" ContentPlaceHolderID="BootstrapContentPlaceHolder" runat="Server">
    <title>Customers</title>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder3" runat="Server">
                

    <div class="row">
        <div class="col-lg-3 col-md-3 col-sm-12 col-xl-3">
            <div class="input-group">
                <label style="width: 100%;">Registration isn't allowed</label>
                <asp:TextBox class="form-control" ReadOnly="true" ID="txtFullName" runat="server" MaxLength="50" Visible="false" ></asp:TextBox>
            </div>
        </div>
        <div class="col-lg-3 col-md-3 col-sm-12 col-xl-3">
            <div class="input-group">
                <label style="width: 100%;"></label>
               
                <asp:TextBox class="form-control" ReadOnly="true" ID="txtPhoneNumber" runat="server" MaxLength="50" Visible="false"></asp:TextBox>
            </div>
        </div>
    </div>

    <br />
    <div class="row">
        <div class="col-lg-6 col-md-6 col-sm-12 col-xl-6">
            <label class="control-label" visible="False"></label>
            <asp:DropDownList class="form-control select2" ID="ddlStatus" runat="server" Visible="false" >
            </asp:DropDownList>
        </div>
    </div>

</asp:Content>
