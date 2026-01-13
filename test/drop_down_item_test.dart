import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ff_drop_down_list/ff_drop_down_list.dart';

void main() {
  group('DropDownItem', () {
    test('should create DropDownItem with default isSelected false', () {
      final item = DropDownItem<String>('test');
      expect(item.data, 'test');
      expect(item.isSelected, false);
    });

    test('should create DropDownItem with custom isSelected', () {
      final item = DropDownItem<String>('test', isSelected: true);
      expect(item.data, 'test');
      expect(item.isSelected, true);
    });

    test('should create selected DropDownItem using named constructor', () {
      final item = DropDownItem<String>.selected('test');
      expect(item.data, 'test');
      expect(item.isSelected, true);
    });

    test('should create unselected DropDownItem using named constructor', () {
      final item = DropDownItem<String>.unselected('test');
      expect(item.data, 'test');
      expect(item.isSelected, false);
    });

    test('should create DropDownItem list from raw list', () {
      const items = ['a', 'b', 'c'];
      final dropDownItems = DropDownItem.list(items);

      expect(dropDownItems.length, 3);
      expect(dropDownItems[0].data, 'a');
      expect(dropDownItems[1].data, 'b');
      expect(dropDownItems[2].data, 'c');
      expect(dropDownItems.every((item) => !item.isSelected), true);
    });

    test('select() should set isSelected to true by default', () {
      final item = DropDownItem<String>('test');
      item.select();
      expect(item.isSelected, true);
    });

    test('select() should set isSelected to specified value', () {
      final item = DropDownItem<String>('test', isSelected: true);
      item.select(false);
      expect(item.isSelected, false);
    });

    test('deselect() should set isSelected to false by default', () {
      final item = DropDownItem<String>('test', isSelected: true);
      item.deselect();
      expect(item.isSelected, false);
    });

    test('deselect() should set isSelected to true when deselect is false', () {
      final item = DropDownItem<String>('test');
      item.deselect(false);
      expect(item.isSelected, true);
    });

    test('toString() should return data.toString()', () {
      final item = DropDownItem<String>('test');
      expect(item.toString(), 'test');
    });

    test('compareTo() should compare data as Comparable', () {
      final item1 = DropDownItem<String>('b');
      final item2 = DropDownItem<String>('a');

      expect(item1.compareTo(item2), greaterThan(0));
      expect(item2.compareTo(item1), lessThan(0));
      expect(item1.compareTo(item1), equals(0));
    });

    testWidgets('build() should return Text widget with toString() content',
        (WidgetTester tester) async {
      final item = DropDownItem<String>('test');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => item.build(context, 0),
            ),
          ),
        ),
      );

      expect(find.text('test'), findsOneWidget);
    });

    testWidgets(
        'build() should use DropDownItemBuilder when data implements it',
        (WidgetTester tester) async {
      final customData = CustomDropDownItemBuilder('test');
      final item = DropDownItem<CustomDropDownItemBuilder>(customData);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => item.build(context, 0),
            ),
          ),
        ),
      );

      expect(find.text('Custom: test'), findsOneWidget);
    });

    test('satisfiesSearch() should return true for case-insensitive match', () {
      final item = DropDownItem<String>('Test String');
      expect(item.satisfiesSearch('test'), true);
      expect(item.satisfiesSearch('STRING'), true);
      expect(item.satisfiesSearch('test string'), true);
    });

    test('satisfiesSearch() should return false for no match', () {
      final item = DropDownItem<String>('Test String');
      expect(item.satisfiesSearch('nomatch'), false);
    });

    test(
        'satisfiesSearch() should use DropDownItemSearchable when data implements it',
        () {
      final customData = CustomDropDownItemSearchable('test');
      final item = DropDownItem<CustomDropDownItemSearchable>(customData);

      expect(item.satisfiesSearch('custom_test'), true);
      expect(item.satisfiesSearch('test'), false);
    });
  });

  group('DropDownItem Extensions', () {
    test('ListAsDropDownItems should convert list to DropDownItem list', () {
      final items = ['a', 'b', 'c'];
      final dropDownItems = items.asDropDownItems();

      expect(dropDownItems.length, 3);
      expect(dropDownItems[0].data, 'a');
      expect(dropDownItems[1].data, 'b');
      expect(dropDownItems[2].data, 'c');
    });
  });

  group('DropDownListExtensions', () {
    late DropDownList<String> items;

    setUp(() {
      items = [
        DropDownItem<String>('a', isSelected: true),
        DropDownItem<String>('b', isSelected: false),
        DropDownItem<String>('c', isSelected: true),
      ];
    });

    test('asItemData() should convert to list of data', () {
      final data = items.asItemData();
      expect(data, ['a', 'b', 'c']);
    });

    test('selectAll() should set all items to selected', () {
      items.selectAll();
      expect(items.every((item) => item.isSelected), true);
    });

    test('selectAll(false) should set all items to unselected', () {
      items.selectAll(false);
      expect(items.every((item) => !item.isSelected), true);
    });

    test('deselectAll() should set all items to unselected', () {
      items.deselectAll();
      expect(items.every((item) => !item.isSelected), true);
    });

    test('deselectAll(false) should set all items to selected', () {
      items.deselectAll(false);
      expect(items.every((item) => item.isSelected), true);
    });

    test('select() should select items with matching data', () {
      items.select(['a', 'c']);
      expect(items[0].isSelected, true);
      expect(items[1].isSelected, false);
      expect(items[2].isSelected, true);
    });

    test('select() with deselectOthers should deselect non-matching items', () {
      items.select(['b'], select: true, deselectOthers: true);
      expect(items[0].isSelected, false);
      expect(items[1].isSelected, true);
      expect(items[2].isSelected, false);
    });

    test('deselect() should deselect items with matching data', () {
      items.deselect(['a', 'c']);
      expect(items[0].isSelected, false);
      expect(items[1].isSelected, false);
      expect(items[2].isSelected, false);
    });

    test('deselect() with selectOthers should select non-matching items', () {
      items.deselect(['a'], deselect: true, selectOthers: true);
      expect(items[0].isSelected, false);
      expect(items[1].isSelected, true);
      expect(items[2].isSelected, true);
    });

    test('selected should return only selected items', () {
      final selected = items.selected;
      expect(selected.length, 2);
      expect(selected[0].data, 'a');
      expect(selected[1].data, 'c');
    });

    test('unselected should return only unselected items', () {
      final unselected = items.unselected;
      expect(unselected.length, 1);
      expect(unselected[0].data, 'b');
    });

    test('search() should filter items based on query', () {
      final searchItems = [
        DropDownItem<String>('apple'),
        DropDownItem<String>('banana'),
        DropDownItem<String>('apricot'),
      ];

      final results = searchItems.search('ap');
      expect(results.length, 2);
      expect(results[0].data, 'apple');
      expect(results[1].data, 'apricot');
    });
  });
}

class CustomDropDownItemBuilder implements DropDownItemBuilder {
  final String data;

  CustomDropDownItemBuilder(this.data);

  @override
  Widget build(BuildContext context, int index) {
    return Text('Custom: $data');
  }
}

class CustomDropDownItemSearchable implements DropDownItemSearchable {
  final String data;

  CustomDropDownItemSearchable(this.data);

  @override
  bool satisfiesSearch(String query) => query == 'custom_$data';
}
