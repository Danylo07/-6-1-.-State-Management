# todo_state_app

Практична робота 6.1 «Базовий State Management у Flutter» — **Варіант 2: Список справ**.
Лише Flutter SDK, без сторонніх пакетів стану.

## Запуск

```bash
flutter create . --platforms=android,ios,web   # один раз: згенерує платформні каталоги
flutter pub get
flutter run
flutter analyze
flutter test
```

## Етапи (git-теги)

| Тег | Що зроблено |
|---|---|
| `stage-1-lifting` | Перелік справ піднято до `_TodoListScreenState`, вниз іде конструкторами та колбеками (`setState`) |
| `stage-2-inherited` | Стан винесено в `TodoModel extends ChangeNotifier`, надано через `TodoScope extends InheritedNotifier` з `TodoScope.of(context)`; колбеки через проміжні віджети прибрано |

## Структура `lib/`

```
lib/
├── main.dart                     # TodoApp: створює/звільняє TodoModel, TodoScope над MaterialApp
├── models/
│   ├── todo.dart                 # незмінна Todo + copyWith
│   └── todo_filter.dart          # enum фільтра Усі / Активні / Виконані
├── state/
│   ├── todo_model.dart           # ChangeNotifier: add, toggle, update, remove, restore
│   └── todo_scope.dart           # InheritedNotifier + static of(context, {listen})
├── screens/
│   ├── todo_list_screen.dart     # ефемерний фільтр
│   └── edit_todo_screen.dart     # ефемерні поля форми редагування
└── widgets/
    ├── add_todo_form.dart, filter_bar.dart, progress_badge.dart,
    └── todo_list_view.dart, todo_tile.dart
```

## Таблиця стану

| Дані | Тип стану | Де живуть | Чому саме там |
|---|---|---|---|
| Перелік справ (`List<Todo>`) | Застосунку | Етап 1: `_TodoListScreenState` → Етап 2: `TodoModel` | Потрібен формі, списку, бейджу й екрану редагування; не належить жодному з них |
| Лічильник «виконано N з M» | Похідний | Геттери `completedCount`, `totalCount` у `TodoModel` | Обчислюється з переліку, дублювати не треба |
| Обраний фільтр | Ефемерний | `_TodoListScreenState._filter` | Потрібен лише екрану списку |
| Текст у формі додавання, помилка валідації | Ефемерний | `_AddTodoFormState` (`TextEditingController`) | Стосується лише форми, зникає після додавання |
| Поля форми редагування та перемикач «Виконано» до збереження | Ефемерний | `_EditTodoScreenState` | У модель потрапляють лише після «Зберегти» |
| Остання видалена справа для «Скасувати» | Ефемерний | Замикання `SnackBarAction` | Потрібна лише поки видно SnackBar |

## Журнал перебудов (етап 2)

Увімкніть `flutter run` і виконайте дії, скопіюйте фрагмент консолі.
Очікувана поведінка за кодом (**замініть реальним виводом зі свого запуску**):

**Позначення однієї справи галочкою** (`TodoScope.of(context, listen: false).toggle`):
```
build: ProgressBadge
build: TodoListView
build: TodoTile(1)
build: TodoTile(2)
```
Не перебудовуються: `TodoListScreen`, `AddTodoForm` (вона `const` і не підписана на модель) — введений у форму текст не губиться.

**Введення тексту в поле нової справи:** жодного рядка `build:` — перебудовується лише `TextFormField` усередині форми.

**Зміна фільтра:**
```
build: TodoListScreen
build: TodoListView
build: TodoTile(...)
```
`AddTodoForm` і `ProgressBadge` не перебудовуються.

## Скриншоти

_Додайте скриншоти: список, форма з помилкою, SnackBar «Скасувати», екран редагування._

## Варіант

Варіант 2 — «Список справ».
