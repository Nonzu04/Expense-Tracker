using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;

namespace Expense_Tracker
{
    public partial class Expenses : Page
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
                LoadExpenses();
            }
        }

        private void LoadExpenses()
        {
            string userId = Context.User.Identity.GetUserId();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(@"
                    SELECT e.ExpenseId,
                           e.ExpenseDate,
                           c.Name,
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

                gvExpenses.DataSource = dt;
                gvExpenses.DataBind();
            }
        }

        protected void gvExpenses_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvExpenses.EditIndex = e.NewEditIndex;
            LoadExpenses();
        }

        protected void gvExpenses_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvExpenses.EditIndex = -1;
            LoadExpenses();
        }

        protected void gvExpenses_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string userId = Context.User.Identity.GetUserId();
            int expenseId = Convert.ToInt32(gvExpenses.DataKeys[e.RowIndex].Value);

            GridViewRow row = gvExpenses.Rows[e.RowIndex];

            string amount = ((TextBox)row.Cells[2].Controls[0]).Text;
            string notes = ((TextBox)row.Cells[3].Controls[0]).Text;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(@"
                    UPDATE Expenses
                    SET Amount = @Amount,
                        Notes = @Notes
                    WHERE ExpenseId = @ExpenseId
                    AND UserId = @UserId", con);

                cmd.Parameters.AddWithValue("@Amount", amount);
                cmd.Parameters.AddWithValue("@Notes", notes);
                cmd.Parameters.AddWithValue("@ExpenseId", expenseId);
                cmd.Parameters.AddWithValue("@UserId", userId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            gvExpenses.EditIndex = -1;
            LoadExpenses();
        }

        protected void gvExpenses_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string userId = Context.User.Identity.GetUserId();
            int expenseId = Convert.ToInt32(gvExpenses.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(@"
                    DELETE FROM Expenses
                    WHERE ExpenseId = @ExpenseId
                    AND UserId = @UserId", con);

                cmd.Parameters.AddWithValue("@ExpenseId", expenseId);
                cmd.Parameters.AddWithValue("@UserId", userId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            LoadExpenses();
        }
    }
}