class Appointment {
  final String date;
  final String time;
  final String hospital;
  final String doctor;
  final String department;
  final String type;
  final String status;

  Appointment({
    required this.date,
    required this.time,
    required this.hospital,
    required this.doctor,
    required this.department,
    required this.type,
    required this.status,
  });
}

class HospitalVisit {
  final String date;
  final String hospital;
  final String doctor;
  final String department;
  final double amount;

  HospitalVisit({
    required this.date,
    required this.hospital,
    required this.doctor,
    required this.department,
    required this.amount,
  });
}
