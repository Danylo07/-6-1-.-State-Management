import 'package:flutter/widgets.dart';

import 'todo_model.dart';

/// Надає [TodoModel] усьому піддереву без сторонніх пакетів.
/// Розміщується над MaterialApp, щоб бачили й екрани, відкриті через Navigator.
class TodoScope extends InheritedNotifier<TodoModel> {
  const TodoScope({
    super.key,
    required TodoModel model,
    required super.child,
  }) : super(notifier: model);

  /// [listen] = true — віджет підписується й перебудовується при змінах.
  /// [listen] = false — лише отримати модель (для колбеків: add, toggle тощо).
  static TodoModel of(BuildContext context, {bool listen = true}) {
    final TodoScope? scope = listen
        ? context.dependOnInheritedWidgetOfExactType<TodoScope>()
        : context.getInheritedWidgetOfExactType<TodoScope>();
    assert(scope != null, 'TodoScope не знайдено вище в дереві віджетів');
    return scope!.notifier!;
  }
}
