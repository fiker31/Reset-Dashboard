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
public partial class _Fuel_2023 : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            FuelAppAllTxns.DataBind();
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
        FuelDbDataContext db = new FuelDbDataContext();
        List<TXN> fuelAppTXNs = db.TXNs.OrderByDescending(t => t.TransactionEndFuel).ToList();
        FuelAppAllTxns.KeyFieldName = "Id";
        FuelAppAllTxns.DataSource = fuelAppTXNs;
        FuelAppAllTxns.DataBind();
    }
}
