import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/repair_model.dart';
import '../providers/repair_provider.dart';
import 'form_screen.dart';

class DetailScreen extends StatelessWidget {
  final RepairItem item;

  // แก้ไข Constructor ตรงนี้
  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // แก้จาก app_bar เป็น appBar
      appBar: AppBar(
        title: const Text('รายละเอียดงานซ่อม'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoRow(Icons.work, 'ชื่องาน:', item.jobName),
            _infoRow(Icons.person, 'ลูกค้า:', item.customerName),
            _infoRow(Icons.category, 'ประเภท:', item.type),
            _infoRow(
              Icons.calendar_today,
              'วันที่รับ:',
              item.date.toString().split(' ')[0],
            ),
            _infoRow(Icons.info, 'สถานะ:', item.status),
            _infoRow(Icons.money, 'ราคา:', '${item.price} บาท'),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.edit),
                    label: const Text('แก้ไข'),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormScreen(item: item),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    label: const Text(
                      'ลบรายการ',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () => _confirmDelete(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 28),
          const SizedBox(width: 15),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('ยืนยันการลบ?'),
        content: const Text('คุณต้องการลบข้อมูลคิวงานนี้ใช่หรือไม่?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('ยกเลิก'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<RepairProvider>(
                context,
                listen: false,
              ).deleteRepair(item.id!);
              Navigator.pop(ctx);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('ลบข้อมูลเรียบร้อยแล้ว')),
              );
            },
            child: const Text('ลบ', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
