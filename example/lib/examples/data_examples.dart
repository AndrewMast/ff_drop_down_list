import 'dart:async';
import 'dart:math';
import 'package:ff_drop_down_list/ff_drop_down_list.dart';
import 'package:flutter/material.dart';

class DataExamples {
  static void showFutureDataExample(BuildContext context) {
    DropDown<String>(
      data: DropDownData.future(_loadCountriesWithDelay()),
      options: DropDownOptions(
        onSingleSelected: (item) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected country: ${item.data}')),
          );
        },
      ),
      style: DropDownStyle(
        headerWidget: const Text(
          'Countries Loading from Future',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        dataLoadingWidget: const Center(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Loading countries from server...'),
                SizedBox(height: 8),
                Text('Please wait',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ),
        dataFailureWidget: const Center(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, size: 48, color: Colors.red),
                SizedBox(height: 16),
                Text('Failed to load countries'),
                SizedBox(height: 8),
                Text('Check your internet connection',
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ),
      ),
    ).show(context);
  }

  static void showFutureWithErrorExample(BuildContext context) {
    DropDown<String>(
      data: DropDownData.future(_simulateNetworkError()),
      options: DropDownOptions(
        onSingleSelected: (item) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected: ${item.data}')),
          );
        },
      ),
      style: DropDownStyle(
        headerWidget: const Text(
          'Network Request (Will Fail)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        dataFailureText: 'Network error occurred. Please try again.',
        dataFailureWidget: const Center(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.wifi_off, size: 48, color: Colors.red),
                SizedBox(height: 16),
                Text('Network Connection Failed'),
                SizedBox(height: 8),
                Text('Unable to connect to server',
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ),
      ),
    ).show(context);
  }

  static void showEmptyDataExample(BuildContext context) {
    DropDown<String>(
      data: DropDownData.raw([]),
      options: DropDownOptions(
        onSingleSelected: (item) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected: ${item.data}')),
          );
        },
      ),
      style: DropDownStyle(
        headerWidget: const Text(
          'Empty Data Source',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        emptyListText: 'No items available in this list.',
        emptyListWidget: const Center(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No Items Available',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('This list is currently empty'),
                SizedBox(height: 8),
                Text('Check back later for updates',
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ),
        isSearchVisible: false,
      ),
    ).show(context);
  }

  static void showLargeDataSetExample(BuildContext context) {
    final items = _generateLargeDataSet(1000);

    DropDown<String>(
      data: DropDownData.raw(items),
      options: DropDownOptions(
        onSingleSelected: (item) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected: ${item.data}')),
          );
        },
        listViewListener: (notification) {
          // Listen to scroll events for analytics
          if (notification is ScrollEndNotification) {
            final metrics = notification.metrics;
            if (metrics.pixels == metrics.maxScrollExtent) {
              // User reached the bottom
              debugPrint('User scrolled to bottom of list');
            }
          }
          return true;
        },
      ),
      style: DropDownStyle(
        headerWidget: Text(
          'Large Dataset (${items.length} items)',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        searchHintText: 'Search through ${items.length} items...',
        dataLoadingWidget: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ).show(context);
  }

  static void showPreSelectedItemsExample(BuildContext context) {
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    // Create DropDownItems with some pre-selected
    final dropDownItems = days.map((day) {
      return DropDownItem(day,
          isSelected: ['Wednesday', 'Friday', 'Sunday'].contains(day));
    }).toList();

    DropDown<String>(
      data: DropDownData(dropDownItems),
      options: DropDownOptions(
        enableMultipleSelection: true,
        onSelected: (selectedItems) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Selected days: ${selectedItems.asItemData().join(', ')}')),
          );
        },
      ),
      style: DropDownStyle(
        headerWidget: const Text(
          'Select Work Days (Some Pre-selected)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        isSelectAllVisible: true,
      ),
    ).show(context);
  }

  // Helper methods
  static Future<DropDownList<String>> _loadCountriesWithDelay() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
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
      'Spain',
      'Italy',
      'South Korea',
      'Netherlands',
      'Switzerland',
      'Sweden',
      'Norway'
    ].map((country) => DropDownItem(country)).toList();
  }

  static Future<DropDownList<String>> _simulateNetworkError() async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception('Network connection failed');
  }

  static List<String> _generateLargeDataSet(int count) {
    final items = <String>[];
    final random = Random();

    for (int i = 0; i < count; i++) {
      final category =
          ['Product', 'Service', 'Item', 'Option'][random.nextInt(4)];
      final number = i + 1;
      final adjective =
          ['Premium', 'Basic', 'Advanced', 'Standard'][random.nextInt(4)];
      items.add('$adjective $category $number');
    }

    return items;
  }
}
