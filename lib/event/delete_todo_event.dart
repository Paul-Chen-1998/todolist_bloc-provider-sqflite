
import 'package:todolists/base/base_event.dart';
import 'package:todolists/model/todo.dart';

class DeleteTodoEvent extends BaseEvent{
  Todo todo;

  DeleteTodoEvent(this.todo);

}