import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/repair_provider.dart';
import 'screens/home_screen.dart';

void main() {
  // ตรวจสอบความเรียบร้อยของ Binding ก่อนรันแอป
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RepairProvider()..fetchRepairs()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // ปิดแถบ Debug สีแดงมุมขวา
      title: 'Repair Queue App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false, // ใช้ UI มาตรฐานตามโจทย์
      ),
      home: HomeScreen(),
    );
  }
}
