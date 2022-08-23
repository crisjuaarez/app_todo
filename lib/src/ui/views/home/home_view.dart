import 'package:app_todo/src/data/todo_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_todo/src/domain/models/todo.dart';
import 'package:app_todo/src/ui/theme/app_colors.dart';
import 'package:app_todo/src/domain/blocs/todo/todo_bloc.dart';

import 'widgets/todo_tile.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    todos = await TodoDB.db.selectAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final TodoBloc todoBloc = context.read<TodoBloc>();

    return CupertinoPageScaffold(
        backgroundColor: AppColors.backgroundColor,
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  const CupertinoSliverNavigationBar(
                    stretch: true,
                    border: Border(),
                    backgroundColor: AppColors.backgroundColor,
                    largeTitle: Text(
                      'Reminders',
                      style: TextStyle(color: AppColors.orange),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: BlocBuilder<TodoBloc, TodoState>(
                      builder: (_, state) {
                        return ListView.builder(
                          // key: key,
                          shrinkWrap: true,
                          itemCount: todos.length,
                          itemBuilder: (_, i) {
                            final todo = todos[i];
                            return TodoTile(todo: todo);
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            CupertinoButton(
              child: Row(
                children: const [
                  Icon(
                    CupertinoIcons.add_circled_solid,
                    color: AppColors.orange,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'New Reminder',
                    style: TextStyle(color: AppColors.orange),
                  ),
                ],
              ),
              onPressed: () async {
                // todoBloc.add(
                //   CreateTodoEvent(Todo(task: 'hola ${DateTime.now().second}')),
                // );
                final TodoDB todoDB = TodoDB.db;
                await todoDB.insert(Todo(task: 'Nueva tarea'));
                todos = await todoDB.selectAll();
                setState(() {});
              },
            ),
          ],
        ));
  }
}
