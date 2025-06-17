class Transaction {
  final String date;
  final String hospital;
  final String service;
  final double amount;
  final String status;

  Transaction({
    required this.date,
    required this.hospital,
    required this.service,
    required this.amount,
    required this.status,
  });
}
