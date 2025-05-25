import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:ri_medicare/models/emi_payment.dart';
import 'package:ri_medicare/my_loans/my_loans_controller.dart';

class MyLoansView extends GetView<MyLoansController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildLoanAmounts(),
              const SizedBox(height: 20),
              _buildLoanDetails(),
              const SizedBox(height: 20),
              _buildLoanProgress(),
              const SizedBox(height: 20),
              _buildActionButtons(),
              const SizedBox(height: 30),
              _buildPaymentHistory(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Loan Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Your active medical loan',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
        Icon(Icons.description_outlined, color: Colors.deepPurple),
      ],
    );
  }

  Widget _buildLoanAmounts() {
    return Row(
      children: [
        Expanded(
          child: _buildAmountCard(
            'Total Loan Amount',
            '₹${controller.totalLoanAmount.value.toStringAsFixed(0)}',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildAmountCard(
            'Remaining Balance',
            '₹${controller.remainingBalance.value.toStringAsFixed(0)}',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildAmountCard(
            'Monthly EMI',
            '₹${controller.monthlyEMI.value.toStringAsFixed(0)}',
          ),
        ),
      ],
    );
  }

  Widget _buildAmountCard(String title, String amount) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoanDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildDetailRow('Loan ID', controller.loanId.value),
          _buildDetailRow('Interest Rate', '${controller.interestRate.value}%'),
          _buildDetailRow('Term', '${controller.loanTerm.value} months'),
          _buildDetailRow(
            'Next Payment Due',
            controller.nextPaymentDue.value,
            isHighlighted: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isHighlighted = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isHighlighted ? Colors.orange : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoanProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearPercentIndicator(
          lineHeight: 8.0,
          percent: controller.loanProgress.value / 100,
          backgroundColor: Colors.grey[200],
          progressColor: Colors.deepPurple,
          barRadius: const Radius.circular(4),
        ),
        const SizedBox(height: 8),
        Text(
          'You\'ve paid ${controller.loanProgress.value}% of your total loan amount',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('Pay EMI Now'),
          ),
        ),
        const SizedBox(width: 10),
        _buildOutlinedButton('Prepay Loan', Icons.payment),
        const SizedBox(width: 10),
        _buildOutlinedButton('Loan Statement', Icons.download),
        const SizedBox(width: 10),
        _buildOutlinedButton('Set Reminder', Icons.notifications),
      ],
    );
  }

  Widget _buildOutlinedButton(String label, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon),
        color: Colors.grey[700],
      ),
    );
  }

  Widget _buildPaymentHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EMI Payment History',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'View your past EMI payments',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildPaymentHistoryHeader(),
              ...controller.paymentHistory.map(_buildPaymentHistoryItem).toList(),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: TextButton(
            onPressed: () {},
            child: Text(
              'View Complete History',
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentHistoryHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text('EMI #', style: TextStyle(fontWeight: FontWeight.w500))),
          Expanded(flex: 2, child: Text('Due Date', style: TextStyle(fontWeight: FontWeight.w500))),
          Expanded(flex: 2, child: Text('Amount', style: TextStyle(fontWeight: FontWeight.w500))),
          Expanded(flex: 2, child: Text('Principal', style: TextStyle(fontWeight: FontWeight.w500))),
          Expanded(flex: 2, child: Text('Interest', style: TextStyle(fontWeight: FontWeight.w500))),
          Expanded(flex: 2, child: Text('Status', style: TextStyle(fontWeight: FontWeight.w500))),
          Expanded(flex: 2, child: Text('Payment Date', style: TextStyle(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  Widget _buildPaymentHistoryItem(EMIPayment payment) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(payment.emiNumber.toString())),
          Expanded(flex: 2, child: Text(payment.dueDate)),
          Expanded(flex: 2, child: Text('₹${payment.totalAmount.toStringAsFixed(0)}')),
          Expanded(flex: 2, child: Text('₹${payment.principal.toStringAsFixed(0)}')),
          Expanded(flex: 2, child: Text('₹${payment.interest.toStringAsFixed(0)}')),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Paid',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Expanded(flex: 2, child: Text(payment.paymentDate)),
        ],
      ),
    );
  }
}