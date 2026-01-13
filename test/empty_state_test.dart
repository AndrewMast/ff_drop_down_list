import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ff_drop_down_list/ff_drop_down_list.dart';

void main() {
  group('Empty State Tests', () {
    testWidgets('should show empty list widget when list is empty',
        (WidgetTester tester) async {
      final emptyWidget = Text('Custom empty message');

      final dropDown = DropDown<String>(
        data: DropDownData<String>([]),
        style: DropDownStyle(
          emptyListWidget: emptyWidget,
        ),
      );

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  await dropDown.show(context);
                },
                child: Text('Open Dropdown'),
              );
            },
          ),
        ),
      ));

      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();

      expect(find.text('Custom empty message'), findsOneWidget);
    });

    testWidgets('should show default empty text when list is empty',
        (WidgetTester tester) async {
      final dropDown = DropDown<String>(
        data: DropDownData<String>([]),
      );

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  await dropDown.show(context);
                },
                child: Text('Open Dropdown'),
              );
            },
          ),
        ),
      ));

      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();

      expect(find.text('No options available.'), findsOneWidget);
    });

    testWidgets('should show custom empty text', (WidgetTester tester) async {
      final dropDown = DropDown<String>(
        data: DropDownData<String>([]),
        style: DropDownStyle(
          emptyListText: 'No data to display',
        ),
      );

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  await dropDown.show(context);
                },
                child: Text('Open Dropdown'),
              );
            },
          ),
        ),
      ));

      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();

      expect(find.text('No data to display'), findsOneWidget);
    });

    testWidgets(
        'should show no search results widget when search has no results',
        (WidgetTester tester) async {
      final items = ['Apple', 'Banana', 'Cherry'].asDropDownItems();

      final dropDown = DropDown<String>(
        data: DropDownData<String>(items),
        style: DropDownStyle(
          emptySearchResultsWidgetBuilder: (String searchQuery, int count) =>
              Text(
                  'No matching items found for "$searchQuery" from $count items'),
        ),
      );

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  await dropDown.show(context);
                },
                child: Text('Open Dropdown'),
              );
            },
          ),
        ),
      ));

      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();

      // Enter search query that will return no results
      await tester.enterText(find.byType(TextFormField), 'xyz');
      await tester.pumpAndSettle();

      expect(find.text('No matching items found for "xyz" from 3 items'),
          findsOneWidget);
    });

    testWidgets('should show default no search results text',
        (WidgetTester tester) async {
      final items = ['Apple', 'Banana', 'Cherry'].asDropDownItems();

      final dropDown = DropDown<String>(
        data: DropDownData<String>(items),
      );

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  await dropDown.show(context);
                },
                child: Text('Open Dropdown'),
              );
            },
          ),
        ),
      ));

      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();

      // Enter search query that will return no results
      await tester.enterText(find.byType(TextFormField), 'xyz');
      await tester.pumpAndSettle();

      expect(find.text('No options found from 3 total'), findsOneWidget);
    });

    testWidgets('should use custom no search results text builder',
        (WidgetTester tester) async {
      final items = ['Apple', 'Banana', 'Cherry'].asDropDownItems();

      final dropDown = DropDown<String>(
        data: DropDownData<String>(items),
        style: DropDownStyle(
          emptySearchResultsTextBuilder: (String searchQuery, int count) =>
              'Found $count items, but no matches for "$searchQuery"',
        ),
      );

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  await dropDown.show(context);
                },
                child: Text('Open Dropdown'),
              );
            },
          ),
        ),
      ));

      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();

      // Enter search query that will return no results
      await tester.enterText(find.byType(TextFormField), 'xyz');
      await tester.pumpAndSettle();

      expect(
          find.text('Found 3 items, but no matches for "xyz"'), findsOneWidget);
    });

    testWidgets('should show items when search has results',
        (WidgetTester tester) async {
      final items = ['Apple', 'Banana', 'Cherry'].asDropDownItems();

      final dropDown = DropDown<String>(
        data: DropDownData<String>(items),
      );

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  await dropDown.show(context);
                },
                child: Text('Open Dropdown'),
              );
            },
          ),
        ),
      ));

      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();

      // Enter search query that will return results
      await tester.enterText(find.byType(TextFormField), 'Apple');
      await tester.pumpAndSettle();

      expect(find.text('Apple'), findsAtLeastNWidgets(1));
      expect(find.text('Banana'), findsNothing);
      expect(find.text('Cherry'), findsNothing);
    });

    testWidgets('should not show empty state when list has items and no search',
        (WidgetTester tester) async {
      final items = ['Apple', 'Banana', 'Cherry'].asDropDownItems();

      final dropDown = DropDown<String>(
        data: DropDownData<String>(items),
      );

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  await dropDown.show(context);
                },
                child: Text('Open Dropdown'),
              );
            },
          ),
        ),
      ));

      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();

      expect(find.text('Apple'), findsAtLeastNWidgets(1));
      expect(find.text('Banana'), findsAtLeastNWidgets(1));
      expect(find.text('Cherry'), findsAtLeastNWidgets(1));
      expect(find.text('No options available.'), findsNothing);
      expect(find.text('No options found from 3 total'), findsNothing);
    });
  });
}
