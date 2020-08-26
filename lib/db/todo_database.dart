import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todolists/db/todo_table.dart';
class TodoDatabase {
  static  const DB_NAME = 'todo.db';
  static const DB_VERSION = 1;
  static Database _database;

  // tránh trường hợp mỗi lần build tạo ra object mooi71
  TodoDatabase._internal();
  static final TodoDatabase instance = TodoDatabase._internal();

  Database get database => _database;

  static const intScripts = [TodoTable.CREATE_TABLE_QUERY];
  static const migrationScripts = [TodoTable.CREATE_TABLE_QUERY];

  init() async{
    _database = await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      onCreate: (db, version){
        intScripts.forEach((script) async => await db.execute(script));
      },
      onUpgrade: (db, oldVersion, newVersion){
        migrationScripts.forEach((script) async => await db.execute(script));
    },

      version: DB_VERSION;
    );
  }
}