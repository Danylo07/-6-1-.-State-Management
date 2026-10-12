import 'package:flutter/material.dart';

import 'screens/todo_list_screen.dart';
import 'state/todo_model.dart';
import 'state/todo_scope.dart';

void main() => runApp(const TodoApp());

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final TodoModel _model = TodoModel();

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scope над MaterialApp — щоб модель бачили й екрани з Navigator.push.
    return TodoScope(
      model: _model,
      child: MaterialApp(
        title: 'Список справ',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
        home: const TodoListScreen(),
      ),
    );
  }
}
