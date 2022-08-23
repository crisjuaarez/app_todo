import 'package:app_todo/src/data/todo_db.dart';
import 'package:flutter/material.dart';

import 'src/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TodoDB.initDB();
  runApp(const MyApp());
}
