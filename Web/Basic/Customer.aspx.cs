using BLL;
using BLL.Framework;
using System;
using System.Linq;
using System.Web.UI.WebControls;
public partial class Basic_Customers : BaseEditPage<CustomerRegistrationBO>
{
    private const string VS_IE = "Customers";
    private const string VS_MODE = "Entry Mode";
    private const string VS_CONTROL = "Control Collections";
    protected void Page_Load(object sender, EventArgs e)
    {
		//informationpanel.Visible = false;

		Master.NewButton_Click += new CreditEditPage.ButtonClickedHandler(Master_NewButton_Click);
        Master.EditButton_Click += new CreditEditPage.ButtonClickedHandler(Master_EditButton_Click);
        Master.SaveButton_Click += new CreditEditPage.ButtonClickedHandler(Master_SaveButton_Click);
        Master.CancelButton_Click += new CreditEditPage.ButtonClickedHandler(Master_CancelButton_Click);
        Master.DeleteButton_Click += new CreditEditPage.ButtonClickedHandler(Master_DeleteButton_Click);
        Master.FindButton_Click += new CreditEditPage.ButtonClickedHandler(Master_FindButton_Click);
        if (!IsPostBack)
        {
            MakeFormReadOnly(CapabilityNames().FirstOrDefault(), this.Controls);
        }
    }
    void Master_NewButton_Click(object sender, EventArgs e)
    {
        //ViewState[VS_MODE] = 'N';
      //  Master.EnableButtons(false, false, true, true, false, false);
        //Enable & Clear controls
        // MakeFormEditable(CapabilityNames().FirstOrDefault(), this.Controls);
       // ClearForm(this.Controls);
    }
    void Master_EditButton_Click(object sender, EventArgs e)
    {
        Guid id = ((CustomerRegistrationBO)ViewState[VS_IE]).CustomerRegistrationID;
        if (((CustomerRegistrationBO)ViewState[VS_IE]).CustomerRegistrationID != Guid.Empty)
        {
            ViewState[VS_MODE] = 'U';
            Master.EnableButtons(false, false, true, true, false, false);
            //Enable Controls
            MakeFormEditable(CapabilityNames().FirstOrDefault(), this.Controls);
        }
        else
        {
            Master.ValidationErrors.Add("Record is not selected.");
        }
    }
    void Master_SaveButton_Click(object sender, EventArgs e)
    {
        EntValidationErrors validationErrors = new EntValidationErrors();
		//Validate the Input Date and Number Data types
		CustomerRegistrationBO td;
        if ((char)ViewState[VS_MODE] == 'N')
        {
            td = new CustomerRegistrationBO();
            td.DBAction = BaseEO.DBActionEnum.Insert;
        }
        else
        {
            td = (CustomerRegistrationBO)ViewState[VS_IE];
            td.DBAction = BaseEO.DBActionEnum.Update;
        }
        LoadObjectFromScreen(td);
        if (!td.Save(ref validationErrors, Convert.ToString(Session["LoginId"])))
        {
            Master.ValidationErrors = validationErrors;
        }
        else
        {
            ResetButtons();
            //Refresh the Viewstate with current record 
            td.Load(td.CustomerRegistrationID.ToString());
            LoadScreenFromObject(td);
            //DisableControls
        }
    }
    void Master_CancelButton_Click(object sender, EventArgs e)
    {
        LoadScreenFromObject((CustomerRegistrationBO)ViewState[VS_IE]);
        ResetButtons();
    }
    void Master_DeleteButton_Click(object sender, EventArgs e)
    {
        if (((CustomerRegistrationBO)ViewState[VS_IE]).CustomerRegistrationID.ToString().Trim().Length > 0)
        {
            EntValidationErrors validationErrors = new EntValidationErrors();
            CustomerRegistrationBO td = (CustomerRegistrationBO)ViewState[VS_IE];
            td.DBAction = BaseEO.DBActionEnum.Delete;
            if (!td.Delete(ref validationErrors, Convert.ToString(Session["LoginId"])))
            {
                Master.ValidationErrors = validationErrors;
            }
            else
            {
                //Clear Controls
                ClearForm(this.Controls);
                ViewState[VS_IE] = new CustomerRegistrationBO();
            }
        }
        else
        {
            Master.ValidationErrors.Add("Record is not selected.");
        }
    }
    void Master_FindButton_Click(object sender, EventArgs e)
    {
		//informationpanel.Visible = true;

		GoToSearchPage();

	}
    #region overrides
    protected override void LoadObjectFromScreen(CustomerRegistrationBO baseEO)
    {
        //Check the controls and ammend accordingly
        baseEO.Status = ddlStatus.SelectedValue;
    }
    protected override void LoadScreenFromObject(CustomerRegistrationBO baseEO)
    {
        //Check the controls and ammend accordingly
        ddlStatus.SelectedValue = baseEO.Status;
        txtPhoneNumber.Text = baseEO.PhoneNumber;
		txtFullName.Text = baseEO.FullName;
	//	informationpanel.Visible = true;


		//Put the object in the view state so it can be attached back to the data context.
		ViewState[VS_IE] = baseEO;
    }
    protected override void LoadControls()
    {
        ddlStatus.Items.Insert(0, new ListItem("--Select Status--", "0"));
        ddlStatus.Items.Insert(1, new ListItem("Active", "Active"));
        ddlStatus.Items.Insert(2, new ListItem("InActive", "InActive"));
        ddlStatus.Items.Insert(3, new ListItem("Pending", "Pending"));

	}
    protected override void GoToSearchPage()
    {
        Session[GymConst.SS_ID] = ((CustomerRegistrationBO)ViewState[VS_IE]).CustomerRegistrationID.ToString();
        Response.Redirect("SetUpSearch.aspx" + EncryptQueryString("page=Customer.aspx"));
    }
    protected override void ResetButtons() 
    {
        Master.EnableButtons(true, true, false, false, true, true);
        MakeFormReadOnly(CapabilityNames().FirstOrDefault(), this.Controls);
    }
    public override string MenuItemName()
    {
        return "Customers";
    }
    public override string[] CapabilityNames()
    {
        return new string[] { "Customers" };
    }
    #endregion overrides
}
