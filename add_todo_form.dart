import 'package:flutter/material.dart';

import '../state/todo_scope.dart';

/// Форма додавання. Тексти полів — ефемерний стан, тому живуть тут.
class AddTodoForm extends StatefulWidget {
  const AddTodoForm({super.key});

  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    TodoScope.of(context, listen: false).add(
      _titleController.text,
      description: _descriptionController.text,
    );
    _titleController.clear();
    _descriptionController.clear();
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build: AddTodoForm');
    return Card(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Назва',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'Назва не може бути порожньою'
                    : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submit(),
                decoration: const InputDecoration(
                  labelText: 'Опис (необов’язково)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.add),
                  label: const Text('Додати'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
