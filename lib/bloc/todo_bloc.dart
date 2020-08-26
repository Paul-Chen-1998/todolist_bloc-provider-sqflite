import 'dart:async';
import 'dart:math';
import 'package:todolists/base/base_bloc.dart';
import 'package:todolists/db/todo_table.dart';
import 'package:todolists/base/base_event.dart';
import 'package:todolists/db/todo_table.dart';
import 'package:todolists/event/add_todo_event.dart';
import 'package:todolists/event/delete_todo_event.dart';

import '../model/todo.dart';

class TodoBloc extends BaseBloc {

  TodoTable _todoTable = TodoTable();

  StreamController<List<Todo>> _todoListStreamController =
  StreamController<List<Todo>>();

  Stream<List<Todo>> get todoListStream  => _todoListStreamController.stream;
  var _randomInt = Random();
  List<Todo> _todoListData = List<Todo>();

  initData() async{
   _todoListData =  await _todoTable.selectAllTodo();
    if(_todoListData == null){
      return;
    }
   _todoListStreamController.sink.add(_todoListData);
  }
  _addTodo(Todo todo) async {
    //insert to database
    await _todoTable.insertTodo(todo);
    _todoListData.add(todo);
    //day? event
    _todoListStreamController.sink.add(_todoListData);
  }

  _deleteTodo(Todo todo) async{
    await _todoTable.deleteToddo(todo);
    _todoListData.remove(todo);
    //day? event
    _todoListStreamController.sink.add(_todoListData);
  }

  @override
  //add todoEvent
  void disPatchEvent(BaseEvent event) {
    if (event is AddTodoEvent) {
      Todo todo = Todo.fromData(_randomInt.nextInt(100), event.content);
      print(event.content);
    } else if (event is DeleteTodoEvent) {
      _deleteTodo(event.todo);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _todoListStreamController.close();
  }
}
