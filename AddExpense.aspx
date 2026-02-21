<%@ Page Title="Add Expense" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="AddExpense.aspx.cs"
    Inherits="Expense_Tracker.AddExpense" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-7">

                <div class="card shadow-lg border-0 login-card">
                    <div class="card-body p-4">

                        <h3 class="text-center mb-4 text-white">Add New Expense</h3>

                        <asp:ValidationSummary ID="ValidationSummary1"
                            runat="server"
                            CssClass="alert alert-danger"
                            DisplayMode="BulletList" />

                        <asp:Label ID="lblMessage" runat="server"></asp:Label>

                        <!-- Category -->
                        <div class="mb-3">
                            <label class="form-label text-white">Category</label>
                            <asp:DropDownList ID="ddlCategory"
                                runat="server"
                                CssClass="form-select" />
                        </div>

                        <!-- Amount -->
                        <div class="mb-3">
                            <label class="form-label text-white">Amount</label>

                            <asp:TextBox ID="txtAmount"
                                runat="server"
                                CssClass="form-control" />

                            <asp:RequiredFieldValidator ID="rfvAmount"
                                runat="server"
                                ControlToValidate="txtAmount"
                                ErrorMessage="Amount is required."
                                CssClass="text-danger" />

                            <asp:RegularExpressionValidator ID="revAmount"
                                runat="server"
                                ControlToValidate="txtAmount"
                                ValidationExpression="^\d+(\.\d{1,2})?$"
                                ErrorMessage="Enter a valid amount (e.g., 100 or 100.50)."
                                CssClass="text-danger" />
                        </div>

                        <!-- Date -->
                        <div class="mb-3">
                            <label class="form-label text-white">Date</label>

                            <asp:TextBox ID="txtDate"
                                runat="server"
                                CssClass="form-control"
                                TextMode="Date" />

                            <asp:RequiredFieldValidator ID="rfvDate"
                                runat="server"
                                ControlToValidate="txtDate"
                                ErrorMessage="Date is required."
                                CssClass="text-danger" />
                        </div>

                        <!-- Notes -->
                        <div class="mb-3">
                            <label class="form-label text-white">Notes</label>

                            <asp:TextBox ID="txtNotes"
                                runat="server"
                                CssClass="form-control"
                                TextMode="MultiLine"
                                Rows="3"
                                MaxLength="250" />
                        </div>

                        <div class="d-grid">
                            <asp:Button ID="btnAddExpense"
                                runat="server"
                                Text="Add Expense"
                                CssClass="btn btn-purple btn-lg"
                                OnClick="btnAddExpense_Click" />
                        </div>

                    </div>
                </div>

                <!-- Recent Expenses -->
                <div class="mt-5">
                    <h4 class="text-white">Recent Expenses</h4>
                    <asp:GridView ID="gvRecentExpenses"
                        runat="server"
                        CssClass="table table-dark table-striped"
                        AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="ExpenseDate"
                                HeaderText="Date"
                                DataFormatString="{0:yyyy-MM-dd}" />
                            <asp:BoundField DataField="CategoryName"
                                HeaderText="Category" />
                            <asp:BoundField DataField="Amount"
                                HeaderText="Amount"
                                DataFormatString="{0:C}" />
                            <asp:BoundField DataField="Notes"
                                HeaderText="Notes" />
                        </Columns>
                    </asp:GridView>
                </div>

            </div>
        </div>
    </div>

</asp:Content>