import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:ri_medicare/models/emi_payments.dart';
import 'package:ri_medicare/my_loans/my_loans_controller.dart';

class MyLoansView extends GetView<MyLoansController> {
  const MyLoansView({Key? key}) : super(key: key);

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
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Your active medical loan',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Icon(Icons.description_outlined, color: Colors.deepPurple, size: 22),
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
      height: 100,
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
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          Text(
            amount,
            style: TextStyle(
              fontSize: 14,
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
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
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
            fontSize: 13,
            fontWeight: FontWeight.bold,
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
              padding: const EdgeInsets.symmetric(vertical: 12),
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
        border: Border.all(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon, size: 22,),
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
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildPaymentCards(),
        const SizedBox(height: 16),
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.deepPurple[50],
              borderRadius: BorderRadius.circular(28),
            ),
            child: TextButton(
              onPressed: () {},
              child: Text(
                'View Complete History',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentCards() {
    return Obx(() => ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.paymentHistory.length,
      itemBuilder: (context, index) {
        final payment = controller.paymentHistory[index];
        return Container(
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildPaymentCardHeader(payment),
              Divider(height: 1),
              _buildPaymentCardDetails(payment),
            ],
          ),
        );
      },
    ));
  }

  Widget _buildPaymentCardHeader(EMIPayment payment) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'EMI #${payment.emiNumber}',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Due Date',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                        fontWeight : FontWeight.bold,
                    ),
                  ),
                  Text(
                    payment.dueDate,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          _buildStatusBadge(payment.status),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'paid':
        backgroundColor = Colors.green[50]!;
        textColor = Colors.green;
        break;
      case 'pending':
        backgroundColor = Colors.orange[50]!;
        textColor = Colors.orange;
        break;
      default:
        backgroundColor = Colors.blue[50]!;
        textColor = Colors.blue;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPaymentCardDetails(EMIPayment payment) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildPaymentDetailRow(
            'Total Amount',
            '₹${payment.totalAmount.toStringAsFixed(0)}',
            Colors.deepPurple,
          ),
          SizedBox(height: 12),
          _buildPaymentDetailRow(
            'Principal',
            '₹${payment.principal.toStringAsFixed(0)}',
            Colors.black,
          ),
          SizedBox(height: 12),
          _buildPaymentDetailRow(
            'Interest',
            '₹${payment.interest.toStringAsFixed(0)}',
            Colors.black,
          ),
          if (payment.status.toLowerCase() == 'paid') ...[
            SizedBox(height: 12),
            _buildPaymentDetailRow(
              'Payment Date',
              payment.paymentDate,
              Colors.black,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentDetailRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
            fontWeight: FontWeight.bold
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,

          ),
        ),
      ],
    );
  }
}