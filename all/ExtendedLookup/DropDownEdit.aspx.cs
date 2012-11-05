using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;

namespace npDropDownEdit
{
    public partial class clsDropDownEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                EmployeeSessionProvider.Restore();
            ASPxWebControl.RegisterBaseScript(Page);
        }

        protected void GridView_CustomJSProperties(object sender, ASPxGridViewClientJSPropertiesEventArgs e)
        {
            ASPxGridView grid = (ASPxGridView)DropDownEdit.FindControl("GridView");
            object[] employeeNames = new object[grid.VisibleRowCount];
            object[] keyValues = new object[grid.VisibleRowCount];
            for (int i = 0; i < grid.VisibleRowCount; i++)
            {
                employeeNames[i] = grid.GetRowValues(i, "FirstName") + " " + grid.GetRowValues(i, "LastName");
                keyValues[i] = grid.GetRowValues(i, "ID");
            }
            e.Properties["cpEmployeeNames"] = employeeNames;
            e.Properties["cpKeyValues"] = keyValues;
        }

        protected void GridView_RowInserting(object sender, ASPxDataInsertingEventArgs e)
        {
            ASPxGridView grid = sender as ASPxGridView;
            e.NewValues["ID"] = EmployeeSessionProvider.GenerateNewID();
        }

        protected void GridView_AfterPerformCallback(object sender, ASPxGridViewAfterPerformCallbackEventArgs e)
        {
            SynchronizeFocusedRow();
        }

        protected void SynchronizeFocusedRow()
        {
            ASPxGridView grid = (ASPxGridView)DropDownEdit.FindControl("GridView");
            object lookupKeyValue = DropDownEdit.KeyValue;
            grid.FocusedRowIndex = grid.FindVisibleIndexByKeyValue(lookupKeyValue);
        }

        protected void GridView_InitNewRow(object sender, ASPxDataInitNewRowEventArgs e)
        {
            ASPxGridView grid = sender as ASPxGridView;
            grid.ScrollToVisibleIndexOnClient = 0;
        }

    }
}