package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/paymentCallback")
public class PaymentCallbackServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String billCode = request.getParameter("billcode");
        String amount = request.getParameter("amount");
        String transactionId = request.getParameter("transaction_id");
        String paidEmail = request.getParameter("paid_by");

        // TODO: Lookup order by billcode and mark it as paid
        // Example: update payment_status = 'PAID' where bill_code = ?

        System.out.println("Toyyibpay callback received:");
        System.out.println("BillCode: " + billCode);
        System.out.println("Amount: " + amount);
        System.out.println("Transaction ID: " + transactionId);
        System.out.println("Payer Email: " + paidEmail);

        // Respond with 200 OK to Toyyibpay
        response.setStatus(HttpServletResponse.SC_OK);
    }
}
