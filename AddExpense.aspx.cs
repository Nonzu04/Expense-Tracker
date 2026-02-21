using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using Microsoft.AspNet.Identity;

namespace Expense_Tracker
{
    public partial class AddExpense : Page
    {
        private string connectionString =
            System.Configuration.ConfigurationManager
            .ConnectionStrings["DefaultConnection"]
            .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Account/Login");
            }

            if (!IsPostBack)
            {
                txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                LoadCategories();
                LoadRecentExpenses();
            }
        }

        private void LoadCategories()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT CategoryId, Name FROM Categories",
                    con);

                con.Open();
                ddlCategory.DataSource = cmd.ExecuteReader();
                ddlCategory.DataValueField = "CategoryId";
                ddlCategory.DataTextField = "Name";
                ddlCategory.DataBind();
            }
        }

        protected void btnAddExpense_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                string userId = Context.User.Identity.GetUserId();

                decimal amount;
                if (!decimal.TryParse(txtAmount.Text, out amount) || amount <= 0)
                {
                    lblMessage.Text = "<div class='alert alert-danger'>Amount must be greater than 0.</div>";
                    return;
                }

                DateTime expenseDate;
                if (!DateTime.TryParse(txtDate.Text, out expenseDate))
                {
                    lblMessage.Text = "<div class='alert alert-danger'>Invalid date.</div>";
                    return;
                }

                if (expenseDate > DateTime.Now)
                {
                    lblMessage.Text = "<div class='alert alert-danger'>Date cannot be in the future.</div>";
                    return;
                }

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand(
                        @"INSERT INTO Expenses 
                          (UserId, CategoryId, Amount, ExpenseDate, Notes)
                          VALUES (@UserId, @CategoryId, @Amount, @ExpenseDate, @Notes)",
                        con);

                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@CategoryId", ddlCategory.SelectedValue);
                    cmd.Parameters.AddWithValue("@Amount", amount);
                    cmd.Parameters.AddWithValue("@ExpenseDate", expenseDate);
                    cmd.Parameters.AddWithValue("@Notes", txtNotes.Text.Trim());

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMessage.Text = "<div class='alert alert-success'>Expense added successfully!</div>";

                txtAmount.Text = "";
                txtNotes.Text = "";
                txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");

                LoadRecentExpenses();
            }
            catch (SqlException)
            {
                lblMessage.Text = "<div class='alert alert-danger'>Database error occurred. Please try again.</div>";
            }
            catch (Exception)
            {
                lblMessage.Text = "<div class='alert alert-danger'>Unexpected error occurred.</div>";
            }
        }

        private void LoadRecentExpenses()
        {
            string userId = Context.User.Identity.GetUserId();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(@"
                    SELECT TOP 10 
                        e.ExpenseDate,
                        c.Name AS CategoryName,
                        e.Amount,
                        e.Notes
                    FROM Expenses e
                    INNER JOIN Categories c
                        ON e.CategoryId = c.CategoryId
                    WHERE e.UserId = @UserId
                    ORDER BY e.ExpenseDate DESC", con);

                cmd.Parameters.AddWithValue("@UserId", userId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvRecentExpenses.DataSource = dt;
                gvRecentExpenses.DataBind();
            }
        }
    }
}