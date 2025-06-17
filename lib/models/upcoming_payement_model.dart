class UpcomingPayment {
  final String dueDate;
  final String description;
  final double amount;
  final String status;

  UpcomingPayment({
    required this.dueDate,
    required this.description,
    required this.amount,
    required this.status,
  });
}