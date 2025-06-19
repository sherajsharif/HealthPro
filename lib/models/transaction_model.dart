class Transaction {
  final String id;
  final String userId;
  final double amount;
  final String type;
  final String description;
  final String status;
  final String? hospital;
  final DateTime date;


  Transaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    required this.description,
    required this.status,
    this.hospital,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['_id'] ?? '',
      userId: json['user'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      type: json['type'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? 'pending',
      hospital: json['hospital'],
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': userId,
      'amount': amount,
      'type': type,
      'description': description,
      'status': status,
      'hospital': hospital,
      'date': date.toIso8601String(),
    };
  }
}
