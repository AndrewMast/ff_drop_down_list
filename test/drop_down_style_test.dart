import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ff_drop_down_list/ff_drop_down_list.dart';

void main() {
  group('DropDownStyle', () {
    test('should create DropDownStyle with default values', () {
      final style = DropDownStyle();

      expect(style.listPadding, null);
      expect(style.listSeparator, null);
      expect(style.listSeparatorColor, null);
      expect(style.tileContentPadding, null);
      expect(style.tileColor, null);
      expect(style.selectedTileColor, null);
      expect(style.selectedTileTrailingWidget, isA<Icon>());
      expect(style.unselectedTileTrailingWidget, isA<Icon>());
      expect(style.backgroundColor, Colors.transparent);
      expect(style.border, null);
      expect(style.padding, null);
      expect(style.headerPadding, null);
      expect(style.headerWidget, null);
      expect(style.submitButtonChild, null);
      expect(style.submitButtonStyle, null);
      expect(style.submitButtonText, 'Submit');
      expect(style.clearButtonChild, null);
      expect(style.clearButtonStyle, null);
      expect(style.clearButtonText, 'Clear');
      expect(style.isSearchVisible, true);
      expect(style.searchTextFieldPadding, null);
      expect(style.searchWidget, null);
      expect(style.searchHintText, 'Search');
      expect(style.searchFillColor, null);
      expect(style.searchHoverColor, null);
      expect(style.searchCursorColor, null);
      expect(style.searchBorderRadius, null);
      expect(style.searchPrefixIcon, null);
      expect(style.searchSuffixIcon, null);
      expect(style.searchSuffixColor, null);
      expect(style.searchHideSuffixWhenEmpty, true);
      expect(style.searchAutofocus, false);
      expect(style.isSelectAllVisible, false);
      expect(style.selectAllButtonPadding, null);
      expect(style.selectAllButtonChild, null);
      expect(style.selectAllButtonStyle, null);
      expect(style.selectAllButtonText, 'Select All');
      expect(style.deselectAllButtonChild, null);
      expect(style.deselectAllButtonStyle, null);
      expect(style.deselectAllButtonText, 'Deselect All');
      expect(style.dataLoadingWidget, null);
      expect(style.dataFailureWidget, null);
      expect(style.dataFailureText, 'Unable to load data.');
      expect(style.builder, null);
    });

    test('should create DropDownStyle with custom values', () {
      final customPadding = EdgeInsets.all(10);
      final customBorder =
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
      final customButtonStyle =
          ElevatedButton.styleFrom(backgroundColor: Colors.red);
      final customBorderRadius = BorderRadius.circular(15);
      final customPrefixIcon = Icon(Icons.search, color: Colors.blue);
      final customSuffixIcon = Icon(Icons.clear, color: Colors.red);
      final customLoadingWidget = CircularProgressIndicator();
      final customFailureWidget = Text('Custom failure');
      final customHeaderWidget = Text('Custom Header');
      final customSubmitButtonChild = Text('Custom Submit');
      final customClearButtonChild = Text('Custom Clear');
      final customSelectAllButtonChild = Text('Custom Select All');
      final customDeselectAllButtonChild = Text('Custom Deselect All');
      final customSelectedTrailing = Icon(Icons.check);
      final customUnselectedTrailing = Icon(Icons.check_box_outline_blank);
      final customSearchWidget = TextFormField();

      final style = DropDownStyle(
        listPadding: customPadding,
        listSeparator: Divider(),
        listSeparatorColor: Colors.blue,
        tileContentPadding: customPadding,
        tileColor: Colors.white,
        selectedTileColor: Colors.grey,
        selectedTileTrailingWidget: customSelectedTrailing,
        unselectedTileTrailingWidget: customUnselectedTrailing,
        backgroundColor: Colors.black,
        border: customBorder,
        padding: customPadding,
        headerPadding: customPadding,
        headerWidget: customHeaderWidget,
        submitButtonChild: customSubmitButtonChild,
        submitButtonStyle: customButtonStyle,
        submitButtonText: 'Custom Submit',
        clearButtonChild: customClearButtonChild,
        clearButtonStyle: customButtonStyle,
        clearButtonText: 'Custom Clear',
        isSearchVisible: false,
        searchTextFieldPadding: customPadding,
        searchWidget: customSearchWidget,
        searchHintText: 'Custom Search',
        searchFillColor: Colors.yellow,
        searchHoverColor: Colors.orange,
        searchCursorColor: Colors.purple,
        searchBorderRadius: customBorderRadius,
        searchPrefixIcon: customPrefixIcon,
        searchPrefixColor: Colors.green,
        searchSuffixIcon: customSuffixIcon,
        searchSuffixColor: Colors.red,
        searchHideSuffixWhenEmpty: false,
        searchAutofocus: true,
        isSelectAllVisible: true,
        selectAllButtonPadding: customPadding,
        selectAllButtonChild: customSelectAllButtonChild,
        selectAllButtonStyle: customButtonStyle,
        selectAllButtonText: 'Custom Select All',
        deselectAllButtonChild: customDeselectAllButtonChild,
        deselectAllButtonStyle: customButtonStyle,
        deselectAllButtonText: 'Custom Deselect All',
        dataLoadingWidget: customLoadingWidget,
        dataFailureWidget: customFailureWidget,
        dataFailureText: 'Custom failure text',
      );

      expect(style.listPadding, customPadding);
      expect(style.listSeparator, isA<Divider>());
      expect(style.listSeparatorColor, Colors.blue);
      expect(style.tileContentPadding, customPadding);
      expect(style.tileColor, Colors.white);
      expect(style.selectedTileColor, Colors.grey);
      expect(style.selectedTileTrailingWidget, customSelectedTrailing);
      expect(style.unselectedTileTrailingWidget, customUnselectedTrailing);
      expect(style.backgroundColor, Colors.black);
      expect(style.border, customBorder);
      expect(style.padding, customPadding);
      expect(style.headerPadding, customPadding);
      expect(style.headerWidget, customHeaderWidget);
      expect(style.submitButtonChild, customSubmitButtonChild);
      expect(style.submitButtonStyle, customButtonStyle);
      expect(style.submitButtonText, 'Custom Submit');
      expect(style.clearButtonChild, customClearButtonChild);
      expect(style.clearButtonStyle, customButtonStyle);
      expect(style.clearButtonText, 'Custom Clear');
      expect(style.isSearchVisible, false);
      expect(style.searchTextFieldPadding, customPadding);
      expect(style.searchWidget, customSearchWidget);
      expect(style.searchHintText, 'Custom Search');
      expect(style.searchFillColor, Colors.yellow);
      expect(style.searchHoverColor, Colors.orange);
      expect(style.searchCursorColor, Colors.purple);
      expect(style.searchBorderRadius, customBorderRadius);
      expect(style.searchPrefixIcon, customPrefixIcon);
      expect(style.searchPrefixColor, Colors.green);
      expect(style.searchSuffixIcon, customSuffixIcon);
      expect(style.searchSuffixColor, Colors.red);
      expect(style.searchHideSuffixWhenEmpty, false);
      expect(style.searchAutofocus, true);
      expect(style.isSelectAllVisible, true);
      expect(style.selectAllButtonPadding, customPadding);
      expect(style.selectAllButtonChild, customSelectAllButtonChild);
      expect(style.selectAllButtonStyle, customButtonStyle);
      expect(style.selectAllButtonText, 'Custom Select All');
      expect(style.deselectAllButtonChild, customDeselectAllButtonChild);
      expect(style.deselectAllButtonStyle, customButtonStyle);
      expect(style.deselectAllButtonText, 'Custom Deselect All');
      expect(style.dataLoadingWidget, customLoadingWidget);
      expect(style.dataFailureWidget, customFailureWidget);
      expect(style.dataFailureText, 'Custom failure text');
    });

    test('should create DropDownStyle.build with builder', () {
      DropDownStyle builderFunction(BuildContext context) {
        return DropDownStyle(
          backgroundColor: Colors.red,
          submitButtonText: 'Built Submit',
        );
      }

      final style = DropDownStyle.build(builderFunction);

      expect(style.builder, builderFunction);
    });

    testWidgets('resolve() should return self when builder is null',
        (WidgetTester tester) async {
      final style = DropDownStyle(backgroundColor: Colors.blue);

      await tester.pumpWidget(MaterialApp(home: Container()));

      final resolvedStyle =
          style.resolve(tester.element(find.byType(Container)));

      expect(resolvedStyle.backgroundColor, Colors.blue);
      expect(resolvedStyle, same(style));
    });

    testWidgets('resolve() should use builder when provided',
        (WidgetTester tester) async {
      DropDownStyle builderFunction(BuildContext context) {
        return DropDownStyle(
          backgroundColor: Theme.of(context).primaryColor,
          submitButtonText: 'Built Submit',
        );
      }

      final style = DropDownStyle.build(builderFunction);

      await tester.pumpWidget(MaterialApp(
        theme: ThemeData(primaryColor: Colors.green),
        home: Container(),
      ));

      final resolvedStyle =
          style.resolve(tester.element(find.byType(Container)));

      expect(resolvedStyle.backgroundColor, Colors.green);
      expect(resolvedStyle.submitButtonText, 'Built Submit');
      expect(resolvedStyle, isNot(same(style)));
    });

    test('should have correct default trailing widgets', () {
      final style = DropDownStyle();

      expect(style.selectedTileTrailingWidget, isA<Icon>());
      expect(style.unselectedTileTrailingWidget, isA<Icon>());
    });

    test('should have null default search border radius', () {
      final style = DropDownStyle();

      expect(style.searchBorderRadius, null);
    });

    test('should have null default search icons', () {
      final style = DropDownStyle();

      expect(style.searchPrefixIcon, null);
      expect(style.searchSuffixIcon, null);
    });

    test('should accept null values for optional fields', () {
      final style = DropDownStyle(
        listPadding: null,
        listSeparator: null,
        listSeparatorColor: null,
        tileContentPadding: null,
        tileColor: null,
        selectedTileColor: null,
        border: null,
        padding: null,
        headerPadding: null,
        headerWidget: null,
        submitButtonChild: null,
        submitButtonStyle: null,
        clearButtonChild: null,
        clearButtonStyle: null,
        searchTextFieldPadding: null,
        searchWidget: null,
        searchFillColor: null,
        searchHoverColor: null,
        searchCursorColor: null,
        searchBorderRadius: null,
        searchPrefixIcon: null,
        searchPrefixColor: null,
        searchSuffixIcon: null,
        searchSuffixColor: null,
        selectAllButtonPadding: null,
        selectAllButtonChild: null,
        selectAllButtonStyle: null,
        deselectAllButtonChild: null,
        deselectAllButtonStyle: null,
        dataLoadingWidget: null,
        dataFailureWidget: null,
      );

      expect(style.listPadding, null);
      expect(style.listSeparator, null);
      expect(style.listSeparatorColor, null);
      expect(style.tileContentPadding, null);
      expect(style.tileColor, null);
      expect(style.selectedTileColor, null);
      expect(style.border, null);
      expect(style.padding, null);
      expect(style.headerPadding, null);
      expect(style.headerWidget, null);
      expect(style.submitButtonChild, null);
      expect(style.submitButtonStyle, null);
      expect(style.clearButtonChild, null);
      expect(style.clearButtonStyle, null);
      expect(style.searchTextFieldPadding, null);
      expect(style.searchWidget, null);
      expect(style.searchFillColor, null);
      expect(style.searchHoverColor, null);
      expect(style.searchCursorColor, null);
      expect(style.searchBorderRadius, null);
      expect(style.searchPrefixIcon, null);
      expect(style.searchPrefixColor, null);
      expect(style.searchSuffixIcon, null);
      expect(style.searchSuffixColor, null);
      expect(style.selectAllButtonPadding, null);
      expect(style.selectAllButtonChild, null);
      expect(style.selectAllButtonStyle, null);
      expect(style.deselectAllButtonChild, null);
      expect(style.deselectAllButtonStyle, null);
      expect(style.dataLoadingWidget, null);
      expect(style.dataFailureWidget, null);
    });

    test('should handle boolean flags correctly', () {
      final style = DropDownStyle(
        isSearchVisible: false,
        searchHideSuffixWhenEmpty: false,
        searchAutofocus: true,
        isSelectAllVisible: true,
      );

      expect(style.isSearchVisible, false);
      expect(style.searchHideSuffixWhenEmpty, false);
      expect(style.searchAutofocus, true);
      expect(style.isSelectAllVisible, true);
    });

    test('should handle string values correctly', () {
      final style = DropDownStyle(
        submitButtonText: 'Custom Submit Text',
        clearButtonText: 'Custom Clear Text',
        searchHintText: 'Custom Search Hint',
        selectAllButtonText: 'Custom Select All Text',
        deselectAllButtonText: 'Custom Deselect All Text',
        dataFailureText: 'Custom Failure Text',
      );

      expect(style.submitButtonText, 'Custom Submit Text');
      expect(style.clearButtonText, 'Custom Clear Text');
      expect(style.searchHintText, 'Custom Search Hint');
      expect(style.selectAllButtonText, 'Custom Select All Text');
      expect(style.deselectAllButtonText, 'Custom Deselect All Text');
      expect(style.dataFailureText, 'Custom Failure Text');
    });
  });
}
