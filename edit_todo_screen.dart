import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../state/todo_scope.dart';

/// Екран редагування. Отримує справу значенням, зберігає зміни через модель.
class EditTodoScreen extends StatefulWidget {
  const EditTodoScreen({super.key, required this.todo});

  final Todo todo;

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late bool _isDone;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo.title);
    _descriptionController =
        TextEditingController(text: widget.todo.description);
    _isDone = widget.todo.isDone;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    TodoScope.of(context, listen: false).update(
      widget.todo.copyWith(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        isDone: _isDone,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build: EditTodoScreen');
    return Scaffold(
      appBar: AppBar(title: const Text('Редагування справи')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Назва',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'Назва не може бути порожньою'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Опис',
                  border: OutlineInputBorder(),
                ),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Виконано'),
                value: _isDone,
                onChanged: (value) => setState(() => _isDone = value),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _save,
                  child: const Text('Зберегти'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
