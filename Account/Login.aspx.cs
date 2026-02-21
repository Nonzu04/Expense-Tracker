using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Expense_Tracker.Models;

namespace Expense_Tracker.Account
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RegisterHyperLink.NavigateUrl = "Register";

            var returnUrl = HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);

            if (!String.IsNullOrEmpty(returnUrl))
            {
                RegisterHyperLink.NavigateUrl += "?ReturnUrl=" + returnUrl;
            }
        }

        protected void LogIn(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                var signInManager = Context.GetOwinContext().Get<ApplicationSignInManager>();

                string email = Email.Text.Trim();
                string password = Password.Text;

                var user = manager.FindByEmail(email);

                if (user == null)
                {
                    FailureText.Text = "No account found with this email.";
                    ErrorMessage.Visible = true;
                    return;
                }

                if (!manager.CheckPassword(user, password))
                {
                    FailureText.Text = "Incorrect password.";
                    ErrorMessage.Visible = true;
                    return;
                }

                // Successful login
                signInManager.SignIn(user, isPersistent: RememberMe.Checked, rememberBrowser: false);

                IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
            }
            catch (Exception)
            {
                FailureText.Text = "An unexpected error occurred. Please try again.";
                ErrorMessage.Visible = true;
            }
        }
    }
}