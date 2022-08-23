import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_todo/src/ui/theme/app_colors.dart';
import 'package:app_todo/src/domain/blocs/todo/todo_bloc.dart';

import '../../../../domain/models/todo.dart';

class TodoTile extends StatefulWidget {
  const TodoTile({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  late TextEditingController _reminderCtrl;
  late FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _reminderCtrl = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _reminderCtrl.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _focusNode.requestFocus();
  // }

  @override
  Widget build(BuildContext context) {
    final TodoBloc bloc = context.read<TodoBloc>();
    final todo = widget.todo;
    final focusScope = FocusScope.of(context);
    final style = TextStyle(color: todo.done ? AppColors.grey : null);

    return Material(
      color: Colors.transparent,
      child: ListTile(
          leading: IconButton(
            splashColor: Colors.transparent,
            color: AppColors.orange,
            icon: Icon(
              !todo.done ? Icons.radio_button_off : Icons.radio_button_checked,
            ),
            onPressed: () async {
              setState(() => todo.done = !todo.done);
              if (todo.done) {
                await Future.delayed(const Duration(seconds: 2));
                focusScope.requestFocus(FocusNode());
                if (todo.done) {
                  bloc.add(DeleteTodoEvent(todo));
                }
              }
            },
          ),
          title: CupertinoTextField(
            focusNode: _focusNode,
            controller: _reminderCtrl,
            placeholder: todo.task,
            padding: EdgeInsets.zero,
            placeholderStyle: style,
            style: style,
            decoration: const BoxDecoration(border: Border()),
            onEditingComplete: () {
              focusScope.requestFocus(FocusNode());
              // final Todo newTodo = todo.copyWith(
              //   task: _reminderCtrl.text.trim(),
              // );
              // bloc.add(UpdateTodoEvent(newTodo, widget.index));
            },
          )),
    );
  }
}
