import 'package:flutter/material.dart';

import '../models/todo_filter.dart';
import '../widgets/add_todo_form.dart';
import '../widgets/filter_bar.dart';
import '../widgets/progress_badge.dart';
import '../widgets/todo_list_view.dart';

/// ЕТАП 2. Екран більше не володіє переліком справ — лише ефемерним
/// фільтром. Сам екран на модель не підписаний (of не викликається),
/// тому при зміні справ він не перебудовується.
class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  // Ефемерний стан екрана.
  TodoFilter _filter = TodoFilter.all;

  @override
  Widget build(BuildContext context) {
    debugPrint('build: TodoListScreen');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список справ'),
        actions: const [ProgressBadge()],
      ),
      body: Column(
        children: [
          const AddTodoForm(),
          FilterBar(
            selected: _filter,
            onChanged: (filter) => setState(() => _filter = filter),
          ),
          Expanded(child: TodoListView(filter: _filter)),
        ],
      ),
    );
  }
}
