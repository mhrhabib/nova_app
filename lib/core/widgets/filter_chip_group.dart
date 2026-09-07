import 'package:flutter/material.dart';

class FilterChipGroup<T> extends StatelessWidget {
  final List<T> options;
  final T selectedOption;
  final String Function(T option) labelBuilder;
  final ValueChanged<T> onSelected;

  const FilterChipGroup({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.labelBuilder,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: options.map((option) {
          final isSelected = option == selectedOption;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(labelBuilder(option)),
              selected: isSelected,
              onSelected: (_) => onSelected(option),
              selectedColor: theme.colorScheme.primary,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              labelStyle: theme.textTheme.labelMedium?.copyWith(
                color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              side: BorderSide(
                color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          );
        }).toList(),
      ),
    );
  }
}
