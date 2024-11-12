class Employee {
  final int id;
  final String name;
  final String position;
  final String department;
  final double salary;
  final String phoneNumber;
  final String email;
  final DateTime startDate;
  final String? photoUrl;
  bool isSalaryPaid;

  Employee({
    required this.id,
    required this.name,
    required this.position,
    required this.department,
    required this.salary,
    required this.phoneNumber,
    required this.email,
    required this.startDate,
    this.photoUrl,
    this.isSalaryPaid = false,
  });
}
