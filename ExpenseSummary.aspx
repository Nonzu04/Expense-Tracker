<%@ Register Assembly="System.Web.DataVisualization" 
    Namespace="System.Web.UI.DataVisualization.Charting" 
    TagPrefix="asp" %>
<%@ Page Title="Expense Summary" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="ExpenseSummary.aspx.cs"
    Inherits="Expense_Tracker.ExpenseSummary" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <h2 class="mb-4">Expense Summary</h2>

        <asp:DropDownList ID="ddlPeriod" runat="server" AutoPostBack="true" CssClass="form-select mb-4" OnSelectedIndexChanged="ddlPeriod_SelectedIndexChanged">
            <asp:ListItem Text="Weekly" Value="Weekly" Selected="True"></asp:ListItem>
            <asp:ListItem Text="Monthly" Value="Monthly"></asp:ListItem>
        </asp:DropDownList>

        <asp:Chart ID="chartExpenses" runat="server" Width="600px" Height="400px">
            <Series>
                <asp:Series Name="Expenses" ChartType="Column" XValueMember="PeriodLabel" YValueMembers="Total" />
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">
                    <AxisX Interval="1" Title="Period" />
                    <AxisY Title="Total Amount" />
                </asp:ChartArea>
            </ChartAreas>
            <Legends>
                <asp:Legend Name="Legend1" />
            </Legends>
        </asp:Chart>
    </div>
</asp:Content>