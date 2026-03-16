import 'package:flutter/material.dart';
import '../models/repair_model.dart';
import '../services/database_helper.dart';

class RepairProvider with ChangeNotifier {
  List<RepairItem> _items = [];
  List<RepairItem> get items => _items;

  Future<void> fetchRepairs() async {
    _items = await DatabaseHelper.instance.readAll();
    if (_items.isEmpty) {
      await _addMockData();
      _items = await DatabaseHelper.instance.readAll();
    }
    notifyListeners();
  }

  Future<void> _addMockData() async {
    for (int i = 1; i <= 10; i++) {
      await DatabaseHelper.instance.create(
        RepairItem(
          jobName: 'งานซ่อมที่ $i',
          customerName: 'ลูกค้าคนที่ $i',
          type: i % 2 == 0 ? 'งานด่วน' : 'งานซ่อมทั่วไป',
          date: DateTime.now(),
          status: i % 3 == 0
              ? 'เสร็จแล้ว'
              : (i % 3 == 1 ? 'กำลังซ่อม' : 'รอดำเนินการ'),
          price: 500.0 + (i * 100),
        ),
      );
    }
  }

  Future<void> addRepair(RepairItem item) async {
    await DatabaseHelper.instance.create(item);
    await fetchRepairs();
  }

  Future<void> updateRepair(RepairItem item) async {
    await DatabaseHelper.instance.update(item);
    await fetchRepairs();
  }

  Future<void> deleteRepair(int id) async {
    await DatabaseHelper.instance.delete(id);
    await fetchRepairs();
  }

  int get totalJobs => _items.length;
  int get pendingJobs => _items.where((i) => i.status == 'รอดำเนินการ').length;
  int get processingJobs => _items.where((i) => i.status == 'กำลังซ่อม').length;
  int get completedJobs => _items.where((i) => i.status == 'เสร็จแล้ว').length;
}
