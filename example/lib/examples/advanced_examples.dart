import 'package:ff_drop_down_list/ff_drop_down_list.dart';
import 'package:flutter/material.dart';

class AdvancedExamples {
  static void showMultipleSelectionExample(BuildContext context) {
    final countries = [
      'United States',
      'Canada',
      'United Kingdom',
      'Germany',
      'France',
      'Japan',
      'Australia',
      'Brazil',
      'India',
      'China',
      'Mexico',
      'Spain'
    ];

    DropDown<String>(
      data: DropDownData.raw(countries),
      options: DropDownOptions(
        enableMultipleSelection: true,
        maxSelectedItems: 5,
        onSelected: (selectedItems) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Selected: ${selectedItems.asItemData().join(', ')}')),
          );
        },
      ),
      style: DropDownStyle(
        headerWidget: const Text(
          'Select Countries (Max 5)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        isSelectAllVisible: true,
        submitButtonText: 'Confirm Selection',
        clearButtonText: 'Clear All',
      ),
    ).show(context);
  }

  static void showCustomListItemExample(BuildContext context) {
    final tasks = [
      TaskItem('Complete project proposal', 'High', '2024-01-15', true),
      TaskItem('Review code changes', 'Medium', '2024-01-16', false),
      TaskItem('Update documentation', 'Low', '2024-01-17', false),
      TaskItem('Team meeting preparation', 'High', '2024-01-15', false),
      TaskItem('Bug fixes', 'Critical', '2024-01-14', true),
    ];

    DropDown<TaskItem>(
      data: DropDownData(tasks.map((t) => DropDownItem(t)).toList()),
      options: DropDownOptions(
        enableMultipleSelection: true,
        listItemBuilder: (index, item) =>
            TaskTile(task: item.data, index: index),
        onSelected: (selectedTasks) {
          final taskNames = selectedTasks.map((t) => t.data.title).join(', ');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected tasks: $taskNames')),
          );
        },
      ),
      style: DropDownStyle(
        headerWidget: const Text(
          'Select Tasks',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        listSeparator: const Divider(height: 1),
      ),
    ).show(context);
  }

  static void showThemedExample(BuildContext context, {required bool isDark}) {
    final colors = isDark
        ? ['Dark Blue', 'Dark Green', 'Dark Red', 'Dark Purple']
        : ['Light Blue', 'Light Green', 'Light Red', 'Light Purple'];

    DropDown<String>(
      data: DropDownData.raw(colors),
      options: DropDownOptions(
        onSingleSelected: (item) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected: ${item.data}')),
          );
        },
      ),
      style: DropDownStyle.build((context) => DropDownStyle(
            headerWidget: Text(
              isDark ? 'Dark Theme Colors' : 'Light Theme Colors',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            backgroundColor:
                isDark ? Theme.of(context).colorScheme.surface : Colors.white,
            tileColor: isDark
                ? Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest
                    .withValues(alpha: 0.3)
                : Colors.grey.shade50,
            selectedTileColor: isDark
                ? Theme.of(context).colorScheme.surfaceContainerHighest
                : Colors.blue.shade100,
            searchFillColor: isDark
                ? Theme.of(context).colorScheme.surfaceContainerHighest
                : Colors.grey.shade100,
            searchCursorColor:
                isDark ? Theme.of(context).colorScheme.primary : Colors.blue,
          )),
    ).show(context);
  }
}

class TaskItem implements DropDownItemBuilder, DropDownItemSearchable {
  final String title;
  final String priority;
  final String dueDate;
  final bool isCompleted;

  TaskItem(this.title, this.priority, this.dueDate, this.isCompleted);

  @override
  Widget build(BuildContext context, int index) {
    return TaskTile(task: this, index: index);
  }

  @override
  bool satisfiesSearch(String query) {
    final lowerQuery = query.toLowerCase();
    return title.toLowerCase().contains(lowerQuery) ||
        priority.toLowerCase().contains(lowerQuery) ||
        dueDate.contains(query);
  }
}

class TaskTile extends StatelessWidget {
  final TaskItem task;
  final int index;

  const TaskTile({Key? key, required this.task, required this.index})
      : super(key: key);

  Color getPriorityColor() {
    switch (task.priority.toLowerCase()) {
      case 'critical':
        return Colors.red;
      case 'high':
        return Colors.orange;
      case 'medium':
        return Colors.yellow;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            task.isCompleted
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: task.isCompleted ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    decoration:
                        task.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: getPriorityColor().withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        task.priority,
                        style: TextStyle(
                          fontSize: 12,
                          color: getPriorityColor(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Due: ${task.dueDate}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
