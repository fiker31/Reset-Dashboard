<%@ Page Language="C#" MasterPageFile="~/Credit.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="Profile.aspx.cs" Inherits="_Profile" Title="Back-Up Page" %>

<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Profile</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-md-3">
            <div class="card card-secondary card-outline">
                <div class="card-body box-profile">
                    <div class="text-center">
                        <img class="profile-user-img img-fluid img-circle"
                            src="../Images/Developer.png"
                            alt="User profile picture">
                    </div>
                    <h3 class="profile-username text-center" runat="server" id="txtFullName"></h3>
                    <p class="text-muted text-center" runat="server" id="txtUn"></p>
                    <ul class="list-group list-group-unbordered mb-3">
                        <li class="list-group-item" runat="server" id="txtSc" style="text-align: center !important;"></li>
                    </ul>
                </div>
            </div>
            <div class="card card-secondary card-outline">
                <div class="card-header">
                    <h3 class="card-title"><i class="fa fa-location-arrow"></i>&nbsp;Address</h3>
                </div>
                <div class="card-body">
                    <strong><i class="fas fa-phone-alt mr-1"></i>Phone</strong>
                    <p class="text-muted" runat="server" id="txtPh"></p>
                    <hr>
                </div>
            </div>
        </div>
        <div class="col-md-9">
            <div class="card card-secondary card-outline">
                <div class="card-header p-2">
                    <ul class="nav nav-pills">
                        <li class="nav-item"><a class="nav-link active" href="#salers" data-toggle="tab"><i class="fa fa-users"></i>&nbsp;All Salers</a></li>
                        <li class="nav-item"><a class="nav-link" href="#settings" data-toggle="tab"><i class="fa fa-user-alt"></i>&nbsp;My Profile</a></li>
                    </ul>
                </div>
                <div class="card-body  p-0 m-0 ">
                    <div class="tab-content">
                        <div class="tab-pane active p-0 m-0" id="salers" style="background-color: inherit !important;">
                            <dx:ASPxGridView ID="AllSalers" runat="server" Width="100%" AutoGenerateColumns="False" EnableTheming="True" Theme="MaterialCompact">
                                <SettingsPager PageSize="10"></SettingsPager>
                                <SettingsBehavior AllowFocusedRow="true" />
                                <Styles>
                                    <FocusedRow BackColor="#D4AF37">
                                    </FocusedRow>
                                </Styles>
                                <SettingsPager AlwaysShowPager="True">
                                </SettingsPager>
                                <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowHeaderFilterButton="True" ShowFilterBar="Visible" HorizontalScrollBarMode="Visible"></Settings>
                                <SettingsResizing ColumnResizeMode="Control" />
                                <SettingsDataSecurity AllowEdit="False" AllowInsert="False" AllowDelete="False"></SettingsDataSecurity>
                                <SettingsPopup>
                                    <HeaderFilter MinHeight="140px"></HeaderFilter>
                                </SettingsPopup>
                                <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="WYSIWYG" />
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="Id" MinWidth="300" Visible="false" VisibleIndex="0"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="SalersPhone" Caption="Saler's Phone" MinWidth="150" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Shortcode" Caption="Short Code" MinWidth="120" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Status" MinWidth="120" VisibleIndex="3"></dx:GridViewDataTextColumn>
                                </Columns>
                                <Columns>
                                </Columns>
                                <Toolbars>
                                    <dx:GridViewToolbar>
                                        <SettingsAdaptivity Enabled="true" EnableCollapseRootItemsToIcons="true" />
                                        <Items>
                                            <dx:GridViewToolbarItem Command="ExportToPdf" />
                                            <dx:GridViewToolbarItem Command="ExportToXlsx" />
                                            <dx:GridViewToolbarItem Command="ExportToDocx" />
                                        </Items>
                                    </dx:GridViewToolbar>
                                </Toolbars>
                                <SettingsSearchPanel Visible="true" />
                            </dx:ASPxGridView>
                        </div>
                        <div class="tab-pane m-2" id="settings" style="background-color: inherit !important;">
                            <form class="form-horizontal">
                                <div class="form-group row">
                                    <label for="txtFirstName" class="col-sm-2 col-form-label">First Name : </label>
                                    <div class="col-md-6 col-sm-12">
                                        <asp:TextBox runat="server" ReadOnly="true" class="form-control" ID="txtFirstName" placeholder="First Name"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="txtLastName" class="col-sm-2 col-form-label">Last Name : </label>
                                    <div class="col-md-6 col-sm-12">
                                        <asp:TextBox runat="server" ReadOnly="true" class="form-control" ID="txtLastName" placeholder="Last Name"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="txtUsername" class="col-sm-2 col-form-label">Username : </label>
                                    <div class="col-md-6 col-sm-12">
                                        <asp:TextBox runat="server" ReadOnly="true" class="form-control" ID="txtUsername" placeholder="Username"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="txtPhone" class="col-sm-2 col-form-label">Phone : </label>
                                    <div class="col-md-6 col-sm-12">
                                        <asp:TextBox runat="server" ReadOnly="true" class="form-control" ID="txtPhone" placeholder="Phone"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="txtShortCode" class="col-sm-2 col-form-label">Short Code : </label>
                                    <div class="col-md-6 col-sm-12">
                                        <asp:TextBox runat="server" ReadOnly="true" class="form-control" ID="txtShortCode" placeholder="Short Code"></asp:TextBox>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
