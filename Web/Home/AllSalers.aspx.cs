using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using BLL.Framework;
using System.Collections.Generic;
using System.Web.UI.HtmlControls;
using System.Web.UI;
using DevExpress.Web;
using BLL;
using System.Web.UI.DataVisualization.Charting;
using DAL;
public partial class _AllSalers : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            AllSalers.DataBind();
        }
    }
    public override string MenuItemName()
    {
        return "Home";
    }
    public override string[] CapabilityNames()
    {
        throw new NotImplementedException();
    }
    protected void Page_Init(object sender, EventArgs e)
    {
        IgnoreCapabilityCheck = true;
        dxgvDataBind();
    }
    public void dxgvDataBind()
    {
        string sc = Session["PhoneNumber"].ToString();
        DBDataContext db = new DBDataContext();
        List<CustomerRegistration> CustomerRegistrations = db.CustomerRegistrations.Where(t => t.PhoneNumber == sc).ToList();
        AllSalers.KeyFieldName = "CustomerRegistrationID";
        AllSalers.DataSource = CustomerRegistrations;
        AllSalers.DataBind();
    }
}
