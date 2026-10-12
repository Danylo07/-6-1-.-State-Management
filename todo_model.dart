import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../models/todo.dart';
import '../models/todo_filter.dart';

/// Спільний стан застосунку: перелік справ і операції над ним.
class TodoModel extends ChangeNotifier {
  final List<Todo> _todos = [];
  int _nextId = 1;

  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  int get totalCount => _todos.length;

  int get completedCount => _todos.where((t) => t.isDone).length;

  List<Todo> filtered(TodoFilter filter) =>
      _todos.where(filter.matches).toList();

  void add(String title, {String description = ''}) {
    _todos.add(
      Todo(
        id: _nextId++,
        title: title.trim(),
        description: description.trim(),
      ),
    );
    notifyListeners();
  }

  void toggle(int id) {
    final index = _indexOf(id);
    if (index < 0) return;
    _todos[index] = _todos[index].copyWith(isDone: !_todos[index].isDone);
    notifyListeners();
  }

  void update(Todo updated) {
    final index = _indexOf(updated.id);
    if (index < 0) return;
    _todos[index] = updated;
    notifyListeners();
  }

  /// Видаляє справу й повертає її разом з позицією — для «Скасувати».
  ({Todo todo, int index})? remove(int id) {
    final index = _indexOf(id);
    if (index < 0) return null;
    final removed = _todos.removeAt(index);
    notifyListeners();
    return (todo: removed, index: index);
  }

  void restore(Todo todo, int index) {
    _todos.insert(index.clamp(0, _todos.length), todo);
    notifyListeners();
  }

  int _indexOf(int id) => _todos.indexWhere((t) => t.id == id);
}
