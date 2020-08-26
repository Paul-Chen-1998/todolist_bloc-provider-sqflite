import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolists/bloc/todo_bloc.dart';
import 'package:todolists/event/add_todo_event.dart';
import 'package:todolists/todo/todo_list_container.dart';

class TodoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var txtToDoController = TextEditingController();
    var bloc = Provider.of<TodoBloc>(context);
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: txtToDoController,
            decoration: InputDecoration(labelText: 'AddToDo', hintText: 'Add Todo'),
          ),
        ),
        SizedBox(width: 20,),
        RaisedButton.icon(
            onPressed: () {
              bloc.event.add(AddTodoEvent(txtToDoController.text));
            }, icon: Icon(Icons.add), label: Text('add'))
      ],
    );
  }
}
