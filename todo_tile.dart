import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../screens/edit_todo_screen.dart';
import '../state/todo_scope.dart';

/// Рядок справи. Дії виконує через модель зі scope (listen: false) —
/// колбеки через проміжні віджети більше не потрібні.
class TodoTile extends StatelessWidget {
  const TodoTile({super.key, required this.todo});

  final Todo todo;

  void _remove(BuildContext context) {
    final model = TodoScope.of(context, listen: false);
    final removed = model.remove(todo.id);
    if (removed == null) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Видалено «${removed.todo.title}»'),
          action: SnackBarAction(
            label: 'Скасувати',
            onPressed: () => model.restore(removed.todo, removed.index),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build: TodoTile(${todo.id})');
    final scheme = Theme.of(context).colorScheme;
    return Dismissible(
      key: ValueKey(todo.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: scheme.errorContainer,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete_outline, color: scheme.onErrorContainer),
      ),
      onDismissed: (_) => _remove(context),
      child: ListTile(
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (_) =>
              TodoScope.of(context, listen: false).toggle(todo.id),
        ),
        title: Text(
          todo.title,
          style: todo.isDone
              ? TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: scheme.onSurfaceVariant,
                )
              : null,
        ),
        subtitle: todo.description.isEmpty
            ? null
            : Text(
                todo.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => EditTodoScreen(todo: todo),
          ),
        ),
      ),
    );
  }
}
