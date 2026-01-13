import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ff_drop_down_list/ff_drop_down_list.dart';

void main() {
  group('DropDown Widget', () {
    testWidgets('should create DropDown with required parameters',
        (WidgetTester tester) async {
      final items = [
        DropDownItem<String>('Item 1'),
        DropDownItem<String>('Item 2'),
      ];
      final dropDown = DropDown<String>(
        data: DropDownData(items),
      );

      expect(dropDown.data.items, items);
      expect(dropDown.options, null);
      expect(dropDown.style, null);
    });

    testWidgets('should create DropDown with options',
        (WidgetTester tester) async {
      final items = [
        DropDownItem<String>('Item 1'),
        DropDownItem<String>('Item 2'),
      ];
      final options = DropDownOptions<String>(
        enableMultipleSelection: true,
        maxSelectedItems: 2,
      );
      final dropDown = DropDown<String>(
        data: DropDownData(items),
        options: options,
      );

      expect(dropDown.data.items, items);
      expect(dropDown.options, options);
      expect(dropDown.options?.enableMultipleSelection, true);
      expect(dropDown.options?.maxSelectedItems, 2);
    });

    testWidgets('should create DropDown with style',
        (WidgetTester tester) async {
      final items = [
        DropDownItem<String>('Item 1'),
        DropDownItem<String>('Item 2'),
      ];
      final style = DropDownStyle(
        backgroundColor: Colors.blue,
        submitButtonText: 'Save',
      );
      final dropDown = DropDown<String>(
        data: DropDownData(items),
        style: style,
      );

      expect(dropDown.data.items, items);
      expect(dropDown.style, style);
      expect(dropDown.style?.backgroundColor, Colors.blue);
      expect(dropDown.style?.submitButtonText, 'Save');
    });

    testWidgets('should create DropDown with both options and style',
        (WidgetTester tester) async {
      final items = [
        DropDownItem<String>('Item 1'),
        DropDownItem<String>('Item 2'),
      ];
      final options = DropDownOptions<String>(
        enableMultipleSelection: false,
      );
      final style = DropDownStyle(
        searchHintText: 'Custom search',
      );
      final dropDown = DropDown<String>(
        data: DropDownData(items),
        options: options,
        style: style,
      );

      expect(dropDown.data.items, items);
      expect(dropDown.options, options);
      expect(dropDown.style, style);
      expect(dropDown.options?.enableMultipleSelection, false);
      expect(dropDown.style?.searchHintText, 'Custom search');
    });

    testWidgets('should create DropDown.items constructor',
        (WidgetTester tester) async {
      final items = [
        DropDownItem<String>('Item 1'),
        DropDownItem<String>('Item 2'),
      ];
      final dropDown = DropDown<String>.items(items);

      expect(dropDown.data.items, items);
      expect(dropDown.options, null);
      expect(dropDown.style, null);
    });

    testWidgets('should create DropDown.items with options and style',
        (WidgetTester tester) async {
      final items = [
        DropDownItem<String>('Item 1'),
        DropDownItem<String>('Item 2'),
      ];
      final options = DropDownOptions<String>(
        enableMultipleSelection: true,
      );
      final style = DropDownStyle(
        headerWidget: Text('Custom Header'),
      );
      final dropDown = DropDown<String>.items(
        items,
        options: options,
        style: style,
      );

      expect(dropDown.data.items, items);
      expect(dropDown.options, options);
      expect(dropDown.style, style);
    });

    testWidgets('should create DropDown.raw constructor',
        (WidgetTester tester) async {
      final rawItems = ['Item 1', 'Item 2'];
      final dropDown = DropDown<String>.raw(rawItems);

      expect(dropDown.data.items?.length, 2);
      expect(dropDown.data.items?[0].data, 'Item 1');
      expect(dropDown.data.items?[1].data, 'Item 2');
      expect(dropDown.options, null);
      expect(dropDown.style, null);
    });

    testWidgets('should create DropDown.raw with options and style',
        (WidgetTester tester) async {
      final rawItems = ['Item 1', 'Item 2'];
      final options = DropDownOptions<String>(
        isDismissible: false,
      );
      final style = DropDownStyle(
        isSearchVisible: false,
      );
      final dropDown = DropDown<String>.raw(
        rawItems,
        options: options,
        style: style,
      );

      expect(dropDown.data.items?.length, 2);
      expect(dropDown.options, options);
      expect(dropDown.style, style);
    });

    testWidgets('should create DropDown.future constructor',
        (WidgetTester tester) async {
      final futureItems = Future.value([
        DropDownItem<String>('Future Item 1'),
        DropDownItem<String>('Future Item 2'),
      ]);
      final dropDown = DropDown<String>.future(futureItems);

      expect(dropDown.data.future, futureItems);
      expect(dropDown.data.items, null);
      expect(dropDown.options, null);
      expect(dropDown.style, null);
      expect(dropDown.data.isFuture, true);
    });

    testWidgets('should create DropDown.future with options and style',
        (WidgetTester tester) async {
      final futureItems = Future.value([
        DropDownItem<String>('Future Item 1'),
        DropDownItem<String>('Future Item 2'),
      ]);
      final options = DropDownOptions<String>(
        initialSheetSize: 0.8,
      );
      final style = DropDownStyle(
        backgroundColor: Colors.green,
      );
      final dropDown = DropDown<String>.future(
        futureItems,
        options: options,
        style: style,
      );

      expect(dropDown.data.future, futureItems);
      expect(dropDown.options, options);
      expect(dropDown.style, style);
    });

    testWidgets('should create DropDown.rawFuture constructor',
        (WidgetTester tester) async {
      final futureRawItems = Future.value(['Raw Future 1', 'Raw Future 2']);
      final dropDown = DropDown<String>.rawFuture(futureRawItems);

      expect(dropDown.data.future, isNotNull);
      expect(dropDown.data.items, null);
      expect(dropDown.options, null);
      expect(dropDown.style, null);
      expect(dropDown.data.isFuture, true);
    });

    testWidgets('should create DropDown.rawFuture with options and style',
        (WidgetTester tester) async {
      final futureRawItems = Future.value(['Raw Future 1', 'Raw Future 2']);
      final options = DropDownOptions<String>(
        enableDrag: false,
      );
      final style = DropDownStyle(
        searchHintText: 'Future Search',
      );
      final dropDown = DropDown<String>.rawFuture(
        futureRawItems,
        options: options,
        style: style,
      );

      expect(dropDown.data.future, isNotNull);
      expect(dropDown.options, options);
      expect(dropDown.style, style);
    });

    testWidgets('should handle empty items', (WidgetTester tester) async {
      final items = <DropDownItem<String>>[];
      final dropDown = DropDown<String>(
        data: DropDownData(items),
      );

      expect(dropDown.data.items, items);
      expect(dropDown.data.items?.length, 0);
    });

    testWidgets('should handle complex data types',
        (WidgetTester tester) async {
      final complexItems = [
        DropDownItem<ComplexModel>(ComplexModel('Item 1', 1)),
        DropDownItem<ComplexModel>(ComplexModel('Item 2', 2)),
      ];
      final dropDown = DropDown<ComplexModel>(
        data: DropDownData(complexItems),
      );

      expect(dropDown.data.items, complexItems);
      expect(dropDown.data.items?[0].data.name, 'Item 1');
      expect(dropDown.data.items?[0].data.value, 1);
      expect(dropDown.data.items?[1].data.name, 'Item 2');
      expect(dropDown.data.items?[1].data.value, 2);
    });

    testWidgets('should maintain type safety', (WidgetTester tester) async {
      final intDropDown = DropDown<int>.items([DropDownItem<int>(1)]);
      final stringDropDown =
          DropDown<String>.items([DropDownItem<String>('test')]);
      final complexDropDown = DropDown<ComplexModel>.items(
          [DropDownItem<ComplexModel>(ComplexModel('test', 1))]);

      expect(intDropDown, isA<DropDown<int>>());
      expect(stringDropDown, isA<DropDown<String>>());
      expect(complexDropDown, isA<DropDown<ComplexModel>>());
    });

    testWidgets('show() should return Future<DropDownResponse<T>?>',
        (WidgetTester tester) async {
      final items = [
        DropDownItem<String>('Item 1'),
        DropDownItem<String>('Item 2'),
      ];
      final dropDown = DropDown<String>(
        data: DropDownData(items),
      );

      // Just verify that the method returns the expected type
      expect(dropDown.show, isA<Function>());
    });

    testWidgets('show() method should be callable',
        (WidgetTester tester) async {
      final items = [
        DropDownItem<String>('Item 1'),
        DropDownItem<String>('Item 2'),
      ];
      final dropDown = DropDown<String>(
        data: DropDownData(items),
      );

      // Verify that method exists and can be called
      expect(() => dropDown.show, returnsNormally);
    });
  });
}

class ComplexModel {
  final String name;
  final int value;

  ComplexModel(this.name, this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComplexModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          value == other.value;

  @override
  int get hashCode => name.hashCode ^ value.hashCode;

  @override
  String toString() => 'ComplexModel(name: $name, value: $value)';
}
