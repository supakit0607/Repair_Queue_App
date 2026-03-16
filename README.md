# 🛠️ ระบบคิวงานซ่อม (Repair Queue App)

<p align="center">
  <strong>แอปพลิเคชันสำหรับการคิวงานซ่อม</strong>
</p>

---

## 👤 ผู้จัดทำ

| รายการ | ข้อมูล |
|--------|--------|
| **ชื่อ-นามสกุล** | [นาย ศุภกิจ รักบุตร] |
| **รหัสประจำตัว** | 67543210046-8 |
| **สถาบัน** | มหาวิทยาลัยเทคโนโลยีราชมงคลล้านนา |

---

## 📱 เกี่ยวกับแอปพลิเคชัน

**ระบบคิวงานซ่อม (Repair Queue App)** เป็นแอปพลิเคชันที่พัฒนาขึ้นเพื่อช่วยในการบริหารจัดการคิวงานซ่อมรถยนต์ โดยสามารถบันทึกข้อมูลงานซ่อม ติดตามสถานะ และจัดการรายการงานซ่อมต่างๆ ได้อย่างสะดวกและรวดเร็ว

### 🎯 วัตถุประสงค์
- เพื่อพัฒนาระบบจัดการคิวงานซ่อมที่มีประสิทธิภาพ
- เพื่อฝึกทักษะการพัฒนาแอปพลิเคชันด้วย Flutter
- เพื่อเรียนรู้การทำงานกับฐานข้อมูล SQLite ใน Flutter

---

## ✨ ฟังก์ชันหลัก

### 📊 หน้า Dashboard
แสดงสรุปข้อมูลสำคัญ:
- จำนวนงานทั้งหมด
- จำนวนงานที่กำลังซ่อม
- จำนวนงานที่เสร็จแล้ว
- กราฟแสดงสถิติงานซ่อม (ถ้ามี)

### 🔧 ระบบจัดการข้อมูล (CRUD)
- **เพิ่มรายการงานซ่อม** - บันทึกงานซ่อมใหม่พร้อมรายละเอียด
- **แก้ไขข้อมูล** - แก้ไขสถานะและรายละเอียดงานซ่อม
- **ลบรายการ** - ลบรายการงานซ่อมที่ไม่ต้องการ
- **ดูรายละเอียด** - แสดงข้อมูลงานซ่อมแบบละเอียด

### 🔍 ระบบค้นหา
- ค้นหาตามชื่องานซ่อม (Job Name)
- ค้นหาตามชื่อลูกค้า (Customer Name)
- ค้นหาแบบ Real-time ทันทีที่พิมพ์

### 💾 ฐานข้อมูลภายใน
- เก็บข้อมูลอย่างถาวรด้วย SQLite
- ข้อมูลคงอยู่แม้ปิดแอปพลิเคชัน
- ไม่ต้องเชื่อมต่ออินเทอร์เน็ต



📸 ตัวอย่างหน้าจอแอปพลิเคชัน

![alt text](<Screenshot 2026-03-16 115334.png>)
![alt text](<Screenshot 2026-03-16 115951.png>)
![alt text](<Screenshot 2026-03-16 115349.png>)
![alt text](<Screenshot 2026-03-16 115902.png>)

---

## 🗄️ โครงสร้างฐานข้อมูล

### ตาราง: `repairs`

| Field | Type | Description |
|-------|------|-------------|
| `id` | INTEGER | รหัสรายการ (Primary Key, Auto Increment) |
| `jobName` | TEXT | ชื่องานซ่อม |
| `customerName` | TEXT | ชื่อลูกค้าผู้แจ้ง |
| `type` | TEXT | ประเภทงาน (งานด่วน/งานทั่วไป) |
| `date` | TEXT | วันที่บันทึกข้อมูล (รูปแบบ: YYYY-MM-DD) |
| `status` | TEXT | สถานะ (รอดำเนินการ/กำลังซ่อม/เสร็จแล้ว) |
| `price` | REAL | ค่าใช้จ่ายประมาณการ |

### 🔄 ความสัมพันธ์
- เป็นตารางเดียว (Single Table) ไม่มีความสัมพันธ์กับตารางอื่น

---

## 📦 Package ที่ใช้

| Package | Version | หน้าที่ |
|---------|---------|---------|
| `provider` | ^6.1.1 | จัดการ State ของข้อมูลภายในแอป |
| `sqflite` | ^2.3.0 | จัดการระบบฐานข้อมูล SQLite |
| `path` | ^1.9.0 | จัดการตำแหน่งจัดเก็บไฟล์ฐานข้อมูล |
| `intl` | ^0.18.1 | จัดการรูปแบบวันที่ |
| `flutter` | SDK | Flutter SDK |

### 📥 การติดตั้ง Package
เพิ่ม dependencies ในไฟล์ `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1
  sqflite: ^2.3.0
  path: ^1.9.0
  intl: ^0.18.1
📁 โครงสร้างโปรเจกต์
text
repair_queue_app/
│
├── lib/
│   ├── main.dart                 # จุดเริ่มต้นของแอปพลิเคชัน
│   ├── models/
│   │   └── repair_model.dart      # โมเดลข้อมูลงานซ่อม
│   ├── database/
│   │   └── database_helper.dart   # การจัดการฐานข้อมูล SQLite
│   ├── providers/
│   │   └── repair_provider.dart   # State management ด้วย Provider
│   ├── screens/
│   │   ├── dashboard_screen.dart  # หน้า Dashboard
│   │   ├── add_edit_screen.dart   # หน้าเพิ่ม/แก้ไขข้อมูล
│   │   └── detail_screen.dart     # หน้ารายละเอียด
│   └── widgets/
│       ├── repair_card.dart       # การ์ดแสดงรายการงานซ่อม
│       └── status_badge.dart      # แสดงสถานะงานซ่อม
│
├── assets/
│   └── images/                    # รูปภาพต่างๆ
│
├── android/                       # โฟลเดอร์สำหรับ Android
├── ios/                           # โฟลเดอร์สำหรับ iOS
├── pubspec.yaml                   # ไฟล์กำหนด dependencies
└── README.md                      # ไฟล์คู่มือโปรเจกต์
🚀 วิธีการติดตั้งและรันโปรเจกต์
✅ ความต้องการของระบบ
Flutter SDK (เวอร์ชัน 3.0 ขึ้นไป)

Dart SDK (เวอร์ชัน 3.0 ขึ้นไป)

Android Studio / VS Code

Emulator หรืออุปกรณ์จริงสำหรับทดสอบ

📱 ขั้นตอนการติดตั้ง
1️⃣ Clone โปรเจกต์
bash
git remote add origin https://github.com/supakit0607/Repair_Queue_App.git
cd repair_queue_app
2️⃣ ติดตั้ง Dependencies
bash
flutter pub get
3️⃣ ตรวจสอบไฟล์ MainActivity
ตรวจสอบไฟล์ android/app/src/main/kotlin/com/example/repair_queue_app/MainActivity.kt ให้ตรงกับ package name ใน build.gradle:

kotlin
package com.supakit.repair_app  // ต้องตรงกับ build.gradle

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity()
4️⃣ ตรวจสอบไฟล์ build.gradle
ไฟล์ android/app/build.gradle:

gradle
android {
    namespace = "com.u675432100468.repair_app"  // ต้องตรงกับ MainActivity
    compileSdk = flutter.compileSdkVersion
    // ...
}
5️⃣ รันแอปพลิเคชัน
bash
flutter run
🎮 คำสั่งเพิ่มเติม
bash
# รันแบบ Release
flutter run --release

# สร้าง APK
flutter build apk

# ตรวจสอบปัญหา
flutter doctor

# ล้างแคช
flutter clean


🐛 การแก้ไขปัญหาที่พบบ่อย
ปัญหา: รันคำสั่ง flutter run ไม่ได้
วิธีแก้:

bash
flutter clean
flutter pub get
flutter run
ปัญหา: ฐานข้อมูลไม่ทำงาน
วิธีแก้: ตรวจสอบสิทธิ์การเขียนไฟล์ในเครื่อง

ปัญหา: Package ไม่ตรงกัน
วิธีแก้: ลบโฟลเดอร์ pubspec.lock และรัน flutter pub get ใหม่



