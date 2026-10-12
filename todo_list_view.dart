import 'package:flutter/material.dart';

import '../models/todo_filter.dart';
import '../state/todo_scope.dart';
import 'todo_tile.dart';

/// Список справ. Єдиний віджет екрана, що підписаний на модель, —
/// тому позначення справи не чіпає форму й решту екрана.
class TodoListView extends StatelessWidget {
  const TodoListView({super.key, required this.filter});

  final TodoFilter filter;

  @override
  Widget build(BuildContext context) {
    debugPrint('build: TodoListView');
    final items = TodoScope.of(context).filtered(filter);
    if (items.isEmpty) {
      return Center(child: Text(_emptyText(filter)));
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final todo = items[index];
        return TodoTile(key: ValueKey(todo.id), todo: todo);
      },
    );
  }

  String _emptyText(TodoFilter filter) => switch (filter) {
        TodoFilter.all => 'Справ поки немає — додайте першу',
        TodoFilter.active => 'Активних справ немає',
        TodoFilter.completed => 'Виконаних справ немає',
      };
}
