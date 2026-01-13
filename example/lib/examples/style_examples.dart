import 'package:ff_drop_down_list/ff_drop_down_list.dart';
import 'package:flutter/material.dart';

class StyleExamples {
  static void showMinimalStyleExample(BuildContext context) {
    final options = [
      'Option 1',
      'Option 2',
      'Option 3',
      'Option 4',
      'Option 5'
    ];

    DropDown<String>(
      data: DropDownData.raw(options),
      options: DropDownOptions(
        onSingleSelected: (item) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected: ${item.data}')),
          );
        },
      ),
      style: DropDownStyle(
        isSearchVisible: false,
        headerWidget: const Text(
          'Minimal Style',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        listSeparator: const SizedBox.shrink(),
        tileContentPadding: EdgeInsets.zero,
      ),
    ).show(context);
  }

  static void showCardStyleExample(BuildContext context) {
    final items = [
      'Card Option 1',
      'Card Option 2',
      'Card Option 3',
      'Card Option 4'
    ];

    DropDown<String>(
      data: DropDownData.raw(items),
      options: DropDownOptions(
        enableMultipleSelection: true,
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
          'Card Style Selection',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.grey.shade100,
        padding: const EdgeInsets.all(16),
        headerPadding: const EdgeInsets.all(16),
        listPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        tileContentPadding: const EdgeInsets.all(12),
        tileColor: Colors.white,
        selectedTileColor: Colors.blue.shade50,
        listSeparator: const SizedBox(height: 8),
        border: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        selectedTileTrailingWidget: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 16),
        ),
        unselectedTileTrailingWidget: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(Icons.check, color: Colors.grey.shade400, size: 16),
        ),
        submitButtonStyle: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        clearButtonStyle: OutlinedButton.styleFrom(
          foregroundColor: Colors.grey.shade700,
          side: BorderSide(color: Colors.grey.shade300),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ).show(context);
  }

  static void showCustomSearchStyleExample(BuildContext context) {
    final colors = [
      'Red',
      'Blue',
      'Green',
      'Yellow',
      'Purple',
      'Orange',
      'Pink',
      'Cyan'
    ];

    DropDown<String>(
      data: DropDownData.raw(colors),
      options: DropDownOptions(
        onSingleSelected: (item) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected color: ${item.data}')),
          );
        },
      ),
      style: DropDownStyle(
        headerWidget: const Text(
          'Custom Search Style',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        searchHintText: 'Search for your favorite color...',
        searchAutofocus: true,
        searchBorderRadius: BorderRadius.circular(12),
        searchFillColor: Colors.purple.shade50,
        searchCursorColor: Colors.purple,
        searchPrefixIcon: Icon(Icons.palette, color: Colors.purple.shade400),
        searchSuffixIcon: Icon(Icons.clear, color: Colors.purple.shade400),
        searchPrefixColor: Colors.purple.shade400,
        searchSuffixColor: Colors.purple.shade400,
        searchHideSuffixWhenEmpty: false,
        searchTextFieldPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    ).show(context);
  }

  static void showCustomButtonStyleExample(BuildContext context) {
    final features = [
      'Dark Mode',
      'Notifications',
      'Auto-save',
      'Cloud Sync',
      'Multi-language'
    ];

    DropDown<String>(
      data: DropDownData.raw(features),
      options: DropDownOptions(
        enableMultipleSelection: true,
        maxSelectedItems: 3,
        onSelected: (selectedItems) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Enabled: ${selectedItems.asItemData().join(', ')}')),
          );
        },
      ),
      style: DropDownStyle(
        headerWidget: const Text(
          'Enable Features (Max 3)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        isSelectAllVisible: true,
        submitButtonChild: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.save, size: 16),
            SizedBox(width: 4),
            Text('Save Settings'),
          ],
        ),
        clearButtonChild: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.refresh, size: 16),
            SizedBox(width: 4),
            Text('Reset'),
          ],
        ),
        selectAllButtonChild: const Text('Select All Features'),
        deselectAllButtonChild: const Text('Deselect All'),
        submitButtonStyle: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        clearButtonStyle: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        selectAllButtonStyle: TextButton.styleFrom(
          foregroundColor: Colors.blue,
        ),
        deselectAllButtonStyle: TextButton.styleFrom(
          foregroundColor: Colors.orange,
        ),
      ),
    ).show(context);
  }
}
