import 'todo.dart';

/// Фільтр списку. Обране значення — ефемерний стан екрана списку.
enum TodoFilter {
  all('Усі'),
  active('Активні'),
  completed('Виконані');

  const TodoFilter(this.label);

  final String label;

  bool matches(Todo todo) => switch (this) {
        TodoFilter.all => true,
        TodoFilter.active => !todo.isDone,
        TodoFilter.completed => todo.isDone,
      };
}
