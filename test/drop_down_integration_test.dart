import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ff_drop_down_list/ff_drop_down_list.dart';

void main() {
  group('DropDown Integration Tests', () {
    testWidgets('should open and close dropdown', (WidgetTester tester) async {
      final items = [
        DropDownItem<String>('Item 1'),
        DropDownItem<String>('Item 2'),
      ];

      bool wasCalled = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  await DropDown<String>(
                    data: DropDownData(items),
                    options: DropDownOptions<String>(
                      onSingleSelected: (item) {
                        wasCalled = true;
                        Navigator.of(context).pop();
                      },
                    ),
                  ).show(context);
                },
                child: const Text('Show Dropdown'),
              );
            },
          ),
        ),
      ));

      // Open the dropdown
      await tester.tap(find.text('Show Dropdown'));
      await tester.pumpAndSettle();

      // Verify dropdown opens
      expect(find.byType(DraggableScrollableSheet), findsOneWidget);

      // Tap on an item to close
      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();

      // Verify callback was called and dropdown is closed
      expect(wasCalled, true);
      expect(find.byType(DraggableScrollableSheet), findsNothing);
    });

    testWidgets('should support multiple selection',
        (WidgetTester tester) async {
      final items = [
        DropDownItem<String>('Multi 1'),
        DropDownItem<String>('Multi 2'),
      ];

      bool wasCalled = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  await DropDown<String>(
                    data: DropDownData(items),
                    options: DropDownOptions<String>(
                      enableMultipleSelection: true,
                      onMultipleSelected: (selectedItems) {
                        wasCalled = true;
                        Navigator.of(context).pop();
                      },
                    ),
                  ).show(context);
                },
                child: const Text('Show Multi-Select'),
              );
            },
          ),
        ),
      ));

      // Open the dropdown
      await tester.tap(find.text('Show Multi-Select'));
      await tester.pumpAndSettle();

      // Verify dropdown opens in multi-select mode
      expect(find.byType(DraggableScrollableSheet), findsOneWidget);

      // Select an item
      await tester.tap(find.text('Multi 1'));
      await tester.pumpAndSettle();

      // Submit in multi-select mode
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      // Verify callback was called and dropdown is closed
      expect(wasCalled, true);
      expect(find.byType(DraggableScrollableSheet), findsNothing);
    });

    testWidgets('should support custom styling', (WidgetTester tester) async {
      final items = [
        DropDownItem<String>('Styled 1'),
        DropDownItem<String>('Styled 2'),
      ];

      bool wasCalled = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  await DropDown<String>(
                    data: DropDownData(items),
                    options: DropDownOptions<String>(
                      onSingleSelected: (item) {
                        wasCalled = true;
                        Navigator.of(context).pop();
                      },
                    ),
                    style: DropDownStyle(
                      searchHintText: 'Custom hint',
                      submitButtonText: 'Custom Submit',
                    ),
                  ).show(context);
                },
                child: const Text('Show Styled Dropdown'),
              );
            },
          ),
        ),
      ));

      // Open the dropdown
      await tester.tap(find.text('Show Styled Dropdown'));
      await tester.pumpAndSettle();

      // Verify custom styling is applied
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Styled 1'), findsOneWidget);
      expect(find.text('Styled 2'), findsOneWidget);

      // Tap on an item to close
      await tester.tap(find.text('Styled 1'));
      await tester.pumpAndSettle();

      // Verify callback was called and dropdown is closed
      expect(wasCalled, true);
      expect(find.byType(DraggableScrollableSheet), findsNothing);
    });

    testWidgets('should work with future data', (WidgetTester tester) async {
      final futureItems = Future.delayed(
        Duration(milliseconds: 300),
        () => [
          DropDownItem<String>('Future 1'),
          DropDownItem<String>('Future 2'),
        ],
      );

      bool wasCalled = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  await DropDown<String>(
                    data: DropDownData<String>.future(futureItems),
                    options: DropDownOptions<String>(
                      onSingleSelected: (item) {
                        wasCalled = true;
                        Navigator.of(context).pop();
                      },
                    ),
                  ).show(context);
                },
                child: const Text('Show Future Dropdown'),
              );
            },
          ),
        ),
      ));

      // Open the dropdown
      await tester.tap(find.text('Show Future Dropdown'));
      await tester.pump();

      // Should show loading state
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for future to complete
      await tester.pump(Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      // Should show loaded items
      expect(find.text('Future 1'), findsOneWidget);
      expect(find.text('Future 2'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // Tap on an item to close
      await tester.tap(find.text('Future 1'));
      await tester.pumpAndSettle();

      // Verify callback was called and dropdown is closed
      expect(wasCalled, true);
      expect(find.byType(DraggableScrollableSheet), findsNothing);
    });

    testWidgets('should handle empty data gracefully',
        (WidgetTester tester) async {
      final items = <DropDownItem<String>>[];

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  await DropDown<String>(
                    data: DropDownData(items),
                    options: DropDownOptions<String>(
                      enableMultipleSelection: false,
                    ),
                  ).show(context);
                },
                child: const Text('Show Empty Dropdown'),
              );
            },
          ),
        ),
      ));

      // Open the dropdown
      await tester.tap(find.text('Show Empty Dropdown'));
      await tester.pumpAndSettle();

      // Should open without crashing
      expect(find.byType(DraggableScrollableSheet), findsOneWidget);
    });
  });
}

class ComplexData {
  final String name;
  final int value;

  ComplexData(this.name, this.value);

  @override
  String toString() => 'ComplexData(name: $name, value: $value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComplexData &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          value == other.value;

  @override
  int get hashCode => name.hashCode ^ value.hashCode;
}
