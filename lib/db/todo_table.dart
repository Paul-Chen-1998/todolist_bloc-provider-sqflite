import 'package:sqflite/sqflite.dart';
import 'package:todolists/db/todo_database.dart';
import 'package:todolists/model/todo.dart';

import 'todo_database.dart';

class TodoTable {
  static const TABLE_NAME = 'todo';
  static const CREATE_TABLE_QUERY = '''
    CREATE TABLE $TABLE_NAME (
      id INTERGER PRIMARY KEY,
      content TEXT
    )  
  ''';
  static const DROP_TABLE_QUERY = '''
    DROP TABLE IF EXISTS $TABLE_NAME
  ''';

  Future<int> insertTodo(Todo todo) {
    final Database db = TodoDatabase.instance.database;
    return db.insert(TABLE_NAME, todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteToddo(Todo todo) async {
    final Database db = TodoDatabase.instance.database;
    await db.delete(TABLE_NAME, where: 'id = 7', whereArgs: [todo.id]);


    Future<List<Todo>> selectAllTodo() async {
      final Database db = TodoDatabase.instance.database;
      final List<Map<String, dynamic>> maps = await db.query('todo');

      return List.generate(maps.length, (index) {
        return Todo.fromData(maps[index]['id'], maps[index]['content']);
      });
    }
  }
}
