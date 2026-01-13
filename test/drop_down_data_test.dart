import 'package:flutter_test/flutter_test.dart';
import 'package:ff_drop_down_list/ff_drop_down_list.dart';

void main() {
  group('DropDownData', () {
    test('should create DropDownData with items', () {
      final items = [
        DropDownItem<String>('a'),
        DropDownItem<String>('b'),
      ];
      final data = DropDownData<String>(items);

      expect(data.items, items);
      expect(data.future, null);
      expect(data.isFuture, false);
    });

    test('should create DropDownData.raw from list of data', () {
      const rawItems = ['a', 'b', 'c'];
      final data = DropDownData<String>.raw(rawItems);

      expect(data.items?.length, 3);
      expect(data.items?[0].data, 'a');
      expect(data.items?[1].data, 'b');
      expect(data.items?[2].data, 'c');
      expect(data.future, null);
      expect(data.isFuture, false);
    });

    test('should create DropDownData.future from future of items', () {
      final futureItems = Future.value([
        DropDownItem<String>('x'),
        DropDownItem<String>('y'),
      ]);
      final data = DropDownData<String>.future(futureItems);

      expect(data.items, null);
      expect(data.future, futureItems);
      expect(data.isFuture, true);
    });

    test('should create DropDownData.rawFuture from future of raw data', () {
      final futureRawItems = Future.value(['x', 'y', 'z']);
      final data = DropDownData<String>.rawFuture(futureRawItems);

      expect(data.items, null);
      expect(data.future, isNotNull);
      expect(data.isFuture, true);
    });

    test('should create DropDownData.from from list of items', () {
      final items = [
        DropDownItem<String>('a'),
        DropDownItem<String>('b'),
      ];
      final data = DropDownData<String>.from(items);

      expect(data.items, items);
      expect(data.future, null);
      expect(data.isFuture, false);
    });

    test('should create DropDownData.from from future of items', () {
      final futureItems = Future.value([
        DropDownItem<String>('x'),
        DropDownItem<String>('y'),
      ]);
      final data = DropDownData<String>.from(futureItems);

      expect(data.items, null);
      expect(data.future, futureItems);
      expect(data.isFuture, true);
    });

    test('should create DropDownData.fromRaw from list of raw data', () {
      const rawItems = ['a', 'b', 'c'];
      final data = DropDownData<String>.fromRaw(rawItems);

      expect(data.items?.length, 3);
      expect(data.items?[0].data, 'a');
      expect(data.items?[1].data, 'b');
      expect(data.items?[2].data, 'c');
      expect(data.future, null);
      expect(data.isFuture, false);
    });

    test('should create DropDownData.fromRaw from future of raw data', () {
      final futureRawItems = Future.value(['x', 'y', 'z']);
      final data = DropDownData<String>.fromRaw(futureRawItems);

      expect(data.items, null);
      expect(data.future, isNotNull);
      expect(data.isFuture, true);
    });

    test('selectAll() should select all items when items exist', () {
      final items = [
        DropDownItem<String>('a', isSelected: false),
        DropDownItem<String>('b', isSelected: false),
      ];
      final data = DropDownData<String>(items);

      data.selectAll();

      expect(items[0].isSelected, true);
      expect(items[1].isSelected, true);
    });

    test('selectAll(false) should deselect all items when items exist', () {
      final items = [
        DropDownItem<String>('a', isSelected: true),
        DropDownItem<String>('b', isSelected: true),
      ];
      final data = DropDownData<String>(items);

      data.selectAll(false);

      expect(items[0].isSelected, false);
      expect(items[1].isSelected, false);
    });

    test('selectAll() should not throw when items is null', () {
      final data = DropDownData<String>.future(Future.value([]));

      expect(() => data.selectAll(), returnsNormally);
    });

    test('deselectAll() should deselect all items when items exist', () {
      final items = [
        DropDownItem<String>('a', isSelected: true),
        DropDownItem<String>('b', isSelected: true),
      ];
      final data = DropDownData<String>(items);

      data.deselectAll();

      expect(items[0].isSelected, false);
      expect(items[1].isSelected, false);
    });

    test('deselectAll(false) should select all items when items exist', () {
      final items = [
        DropDownItem<String>('a', isSelected: false),
        DropDownItem<String>('b', isSelected: false),
      ];
      final data = DropDownData<String>(items);

      data.deselectAll(false);

      expect(items[0].isSelected, true);
      expect(items[1].isSelected, true);
    });

    test('deselectAll() should not throw when items is null', () {
      final data = DropDownData<String>.future(Future.value([]));

      expect(() => data.deselectAll(), returnsNormally);
    });

    test('select() should select items with matching data', () {
      final items = [
        DropDownItem<String>('a', isSelected: false),
        DropDownItem<String>('b', isSelected: false),
        DropDownItem<String>('c', isSelected: false),
      ];
      final data = DropDownData<String>(items);

      data.select(['a', 'c']);

      expect(items[0].isSelected, true);
      expect(items[1].isSelected, false);
      expect(items[2].isSelected, true);
    });

    test('select() with deselectOthers should deselect non-matching items', () {
      final items = [
        DropDownItem<String>('a', isSelected: true),
        DropDownItem<String>('b', isSelected: true),
        DropDownItem<String>('c', isSelected: true),
      ];
      final data = DropDownData<String>(items);

      data.select(['b'], select: true, deselectOthers: true);

      expect(items[0].isSelected, false);
      expect(items[1].isSelected, true);
      expect(items[2].isSelected, false);
    });

    test('select() should not throw when items is null', () {
      final data = DropDownData<String>.future(Future.value([]));

      expect(() => data.select(['a']), returnsNormally);
    });

    test('deselect() should deselect items with matching data', () {
      final items = [
        DropDownItem<String>('a', isSelected: true),
        DropDownItem<String>('b', isSelected: true),
        DropDownItem<String>('c', isSelected: true),
      ];
      final data = DropDownData<String>(items);

      data.deselect(['a', 'c']);

      expect(items[0].isSelected, false);
      expect(items[1].isSelected, true);
      expect(items[2].isSelected, false);
    });

    test('deselect() with selectOthers should select non-matching items', () {
      final items = [
        DropDownItem<String>('a', isSelected: true),
        DropDownItem<String>('b', isSelected: false),
        DropDownItem<String>('c', isSelected: true),
      ];
      final data = DropDownData<String>(items);

      data.deselect(['a'], deselect: true, selectOthers: true);

      expect(items[0].isSelected, false);
      expect(items[1].isSelected, true);
      expect(items[2].isSelected, true);
    });

    test('deselect() should not throw when items is null', () {
      final data = DropDownData<String>.future(Future.value([]));

      expect(() => data.deselect(['a']), returnsNormally);
    });

    test('rawFuture constructor should convert raw items to DropDownItems',
        () async {
      final futureRawItems = Future.value(['x', 'y', 'z']);
      final data = DropDownData<String>.rawFuture(futureRawItems);

      final items = await data.future!;

      expect(items.length, 3);
      expect(items[0].data, 'x');
      expect(items[1].data, 'y');
      expect(items[2].data, 'z');
      expect(items.every((item) => !item.isSelected), true);
    });

    test(
        'fromRaw constructor with future should convert raw items to DropDownItems',
        () async {
      final futureRawItems = Future.value(['x', 'y', 'z']);
      final data = DropDownData<String>.fromRaw(futureRawItems);

      final items = await data.future!;

      expect(items.length, 3);
      expect(items[0].data, 'x');
      expect(items[1].data, 'y');
      expect(items[2].data, 'z');
      expect(items.every((item) => !item.isSelected), true);
    });
  });
}
