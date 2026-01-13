import 'package:flutter_test/flutter_test.dart';
import 'package:ff_drop_down_list/ff_drop_down_list.dart';

void main() {
  group('DropDownResponse', () {
    test('should create DropDownResponse with single item', () {
      final items = [DropDownItem<String>('test')];
      final response = DropDownResponse<String>(
        items: items,
        single: items[0],
        multiple: null,
        multipleSelection: false,
      );

      expect(response.items, items);
      expect(response.single, items[0]);
      expect(response.multiple, null);
      expect(response.multipleSelection, false);
      expect(response.data, ['test']);
    });

    test('should create DropDownResponse with multiple items', () {
      final items = [
        DropDownItem<String>('a'),
        DropDownItem<String>('b'),
      ];
      final response = DropDownResponse<String>(
        items: items,
        single: null,
        multiple: items,
        multipleSelection: true,
      );

      expect(response.items, items);
      expect(response.single, null);
      expect(response.multiple, items);
      expect(response.multipleSelection, true);
      expect(response.data, ['a', 'b']);
    });

    test('should create DropDownResponse.single with single item', () {
      final item = DropDownItem<String>('test');
      final response = DropDownResponse<String>.single(item);

      expect(response.items, [item]);
      expect(response.single, item);
      expect(response.multiple, null);
      expect(response.multipleSelection, false);
      expect(response.data, ['test']);
    });

    test('should create DropDownResponse.multiple with multiple items', () {
      final items = [
        DropDownItem<String>('a'),
        DropDownItem<String>('b'),
      ];
      final response = DropDownResponse<String>.multiple(items);

      expect(response.items, items);
      expect(response.single, null);
      expect(response.multiple, items);
      expect(response.multipleSelection, true);
      expect(response.data, ['a', 'b']);
    });

    test('data should return list of data from items', () {
      final items = [
        DropDownItem<String>('a'),
        DropDownItem<String>('b'),
        DropDownItem<String>('c'),
      ];
      final response = DropDownResponse<String>(
        items: items,
        multipleSelection: true,
      );

      expect(response.data, ['a', 'b', 'c']);
    });

    test('data should return empty list for empty items', () {
      final items = <DropDownItem<String>>[];
      final response = DropDownResponse<String>(
        items: items,
        multipleSelection: true,
      );

      expect(response.data, []);
    });

    test('data should handle complex data types', () {
      final items = [
        DropDownItem<TestModel>(TestModel('test1', 1)),
        DropDownItem<TestModel>(TestModel('test2', 2)),
      ];
      final response = DropDownResponse<TestModel>(
        items: items,
        multipleSelection: true,
      );

      final data = response.data;
      expect(data.length, 2);
      expect(data[0].name, 'test1');
      expect(data[0].value, 1);
      expect(data[1].name, 'test2');
      expect(data[1].value, 2);
    });

    test('should handle empty items for single response', () {
      final items = <DropDownItem<String>>[];
      final response = DropDownResponse<String>(
        items: items,
        single: null,
        multipleSelection: false,
      );

      expect(response.items, []);
      expect(response.single, null);
      expect(response.multiple, null);
      expect(response.data, []);
    });

    test('should handle empty items for multiple response', () {
      final items = <DropDownItem<String>>[];
      final response = DropDownResponse<String>(
        items: items,
        multiple: items,
        multipleSelection: true,
      );

      expect(response.items, []);
      expect(response.single, null);
      expect(response.multiple, items);
      expect(response.multipleSelection, true);
      expect(response.data, []);
    });

    test('should maintain type safety', () {
      final intItem = DropDownItem<int>(42);
      final stringItem = DropDownItem<String>('test');
      final testModelItem = DropDownItem<TestModel>(TestModel('test', 1));

      final intResponse = DropDownResponse<int>.single(intItem);
      final stringResponse = DropDownResponse<String>.single(stringItem);
      final testModelResponse =
          DropDownResponse<TestModel>.single(testModelItem);

      expect(intResponse, isA<DropDownResponse<int>>());
      expect(stringResponse, isA<DropDownResponse<String>>());
      expect(testModelResponse, isA<DropDownResponse<TestModel>>());

      expect(intResponse.data, [42]);
      expect(stringResponse.data, ['test']);
      expect(testModelResponse.data, [TestModel('test', 1)]);
    });

    test('should handle null values correctly', () {
      final items = [DropDownItem<String>('test')];
      final response = DropDownResponse<String>(
        items: items,
        single: null,
        multiple: null,
        multipleSelection: false,
      );

      expect(response.single, null);
      expect(response.multiple, null);
      expect(response.multipleSelection, false);
    });

    test('should handle both single and multiple as null', () {
      final items = <DropDownItem<String>>[];
      final response = DropDownResponse<String>(
        items: items,
        single: null,
        multiple: null,
        multipleSelection: false,
      );

      expect(response.single, null);
      expect(response.multiple, null);
      expect(response.multipleSelection, false);
    });

    test('should handle mixed selection states', () {
      final items = [
        DropDownItem<String>('a', isSelected: true),
        DropDownItem<String>('b', isSelected: false),
      ];

      // Test with multipleSelection: true
      final multipleResponse = DropDownResponse<String>(
        items: items,
        multipleSelection: true,
      );
      expect(multipleResponse.multipleSelection, true);
      expect(multipleResponse.data, ['a', 'b']); // All items are included

      // Test with multipleSelection: false
      final singleResponse = DropDownResponse<String>(
        items: items,
        single: items[0],
        multipleSelection: false,
      );
      expect(singleResponse.multipleSelection, false);
      expect(singleResponse.data, ['a', 'b']); // All items are included in data
    });
  });
}

class TestModel {
  final String name;
  final int value;

  TestModel(this.name, this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          value == other.value;

  @override
  int get hashCode => name.hashCode ^ value.hashCode;

  @override
  String toString() => 'TestModel(name: $name, value: $value)';
}
