<%@ Page Language="C#" MasterPageFile="~/Credit.master" AutoEventWireup="true" CodeFile="TodayTxn.aspx.cs" Inherits="_TodayTxn" Title="Txn" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Today's Transactions</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row" style="overflow-x: auto">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xl-12">
            <dx:ASPxGridView ID="TodayTxns" runat="server" Width="100%" AutoGenerateColumns="False" EnableTheming="True" Theme="MaterialCompact">
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
                    <dx:GridViewDataTextColumn FieldName="Id" MinWidth="100" Visible="false" VisibleIndex="0"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Shortcode" Caption="Short Code" MinWidth="120" VisibleIndex="1"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="TransactionEndDate" Caption="Transaction Date" MinWidth="200" VisibleIndex="2">
                        <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy hh:mm ss tt">
                        </PropertiesDateEdit>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="SalersPhone" MinWidth="150" VisibleIndex="3"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Amount" MinWidth="100" VisibleIndex="4">
                        <PropertiesTextEdit DisplayFormatString="#,###" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Phone" Caption="Customer Phone" MinWidth="150" VisibleIndex="5"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="TransactionId" MinWidth="150" VisibleIndex="6"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Status" MinWidth="100" VisibleIndex="7"></dx:GridViewDataTextColumn>
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
                <Settings ShowFooter="true" />
                <TotalSummary>
                    <dx:ASPxSummaryItem FieldName="Phone" SummaryType="Count" />
                    <dx:ASPxSummaryItem FieldName="Amount" SummaryType="Sum" />
                </TotalSummary>
            </dx:ASPxGridView>
        </div>
    </div>
    <asp:TreeView ID="tvMenuDescriptions" runat="server" Visible="false">
    </asp:TreeView>
</asp:Content>
