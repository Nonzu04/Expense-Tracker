<%@ Page Title="My Expenses" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Expenses.aspx.cs"
    Inherits="Expense_Tracker.Expenses" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-5">
        <h2 class="mb-4 text-white">My Expenses</h2>

        <asp:GridView ID="gvExpenses" runat="server"
            AutoGenerateColumns="False"
            CssClass="table table-bordered expense-grid"
            HeaderStyle-CssClass="expense-grid-header"
            RowStyle-CssClass="expense-grid-row"
            AlternatingRowStyle-CssClass="expense-grid-alt"
            OnRowEditing="gvExpenses_RowEditing"
                        OnRowUpdating="gvExpenses_RowUpdating"
            OnRowCancelingEdit="gvExpenses_RowCancelingEdit"
            OnRowDeleting="gvExpenses_RowDeleting"
            DataKeyNames="ExpenseId">

            <Columns>

                <asp:BoundField DataField="ExpenseDate"
                    HeaderText="Date"
                    DataFormatString="{0:yyyy-MM-dd}" 
                    ItemStyle-CssClass="text-white" />

                <asp:BoundField DataField="Name"
                    HeaderText="Category"
                    ReadOnly="True"
                    ItemStyle-CssClass="text-white" />

                <asp:BoundField DataField="Amount"
                    HeaderText="Amount"
                    ItemStyle-CssClass="text-white" />

                <asp:BoundField DataField="Notes"
                    HeaderText="Notes"
                    ItemStyle-CssClass="text-white" />

                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-sm btn-primary me-1"></asp:LinkButton>
                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-sm btn-danger"
                            OnClientClick="return confirm('Are you sure you want to delete this expense?');"></asp:LinkButton>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" Text="Update" CssClass="btn btn-sm btn-success me-1"></asp:LinkButton>
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-sm btn-secondary"></asp:LinkButton>
                    </EditItemTemplate>
                </asp:TemplateField>

            </Columns>

        </asp:GridView>
    </div>

</asp:Content>