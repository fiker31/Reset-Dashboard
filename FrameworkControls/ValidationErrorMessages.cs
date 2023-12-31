﻿using BLL.Framework;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
namespace FrameworkControls
{
    [ToolboxData("<{0}:ValidationErrorMessages runat=server></{0}:ValidationErrorMessages>")]
    public class ValidationErrorMessages : WebControl
    {
        #region Constructor
        public ValidationErrorMessages()
        {
            ValidationErrors = new EntValidationErrors();
        }
        #endregion Constructor
        #region Properties
        [Bindable(false),
        Browsable(false)]
        public EntValidationErrors ValidationErrors { get; set; }
        #endregion Properties
        #region Methods
        /// <summary> 
        /// Render this control to the output parameter specified.
        /// </summary>
        /// <param name="output"> The HTML writer to write out to </param>
        protected override void RenderContents(HtmlTextWriter output)
        {
            //Show all the messages in the ENTValidationErrorsAL
            //Check if there are an items in the array list
            if (ValidationErrors.Count != 0)
            {
                //There are items so create a table with the list of messages.
                HtmlTable table = new HtmlTable();
                HtmlTableRow trHeader = new HtmlTableRow();
                HtmlTableCell tcHeader = new HtmlTableCell();
                tcHeader.InnerText = "Please review the following issues:";
                tcHeader.Attributes.Add("class", "validatioErrorMessageHeader");
                trHeader.Cells.Add(tcHeader);
                //table.Rows.Add(trHeader);
                HtmlGenericControl divAlert = new HtmlGenericControl("div");
                divAlert.Attributes["class"] = "callout callout-danger AlertMessage";
                foreach (EntValidationError ve in ValidationErrors)
                {
                    //HtmlGenericControl h5Alert = new HtmlGenericControl("h5");
                    //h5Alert.InnerText = "Please review the following issues!";
                    HtmlGenericControl alertMessage = new HtmlGenericControl("p");
                    alertMessage.Attributes["class"] = "validationErrorMessage";
                    alertMessage.InnerText = ve.ErrorMessage;
                    //divAlert.Controls.Add(h5Alert);
                    divAlert.Controls.Add(alertMessage);
                    HtmlTableRow tr = new HtmlTableRow();
                    HtmlTableCell tc = new HtmlTableCell();
                    //tc.InnerText = ve.ErrorMessage;
                    //tc.Attributes.Add("class", "validationErrorMessage AlertMessage  alert alert-danger");
                    //tr.Cells.Add(tc);
                    tc.Controls.Add(divAlert);
                    tr.Cells.Add(tc);
                    table.Rows.Add(tr);
                    tc = null;
                    tr = null;
                }
                table.RenderControl(output);
                tcHeader = null;
                trHeader = null;
                table = null;
            }
            else
            {
                //Write nothing.
                output.Write("");
            }
        }
        #endregion Methods
    }
}
