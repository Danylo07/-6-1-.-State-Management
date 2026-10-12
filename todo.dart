import 'package:flutter/foundation.dart';

/// Незмінна модель справи. Змінити її можна лише через [copyWith].
@immutable
class Todo {
  const Todo({
    required this.id,
    required this.title,
    this.description = '',
    this.isDone = false,
  });

  final int id;
  final String title;
  final String description;
  final bool isDone;

  Todo copyWith({String? title, String? description, bool? isDone}) {
    return Todo(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is Todo &&
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.isDone == isDone;

  @override
  int get hashCode => Object.hash(id, title, description, isDone);
}
