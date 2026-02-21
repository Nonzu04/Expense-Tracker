using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using Expense_Tracker.Models;

namespace Expense_Tracker.Account
{
    public partial class Register : Page
    {
        protected void CreateUser_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                var signInManager = Context.GetOwinContext().Get<ApplicationSignInManager>();

                var user = new ApplicationUser()
                {
                    UserName = Email.Text.Trim(),
                    Email = Email.Text.Trim()
                };

                IdentityResult result = manager.Create(user, Password.Text);

                if (result.Succeeded)
                {
                    signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                    IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                }
                else
                {
                    ErrorMessage.Text = "<div class='alert alert-danger'>" +
                                        result.Errors.FirstOrDefault() +
                                        "</div>";
                }
            }
            catch (Exception)
            {
                ErrorMessage.Text = "<div class='alert alert-danger'>An unexpected error occurred. Please try again.</div>";
            }
        }
    }
}