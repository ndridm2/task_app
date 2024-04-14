import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_app/data/models/task.dart';

class LocalDatabase {
  final String dbName = 'tasks_local.db';
  final String tableName = 'tasks';

  Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    return await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute(
        '''CREATE TABLE $tableName(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT,
          createdAt TEXT)''',
      );
    });
  }

  Future<int> insertTask(Task task) async {
    final db = await _openDatabase();
    return await db.insert(tableName, task.toMap());
  }

  Future<List<Task>> getTasks() async {
    final db = await _openDatabase();
    final maps = await db.query(tableName, orderBy: 'createdAt DESC');
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  Future<Task> getTaskById(int id) async {
    final db = await _openDatabase();
    final maps = await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    return Task.fromMap(maps.first);
  }

  Future<int> updateTask(Task task) async {
    final db = await  _openDatabase();
    return await db.update(tableName, task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<int> deleteTask(int id) async {
    final db = await _openDatabase();
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Task>> searchTasks(String query) async {
     // ignore: unused_local_variable
     final db = await _openDatabase();
    List<Task> list = await getTasks();
    return list.where((element) => element.title.toLowerCase().contains(query.toLowerCase())).toList();
  }
}
