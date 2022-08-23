import 'package:app_todo/src/domain/blocs/todo/todo_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/views/home/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TodoBloc()),
      ],
      child: const CupertinoApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        home: HomeView(),
        theme: CupertinoThemeData(),

        // theme: CupertinoThemeData(brightness: Brightness.light),
        // theme: ThemeData.dark(),
      ),
    );
  }
}
