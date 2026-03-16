import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/repair_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('repair.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // ค้นหาบรรทัดที่ CREATE TABLE แล้วแก้เป็นแบบนี้:
    await db.execute('''
  CREATE TABLE repairs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    jobName TEXT,
    customerName TEXT,
    type TEXT,
    date TEXT,
    status TEXT,
    price REAL
  )
''');
  }

  Future<int> create(RepairItem item) async {
    final db = await instance.database;
    return await db.insert('repairs', item.toMap());
  }

  Future<List<RepairItem>> readAll() async {
    final db = await instance.database;
    final result = await db.query('repairs', orderBy: 'date DESC');
    return result.map((json) => RepairItem.fromMap(json)).toList();
  }

  Future<int> update(RepairItem item) async {
    final db = await instance.database;
    return db.update(
      'repairs',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete('repairs', where: 'id = ?', whereArgs: [id]);
  }
}
