using Microsoft.AspNet.Identity;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;

namespace Expense_Tracker
{
    public partial class ExpenseSummary : Page
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
                LoadChart("Weekly");
            }
        }

        protected void ddlPeriod_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadChart(ddlPeriod.SelectedValue);
        }

        private void LoadChart(string period)
        {
            try
            {
                string userId = Context.User.Identity.GetUserId();
                DataTable dt = new DataTable();

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string sql = "";

                    if (period == "Weekly")
                    {
                        sql = @"
                            SELECT 
                                'Week ' + CAST(DATEPART(WEEK, ExpenseDate) AS NVARCHAR(2)) 
                                + ' - ' + CAST(DATEPART(YEAR, ExpenseDate) AS NVARCHAR(4)) AS PeriodLabel,
                                SUM(Amount) AS Total
                            FROM Expenses
                            WHERE UserId = @UserId
                            GROUP BY DATEPART(WEEK, ExpenseDate), DATEPART(YEAR, ExpenseDate)
                            ORDER BY DATEPART(YEAR, ExpenseDate), DATEPART(WEEK, ExpenseDate)";
                    }
                    else
                    {
                        sql = @"
                            SELECT 
                                DATENAME(MONTH, ExpenseDate) + ' ' 
                                + CAST(DATEPART(YEAR, ExpenseDate) AS NVARCHAR(4)) AS PeriodLabel,
                                SUM(Amount) AS Total
                            FROM Expenses
                            WHERE UserId = @UserId
                            GROUP BY DATENAME(MONTH, ExpenseDate),
                                     DATEPART(MONTH, ExpenseDate),
                                     DATEPART(YEAR, ExpenseDate)
                            ORDER BY DATEPART(YEAR, ExpenseDate),
                                     DATEPART(MONTH, ExpenseDate)";
                    }

                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }

                var series = chartExpenses.Series["Expenses"];
                series.Points.Clear();
                series.IsValueShownAsLabel = true;
                series.LabelFormat = "C";
                series.ToolTip = "#VALX: #VALY{C}";
                series.BorderWidth = 2;
                series.Color = System.Drawing.Color.FromArgb(102, 0, 153); // Dark purple

                if (dt.Rows.Count == 0)
                {
                    chartExpenses.Titles.Clear();
                    chartExpenses.Titles.Add("No expense data available.");
                    return;
                }

                foreach (DataRow row in dt.Rows)
                {
                    double total = 0;
                    double.TryParse(row["Total"].ToString(), out total);
                    series.Points.AddXY(row["PeriodLabel"].ToString(), total);
                }

                chartExpenses.ChartAreas[0].AxisY.LabelStyle.Format = "C";
                chartExpenses.ChartAreas[0].AxisX.Interval = 1;

                chartExpenses.Titles.Clear();
                chartExpenses.Titles.Add($"Expense Summary ({period})");
            }
            catch (Exception)
            {
                chartExpenses.Titles.Clear();
                chartExpenses.Titles.Add("An error occurred while loading the chart.");
            }
        }
    }
}