import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'dart:io';
import '../models/wish_item.dart';

class WishDb {
  static bool _initialized = false;
  static Future<void> _ensureInit() async {
    if (_initialized) return;
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    _initialized = true;
  }
  static Database? _db;
  static Future<Database> get db async {
    await _ensureInit();
    if (_db != null) return _db!;
    final p = join(await getDatabasesPath(), 'wishes.db');
    _db = await openDatabase(p, version: 1, onCreate: (d, v) async {
      await d.execute('''CREATE TABLE wishes(
        id TEXT PRIMARY KEY, title TEXT, type TEXT, url TEXT, imagePath TEXT,
        price REAL, reason TEXT, waitDays INTEGER, createdAt TEXT, status TEXT)''');
    });
    return _db!;
  }

  static Future<List<WishItem>> all() async {
    final d = await db;
    final rows = await d.query('wishes', orderBy: 'createdAt DESC');
    return rows.map(WishItem.fromMap).toList();
  }

  static Future<void> insert(WishItem i) async {
    final d = await db;
    await d.insert('wishes', i.toMap());
  }

  static Future<void> updateStatus(String id, String status) async {
    final d = await db;
    await d.update('wishes', {'status': status}, where: 'id=?', whereArgs: [id]);
  }

  static Future<void> delete(String id) async {
    final d = await db;
    await d.delete('wishes', where: 'id=?', whereArgs: [id]);
  }
}
