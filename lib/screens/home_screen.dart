import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/repair_provider.dart';
import 'form_screen.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // เรียกดึงข้อมูลจาก Database เมื่อหน้าจอเริ่มทำงาน
    Future.microtask(
      () => Provider.of<RepairProvider>(context, listen: false).fetchRepairs(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RepairProvider>(context);

    // กรองข้อมูลตามชื่อโครงการหรือชื่อลูกค้า
    final filteredItems = provider.items.where((item) {
      final query = _searchQuery.toLowerCase();
      return item.jobName.toLowerCase().contains(query) ||
          item.customerName.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('ระบบคิวงานซ่อม'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ค้นหาชื่อหรือลูกค้า...',
                prefixIcon: Icon(Icons.search),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildDashboard(provider),
          Expanded(
            child: filteredItems.isEmpty
                ? Center(child: Text('ไม่พบข้อมูลงานซ่อม'))
                : ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (ctx, i) {
                      final item = filteredItems[i];
                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        elevation: 2,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: _getStatusColor(item.status),
                            child: Icon(
                              Icons.build,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            item.jobName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "${item.customerName}\nสถานะ: ${item.status}",
                          ),
                          isThreeLine: true, // ปรับให้รองรับเนื้อหา 3 บรรทัด
                          trailing: Text(
                            "${item.price.toStringAsFixed(0)} บาท",
                            style: TextStyle(
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(item: item),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => FormScreen())),
      ),
    );
  }

  Widget _buildDashboard(RepairProvider provider) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border(bottom: BorderSide(color: Colors.blue.shade100)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem("ทั้งหมด", provider.totalJobs, Colors.blue),
          _statItem("กำลังซ่อม", provider.processingJobs, Colors.orange),
          _statItem("เสร็จแล้ว", provider.completedJobs, Colors.green),
        ],
      ),
    );
  }

  Widget _statItem(String label, int val, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
        ),
        Text(
          "$val",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'เสร็จแล้ว':
        return Colors.green;
      case 'กำลังซ่อม':
        return Colors.orange;
      case 'รอดำเนินการ':
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }
}
