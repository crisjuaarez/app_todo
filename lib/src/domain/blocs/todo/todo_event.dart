part of 'todo_bloc.dart';

abstract class TodoEvent {}

class CreateTodoEvent extends TodoEvent {
  final Todo todo;

  CreateTodoEvent(this.todo);
}

class UpdateTodoEvent extends TodoEvent {
  final Todo newTodo;
  final int indexToUpdate;

  UpdateTodoEvent(this.newTodo, this.indexToUpdate);
}

class DeleteTodoEvent extends TodoEvent {
  final Todo todo;

  DeleteTodoEvent(this.todo);
}
