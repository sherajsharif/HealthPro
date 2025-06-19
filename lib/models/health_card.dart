class HealthCard {
  final String id;
  final String cardNumber;
  final String userId;
  final String uhid;
  final double availableCredit;
  final double usedCredit;
  final String status;
  final String cardType;
  final double discountPercentage;
  final double requestedCreditLimit;
  final String medicalHistory;
  final double monthlyIncome;
  final String employmentStatus;
  final DateTime expiryDate;
  final DateTime issueDate;

  HealthCard({
    required this.id,
    required this.cardNumber,
    required this.userId,
    required this.uhid,
    required this.availableCredit,
    required this.usedCredit,
    required this.status,
    required this.cardType,
    required this.discountPercentage,
    required this.requestedCreditLimit,
    required this.medicalHistory,
    required this.monthlyIncome,
    required this.employmentStatus,
    required this.expiryDate,
    required this.issueDate,
  });

  factory HealthCard.fromJson(Map<String, dynamic> json) {
    return HealthCard(
      id: json['_id'] ?? '',
      cardNumber: json['cardNumber'] ?? '',
      userId: json['user'] ?? '',
      uhid: json['uhid'] ?? '',
      availableCredit: (json['availableCredit'] ?? 0).toDouble(),
      usedCredit: (json['usedCredit'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      cardType: json['cardType'] ?? '',
      discountPercentage: (json['discountPercentage'] ?? 0).toDouble(),
      requestedCreditLimit: (json['requestedCreditLimit'] ?? 0).toDouble(),
      medicalHistory: json['medicalHistory'] ?? '',
      monthlyIncome: (json['monthlyIncome'] ?? 0).toDouble(),
      employmentStatus: json['employmentStatus'] ?? '',
      expiryDate: DateTime.parse(json['expiryDate'] ?? DateTime.now().toIso8601String()),
      issueDate: DateTime.parse(json['issueDate'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'cardNumber': cardNumber,
      'user': userId,
      'uhid': uhid,
      'availableCredit': availableCredit,
      'usedCredit': usedCredit,
      'status': status,
      'cardType': cardType,
      'discountPercentage': discountPercentage,
      'requestedCreditLimit': requestedCreditLimit,
      'medicalHistory': medicalHistory,
      'monthlyIncome': monthlyIncome,
      'employmentStatus': employmentStatus,
      'expiryDate': expiryDate.toIso8601String(),
      'issueDate': issueDate.toIso8601String(),
    };
  }
}