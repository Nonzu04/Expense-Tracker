using System;
using System.Text;

namespace Expense_Tracker
{
    public partial class AIChat : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                litChatHistory.Text += FormatBotMessage(
                    "Hello! I am your AI Financial Advisor.<br/><br/>" +
                    "You can ask me about:<br/>" +
                    "• Saving money<br/>" +
                    "• Budget planning<br/>" +
                    "• Reducing expenses<br/>" +
                    "• Investment ideas"
                );
            }
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            string userMessage = txtMessage.Text.Trim().ToLower();

            if (string.IsNullOrEmpty(userMessage))
                return;

            litChatHistory.Text += FormatUserMessage(txtMessage.Text);

            string response = GenerateResponse(userMessage);

            litChatHistory.Text += FormatBotMessage(response);

            txtMessage.Text = "";
        }

        private string GenerateResponse(string message)
        {
            if (message.Contains("save"))
            {
                return "Try the 50/30/20 rule: 50% Needs, 30% Wants, 20% Savings.";
            }
            else if (message.Contains("budget"))
            {
                return "Create a monthly budget and track expenses weekly. Set realistic limits.";
            }
            else if (message.Contains("reduce"))
            {
                return "Review subscriptions, dining expenses, and impulse purchases. Small cuts add up!";
            }
            else if (message.Contains("invest"))
            {
                return "Consider low-risk investments like index funds or fixed deposits to grow savings.";
            }
            else
            {
                return "I recommend reviewing your expense summary to identify high spending categories.";
            }
        }

        private string FormatUserMessage(string message)
        {
            return $"<div style='text-align:right; margin-bottom:10px;'>" +
                   $"<span style='background:white; color:black; padding:8px; border-radius:10px;'>" +
                   $"{message}</span></div>";
        }

        private string FormatBotMessage(string message)
        {
            return $"<div style='margin-bottom:10px;'>" +
                   $"<span style='background:#6a0dad; color:white; padding:8px; border-radius:10px; display:inline-block;'>" +
                   $"{message}</span></div>";
        }
    }
}