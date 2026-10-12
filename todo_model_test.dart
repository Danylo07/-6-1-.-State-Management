import 'package:flutter_test/flutter_test.dart';
import 'package:todo_state_app/models/todo_filter.dart';
import 'package:todo_state_app/state/todo_model.dart';

void main() {
  group('TodoModel', () {
    late TodoModel model;

    setUp(() => model = TodoModel());
    tearDown(() => model.dispose());

    test('add обрізає пробіли й сповіщає слухачів', () {
      var notified = 0;
      model.addListener(() => notified++);

      model.add('  Купити молоко ', description: ' 2 л ');

      expect(model.totalCount, 1);
      expect(model.todos.single.title, 'Купити молоко');
      expect(model.todos.single.description, '2 л');
      expect(notified, 1);
    });

    test('toggle змінює лічильник виконаних', () {
      model.add('A');
      model.add('B');
      model.toggle(model.todos.first.id);

      expect(model.completedCount, 1);
      expect(model.filtered(TodoFilter.active).single.title, 'B');
      expect(model.filtered(TodoFilter.completed).single.title, 'A');
    });

    test('update замінює справу за id', () {
      model.add('Стара');
      final todo = model.todos.single;
      model.update(todo.copyWith(title: 'Нова'));

      expect(model.todos.single.title, 'Нова');
    });

    test('remove + restore повертають справу на місце', () {
      model.add('1');
      model.add('2');
      model.add('3');
      final removed = model.remove(model.todos[1].id)!;

      expect(model.totalCount, 2);
      expect(removed.index, 1);

      model.restore(removed.todo, removed.index);

      expect(model.todos.map((t) => t.title), ['1', '2', '3']);
    });

    test('remove неіснуючого id повертає null', () {
      expect(model.remove(42), isNull);
    });
  });
}
