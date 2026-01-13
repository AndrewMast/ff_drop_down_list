import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ff_drop_down_list/ff_drop_down_list.dart';

void main() {
  group('DropDownOptions', () {
    test('should create DropDownOptions with default values', () {
      final options = DropDownOptions<String>();

      expect(options.enableMultipleSelection, false);
      expect(options.maxSelectedItems, null);
      expect(options.submitOnMaxSelectionReached, false);
      expect(options.onMaxSelectionReached, null);
      expect(options.onSelected, null);
      expect(options.onMultipleSelected, null);
      expect(options.onSingleSelected, null);
      expect(options.listItemBuilder, null);
      expect(options.searchOnEmpty, false);
      expect(options.searchDelegate, null);
      expect(options.sortAfterSearch, false);
      expect(options.sortDelegate, null);
      expect(options.useRootNavigator, false);
      expect(options.enableDrag, true);
      expect(options.isDismissible, true);
      expect(options.initialSheetSize, 0.7);
      expect(options.minSheetSize, 0.3);
      expect(options.maxSheetSize, 0.9);
      expect(options.bottomSheetListener, null);
      expect(options.listViewListener, null);
    });

    test('should create DropDownOptions with custom values', () {
      bool onMaxSelectionReachedCalled = false;
      bool onSelectedCalled = false;
      bool onMultipleSelectedCalled = false;
      bool onSingleSelectedCalled = false;
      bool listItemBuilderCalled = false;
      bool searchDelegateCalled = false;
      bool sortDelegateCalled = false;
      bool bottomSheetListenerCalled = false;
      bool listViewListenerCalled = false;

      void onMaxSelectionReached() => onMaxSelectionReachedCalled = true;
      void onSelected(List<DropDownItem<String>> items) =>
          onSelectedCalled = true;
      void onMultipleSelected(List<DropDownItem<String>> items) =>
          onMultipleSelectedCalled = true;
      void onSingleSelected(DropDownItem<String> item) =>
          onSingleSelectedCalled = true;
      Widget listItemBuilder(int index, DropDownItem<String> item) {
        listItemBuilderCalled = true;
        return Container();
      }

      List<DropDownItem<String>> searchDelegate(
          String query, List<DropDownItem<String>> items) {
        searchDelegateCalled = true;
        return [];
      }

      int sortDelegate(DropDownItem<String> a, DropDownItem<String> b) {
        sortDelegateCalled = true;
        return 0;
      }

      bool bottomSheetListener(DraggableScrollableNotification notification) =>
          bottomSheetListenerCalled = true;
      bool listViewListener(ScrollNotification notification) =>
          listViewListenerCalled = true;

      final options = DropDownOptions<String>(
        enableMultipleSelection: true,
        maxSelectedItems: 5,
        submitOnMaxSelectionReached: true,
        onMaxSelectionReached: onMaxSelectionReached,
        onSelected: onSelected,
        onMultipleSelected: onMultipleSelected,
        onSingleSelected: onSingleSelected,
        listItemBuilder: listItemBuilder,
        searchOnEmpty: true,
        searchDelegate: searchDelegate,
        sortAfterSearch: true,
        sortDelegate: sortDelegate,
        useRootNavigator: true,
        enableDrag: false,
        isDismissible: false,
        initialSheetSize: 0.8,
        minSheetSize: 0.4,
        maxSheetSize: 0.95,
        bottomSheetListener: bottomSheetListener,
        listViewListener: listViewListener,
      );

      expect(options.enableMultipleSelection, true);
      expect(options.maxSelectedItems, 5);
      expect(options.submitOnMaxSelectionReached, true);
      expect(options.onMaxSelectionReached, isNotNull);
      expect(options.onSelected, isNotNull);
      expect(options.onMultipleSelected, isNotNull);
      expect(options.onSingleSelected, isNotNull);
      expect(options.listItemBuilder, isNotNull);
      expect(options.searchOnEmpty, true);
      expect(options.searchDelegate, isNotNull);
      expect(options.sortAfterSearch, true);
      expect(options.sortDelegate, isNotNull);
      expect(options.useRootNavigator, true);
      expect(options.enableDrag, false);
      expect(options.isDismissible, false);
      expect(options.initialSheetSize, 0.8);
      expect(options.minSheetSize, 0.4);
      expect(options.maxSheetSize, 0.95);
      expect(options.bottomSheetListener, isNotNull);
      expect(options.listViewListener, isNotNull);

      // Test that callbacks are properly set
      options.onMaxSelectionReached!();
      expect(onMaxSelectionReachedCalled, true);

      options.onSelected!([]);
      expect(onSelectedCalled, true);

      options.onMultipleSelected!([]);
      expect(onMultipleSelectedCalled, true);

      options.onSingleSelected!(DropDownItem<String>('test'));
      expect(onSingleSelectedCalled, true);

      options.listItemBuilder!(0, DropDownItem<String>('test'));
      expect(listItemBuilderCalled, true);

      options.searchDelegate!('', []);
      expect(searchDelegateCalled, true);

      options.sortDelegate!(
          DropDownItem<String>('a'), DropDownItem<String>('b'));
      expect(sortDelegateCalled, true);

// Test that notification listeners are properly set (skip actual notification testing)
      expect(options.bottomSheetListener, isNotNull);
      expect(options.listViewListener, isNotNull);
    });

    test('should create DropDownOptions with partial custom values', () {
      final options = DropDownOptions<String>(
        enableMultipleSelection: true,
        maxSelectedItems: 3,
      );

      expect(options.enableMultipleSelection, true);
      expect(options.maxSelectedItems, 3);
      expect(options.submitOnMaxSelectionReached, false);
      expect(options.useRootNavigator, false);
      expect(options.enableDrag, true);
      expect(options.isDismissible, true);
      expect(options.initialSheetSize, 0.7);
      expect(options.minSheetSize, 0.3);
      expect(options.maxSheetSize, 0.9);
    });

    test('should handle null callbacks', () {
      final options = DropDownOptions<String>(
        onSelected: null,
        onMultipleSelected: null,
        onSingleSelected: null,
        onMaxSelectionReached: null,
        listItemBuilder: null,
        searchDelegate: null,
        sortDelegate: null,
        bottomSheetListener: null,
        listViewListener: null,
      );

      expect(options.onSelected, null);
      expect(options.onMultipleSelected, null);
      expect(options.onSingleSelected, null);
      expect(options.onMaxSelectionReached, null);
      expect(options.listItemBuilder, null);
      expect(options.searchDelegate, null);
      expect(options.sortDelegate, null);
      expect(options.bottomSheetListener, null);
      expect(options.listViewListener, null);
    });

    test('should accept valid sheet size values', () {
      final options1 = DropDownOptions<String>(initialSheetSize: 0.5);
      final options2 = DropDownOptions<String>(minSheetSize: 0.2);
      final options3 = DropDownOptions<String>(maxSheetSize: 1.0);

      expect(options1.initialSheetSize, 0.5);
      expect(options2.minSheetSize, 0.2);
      expect(options3.maxSheetSize, 1.0);
    });

    test('should handle boolean flags correctly', () {
      final options = DropDownOptions<String>(
        enableMultipleSelection: true,
        submitOnMaxSelectionReached: true,
        searchOnEmpty: true,
        sortAfterSearch: true,
        useRootNavigator: true,
        enableDrag: false,
        isDismissible: false,
      );

      expect(options.enableMultipleSelection, true);
      expect(options.submitOnMaxSelectionReached, true);
      expect(options.searchOnEmpty, true);
      expect(options.sortAfterSearch, true);
      expect(options.useRootNavigator, true);
      expect(options.enableDrag, false);
      expect(options.isDismissible, false);
    });

    test('should accept maxSelectedItems as null', () {
      final options = DropDownOptions<String>(
        maxSelectedItems: null,
      );

      expect(options.maxSelectedItems, null);
    });

    test('should accept maxSelectedItems as integer', () {
      final options = DropDownOptions<String>(
        maxSelectedItems: 10,
      );

      expect(options.maxSelectedItems, 10);
    });

    test('should maintain type safety for generic parameter', () {
      final options = DropDownOptions<int>();
      final options2 = DropDownOptions<String>();
      final options3 = DropDownOptions<CustomTestType>();

      expect(options, isA<DropDownOptions<int>>());
      expect(options2, isA<DropDownOptions<String>>());
      expect(options3, isA<DropDownOptions<CustomTestType>>());
    });
  });
}

class CustomTestType {
  final String name;

  CustomTestType(this.name);
}
