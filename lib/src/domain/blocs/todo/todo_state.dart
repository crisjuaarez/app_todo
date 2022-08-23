part of 'todo_bloc.dart';

class TodoState {
  List<Todo> todos;

  TodoState(this.todos);
}

class TodoInitial extends TodoState {
  TodoInitial() : super([]);
}
