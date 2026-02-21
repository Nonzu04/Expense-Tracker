<%@ Page Title="Log in" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Login.aspx.cs"
    Inherits="Expense_Tracker.Account.Login" Async="true" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx"
    TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">

                <div class="card shadow-lg border-0 login-card">
                    <div class="card-body p-4">

                        <h3 class="text-center mb-4 text-white">Login to Your Account</h3>

                        <!-- Validation Summary -->
                        <asp:ValidationSummary runat="server"
                            CssClass="alert alert-danger"
                            DisplayMode="BulletList" />

                        <!-- Error Placeholder -->
                        <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                            <div class="alert alert-danger">
                                <asp:Literal runat="server" ID="FailureText" />
                            </div>
                        </asp:PlaceHolder>

                        <!-- Email -->
                        <div class="mb-3">
                            <asp:Label runat="server" AssociatedControlID="Email"
                                CssClass="form-label text-white">Email</asp:Label>

                            <asp:TextBox runat="server" ID="Email"
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
                            <asp:Label runat="server" AssociatedControlID="Password"
                                CssClass="form-label text-white">Password</asp:Label>

                            <asp:TextBox runat="server" ID="Password"
                                TextMode="Password"
                                CssClass="form-control" />

                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="Password"
                                CssClass="text-danger"
                                ErrorMessage="Password is required." />
                        </div>

                        <!-- Remember Me -->
                        <div class="mb-3 form-check">
                            <asp:CheckBox runat="server" ID="RememberMe"
                                CssClass="form-check-input" />
                            <asp:Label runat="server"
                                AssociatedControlID="RememberMe"
                                CssClass="form-check-label text-white">
                                Remember me
                            </asp:Label>
                        </div>

                        <!-- Button -->
                        <div class="d-grid">
                            <asp:Button runat="server"
                                OnClick="LogIn"
                                Text="Log In"
                                CssClass="btn btn-purple btn-lg" />
                        </div>

                        <hr class="bg-light" />

                        <div class="text-center">
                            <asp:HyperLink runat="server"
                                ID="RegisterHyperLink"
                                CssClass="text-white">
                                Register as a new user
                            </asp:HyperLink>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>

</asp:Content>