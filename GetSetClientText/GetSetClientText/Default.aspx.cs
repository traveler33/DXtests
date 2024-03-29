﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;
using System.Collections;

namespace GetSetClientText
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                //EmployeeSessionProvider.Restore();
            ASPxWebControl.RegisterBaseScript(Page);
        }

        protected void GridView_CustomJSProperties(object sender, ASPxGridViewClientJSPropertiesEventArgs e)
        {
            ASPxGridView grid = (ASPxGridView)DropDownEdit.FindControl("GridView");
            object[] employeeNames = new object[grid.VisibleRowCount];
            object[] keyValues = new object[grid.VisibleRowCount];
            for (int i = 0; i < grid.VisibleRowCount; i++)
            {
                employeeNames[i] = grid.GetRowValues(i, "Format") + " " + grid.GetRowValues(i, "Description");
                keyValues[i] = grid.GetRowValues(i, "DateFormatID");
            }
            e.Properties["cpEmployeeNames"] = employeeNames;
            e.Properties["cpKeyValues"] = keyValues;
        }

        protected void GridView_RowInserting(object sender, ASPxDataInsertingEventArgs e)
        {
            ASPxGridView grid = sender as ASPxGridView;
            //e.NewValues["ID"] = EmployeeSessionProvider.GenerateNewID();
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

    //public class EffectiveDt
    //{
    //    public static ArrayList al = new ArrayList();
    //    public void EffectiveDt()
    //    {
    //        ADate aDate1 = new ADate();
    //        aDate1.EffectiveDate = Convert.ToDateTime("2012-10-16");

    //        al.Add(aDate1);
    //        ADate aDate2 = new ADate();
    //        aDate2.EffectiveDate = Convert.ToDateTime("2011-12-26");
    //        aDate2.ExpiryDate = Convert.ToDateTime("2012-10-15");
    //        al.Add(aDate2);
    //        ADate aDate3 = new ADate();
    //        aDate3.EffectiveDate = Convert.ToDateTime("2010-2-23");
    //        aDate3.ExpiryDate = Convert.ToDateTime("2011-12-25");
    //        al.Add(aDate3);
    //    }
    //    public static ICollection Select()
    //    {
    //        return al;
    //    }

    //    public void Update()
    //    {
    //        int ii;
    //        ii = al.
    //    }
    //}

    //public class ADate
    //{
    //    private DateTime effectiveDate;
    //    public DateTime EffectiveDate
    //    {
    //        get { return effectiveDate; }
    //        set { effectiveDate = value; }
    //    }

    //    private DateTime expiryDate;
    //    public DateTime ExpiryDate
    //    {
    //        get { return expiryDate; }
    //        set { expiryDate = value; }
    //    }

    //}
}