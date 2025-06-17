class EMIPayment {
  final int emiNumber;
  final String dueDate;
  final double totalAmount;
  final double principal;
  final double interest;
  final String status;
  final String paymentDate;

  EMIPayment({
    required this.emiNumber,
    required this.dueDate,
    required this.totalAmount,
    required this.principal,
    required this.interest,
    required this.status,
    required this.paymentDate,
  });
}
