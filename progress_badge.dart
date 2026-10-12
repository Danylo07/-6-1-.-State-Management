import 'package:flutter/material.dart';

import '../state/todo_scope.dart';

/// Бейдж в AppBar: «виконано N з M». Підписується на модель сам.
class ProgressBadge extends StatelessWidget {
  const ProgressBadge({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build: ProgressBadge');
    final model = TodoScope.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.secondaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              'виконано ${model.completedCount} з ${model.totalCount}',
              style: TextStyle(
                color: scheme.onSecondaryContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
