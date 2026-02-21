<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" 
    AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Expense_Tracker._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="container mt-5 home-container">

        <!-- Hero Section -->
        <section class="home-panel text-center p-5 rounded" style="background-color: rgba(46,0,62,0.85);">
            
            <h1 class="display-4 text-white">Welcome to Expense Tracker</h1>
            <p class="lead text-white">
                Easily track your daily expenses, categorize them, and manage your budget.
            </p>

            <asp:LoginView runat="server">
                <AnonymousTemplate>
                    <asp:HyperLink runat="server" CssClass="btn btn-purple btn-lg mt-3" NavigateUrl="~/Account/Login">
                        Get Started
                    </asp:HyperLink>
                </AnonymousTemplate>
                <LoggedInTemplate>
                    <asp:HyperLink runat="server" CssClass="btn btn-purple btn-lg mt-3" NavigateUrl="~/AddExpense.aspx">
                        Add Expense
                    </asp:HyperLink>
                </LoggedInTemplate>
            </asp:LoginView>

        </section>

        <!-- Features Section -->
        <div class="row text-center mt-5">

            <div class="col-md-4">
                <div class="home-card p-3">
                    <h3 class="text-white">Track Expenses</h3>
                    <p class="text-white">
                        Record every expense quickly with categories, notes, and dates.
                    </p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="home-card p-3">
                    <h3 class="text-white">Manage Budget</h3>
                    <p class="text-white">
                        View your spending and analyze trends to stay in control.
                    </p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="home-card p-3">
                    <h3 class="text-white">Secure & Personal</h3>
                    <p class="text-white">
                        Your data is tied to your account, safely stored, and private.
                    </p>
                </div>
            </div>

        </div>

    </main>

</asp:Content>