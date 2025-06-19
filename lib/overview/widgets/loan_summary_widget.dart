import 'package:flutter/material.dart';
import 'package:ri_medicare/models/loan_model.dart';

class LoanCard extends StatelessWidget {
  final Loan loan;
  const LoanCard({required this.loan});

  String get formattedAmount {
    if (loan.remainingBalance == null) return '₹0';
    return '₹${loan.remainingBalance!.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  String get formattedEmi {
    if (loan.monthlyPayment == null) return '₹0';
    return '₹${loan.monthlyPayment!.toStringAsFixed(0)}';
  }

  String get formattedNextDueDate {
    if (loan.nextEmiDate == null) return 'Invalid Date';
    try {
      final date = DateTime.parse(loan.nextEmiDate!);
      return '${date.day}/${date.month}/${date.year}';
    } catch (_) {
      return 'Invalid Date';
    }
  }

  Color get statusColor {
    switch (loan.status) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'draft':
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Loan ID and Status
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loan.applicationNumber,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                _buildLoanInfoRow(label: 'Remaining : ', value: formattedAmount),
                const SizedBox(height: 6),
                _buildLoanInfoRow(label: 'Monthly EMI : ', value: formattedEmi),
                const SizedBox(height: 6),
                _buildLoanInfoRow(label: 'Next Due : ', value: formattedNextDueDate),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              loan.status,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoanInfoRow({required String label, required String value}){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
