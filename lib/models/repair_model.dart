class RepairItem {
  final int? id;
  final String jobName;
  final String customerName;
  final String type;
  final DateTime date;
  final String status;
  final double price;

  RepairItem({
    this.id,
    required this.jobName,
    required this.customerName,
    required this.type,
    required this.date,
    required this.status,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jobName': jobName,
      'customerName': customerName,
      'type': type,
      'date': date.toIso8601String(),
      'status': status,
      'price': price,
    };
  }

  factory RepairItem.fromMap(Map<String, dynamic> map) {
    return RepairItem(
      id: map['id'],
      jobName: map['jobName'],
      customerName: map['customerName'],
      type: map['type'],
      date: DateTime.parse(map['date']),
      status: map['status'],
      price: (map['price'] as num).toDouble(),
    );
  }
}
