import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'subject.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> getDb() async {
    if (_db != null) return _db!;

    _db = await openDatabase(
      join(await getDatabasesPath(), 'mid_exam.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE subjects(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            teacher TEXT,
            credits INTEGER
          )''',
        );
      },
    );
    return _db!;
  }

  static Future<void> insertSubject(Subject subject) async {
    final db = await getDb();
    await db.insert(
      'subjects',
      subject.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Subject>> getSubjects() async {
    final db = await getDb();
    final List<Map<String, dynamic>> maps = await db.query('subjects');
    return List.generate(maps.length, (i) {
      return Subject.fromMap(maps[i]);
    });
  }
}