import 'package:flutter/material.dart';
import 'package:ri_medicare/models/loan_model.dart';

class LoanSummarySection extends StatelessWidget {
  final List<Loan> loans;
  final int tileIndex;
  final int expandedTileIndex;
  final void Function(int) onTileExpand;

  const LoanSummarySection(
      {Key? key,
        required this.loans,
        required this.tileIndex,
        required this.expandedTileIndex,
        required this.onTileExpand})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isExpanded = tileIndex == expandedTileIndex;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0x0A000000), // ~4% opacity black
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ExpansionTile(
              initiallyExpanded: isExpanded,
              onExpansionChanged: (val) {
                if (val) {
                  onTileExpand(tileIndex);
                } else {
                  onTileExpand(-1);
                }
              },
              tilePadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.account_balance_wallet_outlined,
                        color: Colors.deepPurple, size: 24),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Loan Summary',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Your active medical loans',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              children: [
                SizedBox(
                  height: 220,
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount: loans.length,
                      itemBuilder: (context, i) => LoanCard(loan: loans[i]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


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