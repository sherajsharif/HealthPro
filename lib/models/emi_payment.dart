class EMIPayment {
  final int emiNumber;
  final String dueDate;
  final double totalAmount;
  final double principal;
  final double interest;
  final bool isPaid;
  final String paymentDate;

  EMIPayment({
    required this.emiNumber,
    required this.dueDate,
    required this.totalAmount,
    required this.principal,
    required this.interest,
    required this.isPaid,
    required this.paymentDate,
  });
}
