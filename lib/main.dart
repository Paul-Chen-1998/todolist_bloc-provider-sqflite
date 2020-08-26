import 'package:flutter/material.dart';
import 'package:todolists/bloc/todo_bloc.dart';
import 'package:todolists/todo/todo_header.dart';
import 'db/todo_database.dart';
import 'package:todolists/todo/todo_list_container.dart';
import 'package:provider/provider.dart';
void main() async{
  await TodoDatabase.instance.init();
  runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: "Flutter Demo",
        theme: ThemeData(
          primaryColor: Colors.blue
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("TodoList"),
          ),
          body: Provider<TodoBloc>.value(
              value: TodoBloc(),
              child: ToDoListContainer()),
        ),
      );
  }
}

