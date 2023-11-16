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
public partial class _TodayTxn : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            TodayTxns.DataBind();
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
        string sc = Session["Shortcode"].ToString();
        DBDataContext db = new DBDataContext();
        List<MerchantAppTXN> merchantAppTXNs = db.MerchantAppTXNs.Where(t => DateTime.Compare(DateTime.Now, t.TransactionEndDate) <= 0 && t.Shortcode == sc).ToList();
        TodayTxns.KeyFieldName = "Id";
        TodayTxns.DataSource = merchantAppTXNs;
        TodayTxns.DataBind();
    }
}
