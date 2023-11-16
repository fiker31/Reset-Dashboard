using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.IO;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using BLL.Framework;
using BLL;
using DAL;
using System.Collections.Generic;
using DevExpress.Web;
using DAL.Framework;
public partial class _Profile : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            AllSalers.DataBind();
            SetUserInfo();
        }
    }
    public void SetUserInfo()
    {
        string UserAccountName = Session["LoginId"].ToString();
        EntUserAccount entUserAccount = new UserAccountData().SelectUserByUserAccountName(UserAccountName);
        txtFirstName.Text = entUserAccount.FirstName;
        txtLastName.Text = entUserAccount.LastName;
        txtUsername.Text = entUserAccount.UserAccountName;
        txtPhone.Text = entUserAccount.Phone;
        txtShortCode.Text = entUserAccount.Shortcode;
        txtUn.InnerText = "@" + entUserAccount.UserAccountName;
        txtFullName.InnerText = entUserAccount.FirstName + " " + entUserAccount.LastName;
        txtSc.InnerText = entUserAccount.Shortcode;
        txtPh.InnerText = entUserAccount.Phone;
    }
    public override string MenuItemName()
    {
        return "Home";
    }
    public override string[] CapabilityNames()
    {
        return new string[] { "Home" };
    }
    protected void Page_Init(object sender, EventArgs e)
    {
        IgnoreCapabilityCheck = true;
        dxgvUserDataBind();
    }
    protected void detailGrid_DataSelect(object sender, EventArgs e)
    {
        Session["ProID"] = (sender as ASPxGridView).GetMasterRowKeyValue();
    }
    public void dxgvUserDataBind()
    {
        string sc = Session["PhoneNumber"].ToString();
        DBDataContext db = new DBDataContext();
        List<CustomerRegistration> CustomerRegistrations = db.CustomerRegistrations.Where(t => t.PhoneNumber == sc).ToList();
        AllSalers.KeyFieldName = "CustomerRegistratinID";
        AllSalers.DataSource = CustomerRegistrations;
        AllSalers.DataBind();
    }
}
