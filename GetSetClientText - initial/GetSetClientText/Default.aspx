<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GetSetClientText.Default" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v12.1, Version=12.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
                <ClientSideEvents KeyUp="function(s, e) {
  var txt = s.GetText();
  if(txt == '')
    lblGreeting.SetText('');
  else
	lblGreeting.SetText('Hello ' + txt);
}" />
            </dx:ASPxTextBox>
        </td></tr>
        <tr><td colspan="2">
            <dx:ASPxLabel ID="lblGreeting" runat="server" Text="" ClientInstanceName="lblGreeting">
            </dx:ASPxLabel>
        </td></tr>
        </table>

    </div>
    </form>
</body>
</html>
