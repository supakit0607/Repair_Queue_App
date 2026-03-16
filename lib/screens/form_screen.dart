import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/repair_model.dart';
import '../providers/repair_provider.dart';

class FormScreen extends StatefulWidget {
  final RepairItem? item;

  const FormScreen({super.key, this.item});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _jobController;
  late TextEditingController _customerController;
  late TextEditingController _priceController;

  String _selectedType = 'งานซ่อมทั่วไป';
  String _selectedStatus = 'รอดำเนินการ';

  @override
  void initState() {
    super.initState();
    _jobController = TextEditingController(text: widget.item?.jobName ?? '');
    _customerController = TextEditingController(
      text: widget.item?.customerName ?? '',
    );
    _priceController = TextEditingController(
      text: widget.item != null ? widget.item!.price.toString() : '',
    );

    if (widget.item != null) {
      _selectedType = widget.item!.type;
      _selectedStatus = widget.item!.status;
    }
  }

  @override
  void dispose() {
    _jobController.dispose();
    _customerController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<RepairProvider>(context, listen: false);

      // แก้ไขตรงนี้: ลบบรรทัด carModel ออกตามที่ตกลงกันไว้
      final repairData = RepairItem(
        id: widget.item?.id,
        jobName: _jobController.text,
        customerName: _customerController.text,
        type: _selectedType,
        date: widget.item?.date ?? DateTime.now(),
        status: _selectedStatus,
        price: double.parse(_priceController.text),
      );

      if (widget.item == null) {
        provider.addRepair(repairData);
      } else {
        provider.updateRepair(repairData);
      }

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('บันทึกข้อมูลเรียบร้อยแล้ว')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item == null ? 'เพิ่มคิวงานซ่อม' : 'แก้ไขข้อมูลงานซ่อม',
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _jobController,
                decoration: const InputDecoration(
                  labelText: 'ชื่องานซ่อม',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.build),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'กรุณากรอกชื่องาน' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _customerController,
                decoration: const InputDecoration(
                  labelText: 'ชื่อลูกค้า / ผู้แจ้ง',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'กรุณากรอกชื่อลูกค้า' : null,
              ),
              const SizedBox(height: 15),
              // ลบ TextFormField ของรุ่นรถยนต์ออกไปแล้ว
              DropdownButtonFormField(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'ประเภทงาน',
                  border: OutlineInputBorder(),
                ),
                items: ['งานซ่อมทั่วไป', 'งานด่วน', 'เคลมประกัน']
                    .map(
                      (label) =>
                          DropdownMenuItem(value: label, child: Text(label)),
                    )
                    .toList(),
                onChanged: (value) =>
                    setState(() => _selectedType = value.toString()),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField(
                value: _selectedStatus,
                decoration: const InputDecoration(
                  labelText: 'สถานะงาน',
                  border: OutlineInputBorder(),
                ),
                items: ['รอดำเนินการ', 'กำลังซ่อม', 'เสร็จแล้ว']
                    .map(
                      (label) =>
                          DropdownMenuItem(value: label, child: Text(label)),
                    )
                    .toList(),
                onChanged: (value) =>
                    setState(() => _selectedStatus = value.toString()),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'ค่าใช้จ่ายประมาณการ (บาท)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.money),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'กรุณากรอกราคา';
                  if (double.tryParse(value) == null)
                    return 'กรุณากรอกเป็นตัวเลข';
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveForm,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'บันทึกข้อมูล',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
