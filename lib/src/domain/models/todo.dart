class Todo {
  Todo({
    this.id,
    this.task = '',
    this.done = false,
  });

  int? id;
  String task;
  bool done;

  Todo copyWith({int? id, String? task, bool? done}) => Todo(
        id: id ?? this.id,
        task: task ?? this.task,
        done: done ?? this.done,
      );

  Map<String, dynamic> toMap(Todo todo) => {
        'id': todo.id,
        'task': todo.task,
        'done': todo.done == true ? 1 : 0,
      };

  factory Todo.fromMap(Map<String, dynamic> map) => Todo(
        id: map['id'],
        task: map['task'],
        done: map['done'] == 1,
      );
}
