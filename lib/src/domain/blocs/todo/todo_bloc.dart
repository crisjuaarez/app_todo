import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;

import 'package:app_todo/src/domain/models/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<CreateTodoEvent>(_onCreateEvent);
    on<DeleteTodoEvent>(_onDeleteEvent);
    on<UpdateTodoEvent>(_onUpdateEvent);
    on<TodoEvent>((event, emit) {});
  }

  void _onCreateEvent(CreateTodoEvent event, Emitter<TodoState> emit) {
    final List<Todo> todoList = state.todos;
    todoList.add(event.todo);
    emit(TodoState(todoList));
  }

  void _onDeleteEvent(DeleteTodoEvent event, Emitter<TodoState> emit) {
    // final List<Todo> todoList = state.todos;

    state.todos.remove(event.todo);

    emit(TodoState(state.todos));
  }

  void _onUpdateEvent(UpdateTodoEvent event, Emitter<TodoState> emit) {
    final List<Todo> todoList = state.todos;

    // todoList.indexWhere((element) => element.task == event.todo.task);

    final Todo newTodo = event.newTodo;
    todoList[event.indexToUpdate] = newTodo;

    emit(TodoState(todoList));
  }
}
