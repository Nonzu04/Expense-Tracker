<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Register.aspx.cs"
    Inherits="Expense_Tracker.Account.Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">

                <div class="card shadow-lg border-0 login-card">
                    <div class="card-body p-4">

                        <h3 class="text-center mb-4 text-white">Create Account</h3>

                        <asp:ValidationSummary runat="server"
                            CssClass="alert alert-danger"
                            DisplayMode="BulletList" />

                        <asp:Literal runat="server" ID="ErrorMessage" />

                        <!-- Email -->
                        <div class="mb-3">
                            <asp:Label runat="server"
                                AssociatedControlID="Email"
                                CssClass="form-label text-white">
                                Email
                            </asp:Label>

                            <asp:TextBox runat="server"
                                ID="Email"
                                CssClass="form-control"
                                TextMode="Email" />

                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="Email"
                                CssClass="text-danger"
                                ErrorMessage="Email is required." />

                            <asp:RegularExpressionValidator runat="server"
                                ControlToValidate="Email"
                                CssClass="text-danger"
                                ValidationExpression="^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$"
                                ErrorMessage="Enter a valid email address." />
                        </div>

                        <!-- Password -->
                        <div class="mb-3">
                            <asp:Label runat="server"
                                AssociatedControlID="Password"
                                CssClass="form-label text-white">
                                Password
                            </asp:Label>

                            <asp:TextBox runat="server"
                                ID="Password"
                                TextMode="Password"
                                CssClass="form-control" />

                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="Password"
                                CssClass="text-danger"
                                ErrorMessage="Password is required." />

                            <!-- Strong password validation -->
                            <asp:RegularExpressionValidator runat="server"
                                ControlToValidate="Password"
                                CssClass="text-danger"
                                ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$"
                                ErrorMessage="Password must be at least 6 characters and include uppercase, lowercase and a number." />
                        </div>

                        <!-- Confirm Password -->
                        <div class="mb-3">
                            <asp:Label runat="server"
                                AssociatedControlID="ConfirmPassword"
                                CssClass="form-label text-white">
                                Confirm Password
                            </asp:Label>

                            <asp:TextBox runat="server"
                                ID="ConfirmPassword"
                                TextMode="Password"
                                CssClass="form-control" />

                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="ConfirmPassword"
                                CssClass="text-danger"
                                ErrorMessage="Please confirm your password." />

                            <asp:CompareValidator runat="server"
                                ControlToCompare="Password"
                                ControlToValidate="ConfirmPassword"
                                CssClass="text-danger"
                                ErrorMessage="Passwords do not match." />
                        </div>

                        <!-- Register Button -->
                        <div class="d-grid">
                            <asp:Button runat="server"
                                OnClick="CreateUser_Click"
                                Text="Register"
                                CssClass="btn btn-purple btn-lg" />
                        </div>

                        <hr class="bg-light" />

                        <div class="text-center">
                            <a href="Login" class="text-white">
                                Already have an account? Login
                            </a>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>

</asp:Content>