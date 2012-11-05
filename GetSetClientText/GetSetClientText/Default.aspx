<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GetSetClientText.Default" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v12.1, Version=12.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v12.1, Version=12.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function onTBKeyup(s,e){
            var txt = s.GetText();
            if (txt == '')
                lblGreeting.SetText('');
            else
                lblGreeting.SetText('Hello ' + txt);
        }
    </script>
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
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table><tr>
        <td>
            
            <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Your name:">
            </dx:ASPxLabel></td>
        <td>
            <dx:ASPxTextBox ID="txtYourName" runat="server" Width="170px">
                <ClientSideEvents KeyUp="onTBKeyup" />
            </dx:ASPxTextBox>
        </td></tr>
        <tr><td colspan="2">
            <dx:ASPxLabel ID="lblGreeting" runat="server" Text="" ClientInstanceName="lblGreeting">
            </dx:ASPxLabel>
        </td></tr>
        </table>

    </div>
    <div>
<%--    <asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" runat="Server">--%>
    <dx:ASPxDropDownEdit ID="DropDownEdit" runat="server" ClientInstanceName="DropDownEdit"
        Width="1000px" AllowUserInput="False" EnableAnimation="False">
        <DropDownWindowStyle>
            <Border BorderWidth="0px" />
        </DropDownWindowStyle>
        <DropDownWindowTemplate>
            <dx:ASPxGridView ID="GridView" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridView"
                Width="500px" DataSourceID="SqlDataSource1" KeyFieldName="DateFormatID" OnRowInserting="GridView_RowInserting"
                OnInitNewRow="GridView_InitNewRow" OnCustomJSProperties="GridView_CustomJSProperties"
                OnAfterPerformCallback="GridView_AfterPerformCallback">
                <SettingsBehavior ConfirmDelete="True" EnableRowHotTrack="True" AllowFocusedRow="True" />
                <Columns>
                    <dx:GridViewDataTextColumn FieldName="DateFormatID" VisibleIndex="0" Visible="False">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Format" VisibleIndex="0">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="1">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="CultureID" VisibleIndex="2">
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
<%--</asp:Content>--%>

    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DEV-LAPTOP-03_GalaxyV2 %>" 
        DeleteCommand="DELETE FROM [DateFormat] WHERE [DateFormatID] = @DateFormatID" 
        InsertCommand="INSERT INTO [DateFormat] ([Format], [Description], [CultureID], [IsShort]) VALUES (@Format, @Description, @CultureID, @IsShort)" 
        SelectCommand="SELECT [DateFormatID], [Format], [Description], [CultureID], [IsShort] FROM [DateFormat]" 
        UpdateCommand="UPDATE [DateFormat] SET [Format] = @Format, [Description] = @Description, [CultureID] = @CultureID, [IsShort] = @IsShort WHERE [DateFormatID] = @DateFormatID">
        <DeleteParameters>
            <asp:Parameter Name="DateFormatID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Format" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="CultureID" Type="Int32" />
            <asp:Parameter Name="IsShort" Type="Boolean" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Format" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="CultureID" Type="Int32" />
            <asp:Parameter Name="IsShort" Type="Boolean" />
            <asp:Parameter Name="DateFormatID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
