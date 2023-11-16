<%@ Page Language="C#" MasterPageFile="~/Credit.master" AutoEventWireup="true" CodeFile="Txn.aspx.cs" Inherits="_Txn" Title="Txn" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Customers</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row " style="overflow-x: auto">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xl-12 col-12 m-0 p-0">

            <div class="card card-secondary card-outline">
                <div class="card-body  m-0 p-0">


                    <dx:ASPxGridView ID="MyTransactions" runat="server" Width="100%" AutoGenerateColumns="False" EnableTheming="True" Theme="MaterialCompact" DataSourceID="TxnSqlDataSource" KeyFieldName="Id">
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
                            <dx:GridViewDataTextColumn FieldName="Id" MinWidth="100" Visible="false" VisibleIndex="0" ></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Shortcode" Caption="Short Code" MinWidth="120" VisibleIndex="1" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="TransactionEndDate" Caption="Transaction Date" MinWidth="200" VisibleIndex="2" Visible="false">
                                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy hh:mm ss tt">
                                </PropertiesDateEdit>
                            </dx:GridViewDataDateColumn>
                            <dx:GridViewDataTextColumn FieldName="PhoneNumber" MinWidth="150" VisibleIndex="3"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Amount" MinWidth="120" VisibleIndex="4" Visible="false">
                                <PropertiesTextEdit DisplayFormatString="#,###" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Phone" Caption="Customer Phone" MinWidth="150" VisibleIndex="5" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="TransactionId" MinWidth="150" VisibleIndex="6" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Status" MinWidth="100" VisibleIndex="7"></dx:GridViewDataTextColumn>
                        </Columns>
                        <SettingsPager Position="Bottom">
                            <PageSizeItemSettings Items="15,20,50" />
                        </SettingsPager>
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
                        <Settings ShowFooter="true" />
                        <TotalSummary>
                            <dx:ASPxSummaryItem FieldName="PhoneNumber" SummaryType="Count" />
                            <dx:ASPxSummaryItem FieldName="Amount" SummaryType="Sum" Visible="false"/>
                        </TotalSummary>
                    </dx:ASPxGridView>
                    <asp:SqlDataSource runat="server" ID="TxnSqlDataSource" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>' SelectCommand="SELECT [Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate] FROM [MerchantAppTXN] WHERE ([Shortcode] = @Shortcode) ORDER BY [TransactionEndDate] DESC">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="PhoneNumber" Name="PhoneNumber" Type="String"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
        </div>
    </div>
    <asp:TreeView ID="tvMenuDescriptions" runat="server" Visible="false">
    </asp:TreeView>
</asp:Content>
