import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolists/bloc/todo_bloc.dart';
import 'package:todolists/event/delete_todo_event.dart';
import 'package:todolists/model/todo.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    var bloc = Provider.of<TodoBloc>(context);
    bloc.initData();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoBloc>(
      builder: (context, bloc, child) => StreamBuilder<List<Todo>>(
          stream: bloc.todoListStream,
          //snapshot dữ liệu nhận từ stream
          builder: (context, snapshot) {
            //bắt state của snapshot
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      print("data1");
                      return ListTile(
                          title: Text(
                            snapshot.data[index].content,
                            style: TextStyle(fontSize: 20),
                          ),
                          trailing: Container(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    bloc.event.add(DeleteTodoEvent(snapshot.data[index]));
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red[400],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.update,
                                    color: Colors.blue[400],
                                  ),
                                )
                              ],
                            ),
                          ));
                    });
              case ConnectionState.waiting:

              case ConnectionState.none:
              return Center(
                child: Container(
                  width: 70,
                  height: 70,
                  child: Text("Empty", style: TextStyle(fontSize: 20),),
                ),
              );
              default:
                print("data2");
                return Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    child: CircularProgressIndicator(),
                  ),
                );
            }
          }),
    );
  }
}
