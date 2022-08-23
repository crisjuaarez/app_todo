import 'dart:io';
import 'package:path/path.dart' as p show join;

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:app_todo/src/domain/models/todo.dart';

const TABLE_NAME = 'Todo';

class TodoDB {
  static Database? _db;
  static final TodoDB db = TodoDB._();
  TodoDB._();

  Future<Database?> get database async {
    if (_db != null) return _db;
    _db = await initDB();
    return _db;
  }

  static Future<Database> initDB() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = p.join(directory.path, '$TABLE_NAME.db');
    print('openDatabase');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $TABLE_NAME ('
          ' id INTEGER PRIMARY KEY AUTOINCREMENT,'
          ' task TEXT NOT NULL,'
          ' done INTEGER NOT NULL'
          ')',
        );
      },
    );
  }

  Future<int> insertRaw(Todo todo) async {
    final Database? db = await database;
    final result = await db!.rawInsert('''
    INSERT Into $TABLE_NAME (id, task, done) 
    VALUES (${todo.id}, '${todo.task}', 0)
    ''');
    return result;
  }

  Future<int> insert(Todo todo) async {
    final Database? db = await database;
    final result = await db!.insert(TABLE_NAME, todo.toMap(todo));
    return result;
  }

  // SELECT FROM
  Future<Todo?> selectById(int id) async {
    final Database? db = await database;
    final result = await db!.query(
      TABLE_NAME,
      where: 'id = ?',
      whereArgs: [
        id,
      ],
    );
    return result.isNotEmpty ? Todo.fromMap(result.first) : null;
  }

  Future<List<Todo>> selectAll() async {
    final Database? db = await database;
    final result = await db!.query(TABLE_NAME);
    final List<Todo> list =
        result.isNotEmpty ? result.map((e) => Todo.fromMap(e)).toList() : [];
    return list;
  }

  Future<Todo?> selectByDone() async {
    final Database? db = await database;
    final result = await db!.rawQuery("SELECT * FROM $TABLE_NAME WHERE done=1");
    return result.isNotEmpty ? Todo.fromMap(result.first) : null;
  }
}
