import 'package:flutter/material.dart';

import '../models/todo_filter.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key, required this.selected, required this.onChanged});

  final TodoFilter selected;
  final ValueChanged<TodoFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: SegmentedButton<TodoFilter>(
        segments: [
          for (final filter in TodoFilter.values)
            ButtonSegment<TodoFilter>(value: filter, label: Text(filter.label)),
        ],
        selected: {selected},
        onSelectionChanged: (set) => onChanged(set.first),
      ),
    );
  }
}
