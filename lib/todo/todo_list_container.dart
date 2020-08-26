import 'package:flutter/material.dart ';
import 'package:todolists/todo/todo_header.dart';
import 'todo_list.dart';
class ToDoListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [TodoHeader(),
          Expanded(child: TodoList())
        ],
      ),
    );
  }
}

