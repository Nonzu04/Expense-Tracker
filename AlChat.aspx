<%@ Page Title="AI Financial Advisor" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="AIChat.aspx.cs"
    Inherits="Expense_Tracker.AIChat" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-5">
        
        <h2 class="mb-4 text-center" style="color:#d8b4ff;">
            🤖 AI Financial Advisor
        </h2>

        <div class="card shadow-lg" style="background-color:#2e003e; border-radius:15px;">
            
            <!-- CHAT AREA -->
            <div class="card-body" style="height:400px; overflow-y:auto; color:white;" 
                 id="chatContainer" runat="server">

                <asp:Literal ID="litChatHistory" runat="server"></asp:Literal>

            </div>

            <!-- INPUT AREA -->
            <div class="card-footer" style="background-color:#1a001f;">
                <div class="input-group">
                    
                    <asp:TextBox ID="txtMessage" runat="server"
                        CssClass="form-control"
                        placeholder="Ask about saving, budgeting, reducing expenses..."
                        Style="background-color:white; color:black;" />

                    <asp:Button ID="btnSend" runat="server"
                        Text="Send"
                        CssClass="btn"
                        Style="background-color:#6a0dad; color:white;"
                        OnClick="btnSend_Click" />

                </div>
            </div>

        </div>

    </div>

</asp:Content>