<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DropDownEdit.aspx.cs" Inherits="npDropDownEdit.clsDropDownEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" runat="Server">
    <script type="text/javascript" language="javascript">
    // <![CDATA[
        var GridViewAdjustRequired = true;
        function DropDownHandler(s, e) {
            SynchronizeFocusedRow();
            if (GridViewAdjustRequired)
                GridView.AdjustControl();
            GridViewAdjustRequired = false;
        }
        function GridViewInitHandler(s, e) {
            SynchronizeFocusedRow();
        }
        function RowClickHandler(s, e) {
            DropDownEdit.SetKeyValue(GridView.cpKeyValues[e.visibleIndex]);
            DropDownEdit.SetText(GridView.cpEmployeeNames[e.visibleIndex]);
            DropDownEdit.HideDropDown();
        }
        function EndCallbackHandler(s, e) {
            DropDownEdit.AdjustDropDownWindow();
            UpdateEditBox();
        }
        function SynchronizeFocusedRow() {
            var keyValue = DropDownEdit.GetKeyValue();
            var index = -1;
            if (keyValue != null)
                index = ASPxClientUtils.ArrayIndexOf(GridView.cpKeyValues, keyValue);
            GridView.SetFocusedRowIndex(index);
            GridView.MakeRowVisible(index);
            UpdateEditBox();
        }
        function UpdateEditBox() {
            var rowIndex = GridView.GetFocusedRowIndex();
            var focusedEmployeeName = rowIndex == -1 ? "" : GridView.cpEmployeeNames[rowIndex];
            var employeeNameInEditBox = DropDownEdit.GetText();
            if (employeeNameInEditBox != focusedEmployeeName)
                DropDownEdit.SetText(focusedEmployeeName);
        }
    // ]]> 
    </script>
    <dx:ASPxDropDownEdit ID="DropDownEdit" runat="server" ClientInstanceName="DropDownEdit"
        Width="170px" AllowUserInput="False" EnableAnimation="False">
        <DropDownWindowStyle>
            <Border BorderWidth="0px" />
        </DropDownWindowStyle>
        <DropDownWindowTemplate>
            <dx:ASPxGridView ID="GridView" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridView"
                Width="500px" DataSourceID="ObjectDataSource1" KeyFieldName="ID" OnRowInserting="GridView_RowInserting"
                OnInitNewRow="GridView_InitNewRow" OnCustomJSProperties="GridView_CustomJSProperties"
                OnAfterPerformCallback="GridView_AfterPerformCallback">
                <SettingsBehavior ConfirmDelete="True" EnableRowHotTrack="True" AllowFocusedRow="True" />
                <Columns>
                    <dx:GridViewDataTextColumn FieldName="ID" VisibleIndex="0" Visible="False">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="FirstName" VisibleIndex="0">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="LastName" VisibleIndex="1">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="HireDate" VisibleIndex="2">
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewCommandColumn VisibleIndex="3">
                        <EditButton Visible="True">
                        </EditButton>
                        <NewButton Visible="True">
                        </NewButton>
                        <DeleteButton Visible="True">
                        </DeleteButton>
                        <CellStyle Wrap="False">
                        </CellStyle>
                    </dx:GridViewCommandColumn>
                </Columns>
                <ClientSideEvents Init="GridViewInitHandler" RowClick="RowClickHandler" EndCallback="EndCallbackHandler" />
                <SettingsPager Mode="ShowAllRecords">
                </SettingsPager>
                <Settings ShowVerticalScrollBar="True" />
            </dx:ASPxGridView>
        </DropDownWindowTemplate>
        <ClientSideEvents DropDown="DropDownHandler" />
    </dx:ASPxDropDownEdit>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DataObjectTypeName="EmployeeEntry"
        TypeName="EmployeeSessionProvider" SelectMethod="Select" DeleteMethod="Delete"
        InsertMethod="Insert" UpdateMethod="Update"></asp:ObjectDataSource>
</asp:Content>
    </div>
    </form>
</body>
</html>
