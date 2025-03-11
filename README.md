# ff_drop_down_list

<a href="https://flutter.dev/"><img src="https://img.shields.io/badge/flutter-website-deepskyblue.svg" alt="Flutter Website"></a>
<a href="https://dart.dev"><img src="https://img.shields.io/badge/dart-website-deepskyblue.svg" alt="Dart Website"></a>
<a href="https://github.com/AndrewMast/ff_drop_down_list/blob/main/LICENSE" style="pointer-events: stroke;" target="_blank"><img src="https://img.shields.io/github/license/AndrewMast/ff_drop_down_list"></a>
<a href="https://pub.dev/packages/ff_drop_down_list"><img src="https://img.shields.io/pub/v/ff_drop_down_list?color=as&label=ff_drop_down_list&logo=as1&logoColor=blue&style=social"></a>

A customizable dropdown widget supporting single/multiple selection, integrated search in a bottom
sheet, generic support for flexible, type-safe handling of custom data.

Forked from [MindInventory/drop_down_list](https://github.com/Mindinventory/drop_down_list) to optimize for FlutterFlow usage.

<br/>

# Basic Usage

Import it to your project file

```dart
import 'package:ff_drop_down_list/ff_drop_down_list.dart';
```

And create a drop down in its most basic form like so:

```dart
DropDown<String>(
  data: DropDownData([
    DropDownItem<String>('Tokyo'),
    DropDownItem<String>('New York'),
    DropDownItem<String>('London'),
  ]),
  options: DropDownOptions(
    onSingleSelected: (DropDownItem<String> selectedItem) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(selectedItem.data),
        ),
      );
    },
  ),
).show(context);
```

The [example project](https://github.com/AndrewMast/ff_drop_down_list/blob/main/example/lib/main.dart) contains more examples if needed.

<br/>

# Documentation

## `ff_drop_down_list` Classes
| Class                 | Description                                                                                                      |
|-----------------------|------------------------------------------------------------------------------------------------------------------|
| `DropDown<T>`         | The main class to build and display a dropdown. <br/><sup>See [DropDown](#dropdownt-class)</sup>                 |
| `DropDownData<T>`     | The data for the dropdown.                      <br/><sup>See [DropDownData](#dropdowndatat-class)</sup>         |
| `DropDownOptions<T>`  | The options on how the dropdown should behave.  <br/><sup>See [DropDownOptions](#dropdownoptionst-class)</sup>   |
| `DropDownStyle`       | The style on how the dropdown should look.      <br/><sup>See [DropDownStyle](#dropdownstyle-class)</sup>        |
| `DropDownItem<T>`     | The datatype for each dropdown item.            <br/><sup>See [DropDownItem](#dropdownitemt-class)</sup>         |
| `DropDownResponse<T>` | The response returned from a dropdown.          <br/><sup>See [DropDownResponse](#dropdownresponset-class)</sup> |

<br/>

## `DropDown<T>` Class
<!-- <sup>See [DropDown](#dropdownt-class)</sup> -->
| Parameter                        | Description                                                                                   |
|----------------------------------|-----------------------------------------------------------------------------------------------|
| `DropDownData<T> data`           | The data for the dropdown.    <br/><sup>See [DropDownData](#dropdowndatat-class).</sup>       |
| `DropDownOptions<T>? options`    | The options for the dropdown. <br/><sup>See [DropDownOptions](#dropdownoptionst-class).</sup> |
| `DropDownStyle? style`           | The style for the dropdown.   <br/><sup>See [DropDownStyle](#dropdownstyle-class).</sup>      |

| Method                                                    | Description                                                                                                                                                                |
|-----------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Future<DropDownResponse<T>?> show(BuildContext context)` | Displays the dropdown menu as a modal bottom sheet. Returns a future with a potential `DropDownResponse`.<br/><sup>See [DropDownResponse](#dropdownresponset-class).</sup> |

<br/>

## `DropDownData<T>` Class
<!-- <sup>See [DropDownData](#dropdowndatat-class)</sup> -->
| Parameter                               | Description                                                                                                                                |
|-----------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| `List<DropDownItem<T>>? items`          | The items for the dropdown. If `future` is provided, these items will be ignored.<br/><sup>See [DropDownItem](#dropdownitemt-class).</sup> |
| `Future<List<DropDownItem<T>>>? future` | A future that will return the items for the dropdown.                                                                                      |

| Method                                                                           | Description                                                                            |
|----------------------------------------------------------------------------------|----------------------------------------------------------------------------------------|
| `void selectAll([bool select = true])`                                           | Selects all of the `DropDownItem`s in the list.                                        |
| `void deselectAll([bool deselect = true])`                                       | Deselects all of the `DropDownItem`s in the list.                                      |
| `void select(List<T> data, {bool select = true, bool deselectOthers = false})`   | Selects all of the `DropDownItem`s with data contained in the provided list of data.   |
| `void deselect(List<T> data, {bool deselect = true, bool selectOthers = false})` | Deselects all of the `DropDownItem`s with data contained in the provided list of data. |

| Constructor                                                 | Description                                                                                     |
|-------------------------------------------------------------|-------------------------------------------------------------------------------------------------|
| `DropDownData(List<DropDownItem<T>> items)`                 | Create a data object from a list of `DropDownItem`s.                                            |
| `DropDownData.raw(List<T> items)`                           | Create a data object from a list of items.                                                      |
| `DropDownData.future(Future<List<DropDownItem<T>>> future)` | Create a data object from a future that will return a list of `DropDownItem`s.                  |
| `DropDownData.rawFuture(Future<List<T>> future)`            | Create a data object from a future that will return a list of items.                            |
| `DropDownData.from(FutureOr<List<DropDownItem<T>>> data)`   | Create a data object from either a list of `DropDownItem`s or a future that will return a list. |
| `DropDownData.fromRaw(FutureOr<List<T>> data)`              | Create a data object from either a list of items or a future that will return a list.           |

<br/>

## `DropDownOptions<T>` Class
<!-- <sup>See [DropDownOptions](#dropdownoptionst-class)</sup> -->
| Parameter                                             | Default | Description                                                                                                                                                                  |
|-------------------------------------------------------|---------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `bool enableMultipleSelection`                        | `false` | Enables single or multiple selection for the drop down list items.                                                                                                           |
| `int? maxSelectedItems`                               |         | The maximum number of items that can be selected when `enableMultipleSelection` is `true`.                                                                                   |
| `VoidCallback? onMaxSelectionReached`                 |         | A callback function triggered when the maximum selection limit is reached.                                                                                                   |
| `ItemSelectedCallback<T>? onSelected`                 |         | A callback function triggered when items are selected from the list.                                              <br/><sup>See [Type Definitions](#type-definitions).</sup> |
| `MultipleItemSelectedCallback<T>? onMultipleSelected` |         | A callback function triggered when multiple items are selected from the list.                                     <br/><sup>See [Type Definitions](#type-definitions).</sup> |
| `SingleItemSelectedCallback<T>? onSingleSelected`     |         | A callback function triggered when a single item is selected from the list.                                       <br/><sup>See [Type Definitions](#type-definitions).</sup> |
| `ListItemBuilder<T>? listItemBuilder`                 |         | A function that takes an `index` and `dataItem` as a parameter and returns a custom widget.                       <br/><sup>See [Type Definitions](#type-definitions).</sup> |
| `bool searchOnEmpty`                                  | `false` | Controls whether the search list will be queried when the query string is empty.                                                                                             |
| `SearchDelegate<T>? searchDelegate`                   |         | A delegate used to configure the custom search functionality in the dropdown.                                     <br/><sup>See [Type Definitions](#type-definitions).</sup> |
| `SortDelegate<T>? sortDelegate`                       |         | A delegate used to sort the list of items after every search.                                                     <br/><sup>See [Type Definitions](#type-definitions).</sup> |
| `bool useRootNavigator`                               | `false` | Specifies whether a modal bottom sheet should be displayed using the root navigator.                                                                                         |
| `bool enableDrag`                                     | `true`  | Specifies whether the bottom sheet can be dragged up and down and dismissed by swiping downwards.                                                                            |
| `bool isDismissible`                                  | `true`  | Specifies whether the bottom sheet will be dismissed when the user taps on the scrim.                                                                                        |
| `double initialSheetSize`                             | `0.7`   | The initial fractional value of the parent container's height to use when displaying the `DropDown` widget.                                                                  |
| `double minSheetSize`                                 | `0.3`   | The minimum fractional value of the parent container's height to use when displaying the `DropDown` widget.                                                                  |
| `double maxSheetSize`                                 | `0.9`   | The maximum fractional value of the parent container's height to use when displaying the `DropDown` widget.                                                                  |
| `BottomSheetListener? bottomSheetListener`            |         | A listener that monitors events bubbling up from the `BottomSheet`.                                               <br/><sup>See [Type Definitions](#type-definitions).</sup> |

<br/>

## `DropDownStyle` Class
<!-- <sup>See [DropDownStyle](#dropdownstyle-class)</sup> -->
| Parameter                             | Default                                                                                               | Description                                                                                                                                                                                                                              |
|---------------------------------------|------------------------------------------------------------------------------------------------------ |------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `EdgeInsets? listPadding`             | `EdgeInsets.zero`                                                                                     | The padding applied to the `ListView` that contains the dropdown items.                                                                                                                                                                  |
| `Widget? listSeparator`               | `Divider(color: listSeparatorColor, height: 0)`                                                       | The widget used as a separator between items in the dropdown list.                                                                                                                                                                       |
| `Color? listSeparatorColor`           | `BrightnessColor.bwa(alpha: 0.08)` <br/><sup>See [Custom Color Classes](#custom-color-classes).</sup> | Defines the color of the default list separator `Divider`.                                                                                                                                                                               |
| `EdgeInsets? tileContentPadding`      | `EdgeInsets.symmetric(horizontal: 20)`                                                                | The padding applied to the content of each `ListTile` in the dropdown list.                                                                                                                                                              |
| `Color? tileColor`                    | `Colors.transparent`                                                                                  | Defines the background color of each `ListTile` in the dropdown list.                                                                                                                                                                    |
| `Color? selectedTileColor`            | `Colors.transparent`                                                                                  | Defines the background color of each selected `ListTile` in the dropdown list.                                                                                                                                                           |
| `Widget selectedTileTrailingWidget`   | `Icon(Icons.check_box)`                                                                               | The widget displayed as a trailing icon when a list item is selected and when `enableMultipleSelection` is `true`.                                                                                                                       |
| `Widget unselectedTileTrailingWidget` | `Icon(Icons.check_box_outline_blank)`                                                                 | The widget displayed as a trailing icon when a list item is not selected and when `enableMultipleSelection` is `true`.                                                                                                                   |
| `Color backgroundColor`               | `Colors.transparent`                                                                                  | Sets the background color of the dropdown.                                                                                                                                                                                               |
| `ShapeBorder? border`                 | `RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)))`             | The border shape of the bottom sheet.                                                                                                                                                                                                    |
| `EdgeInsets? padding`                 | `EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom)`                                      | The padding applied to the dropdown container.                                                                                                                                                                                           |
| `EdgeInsets? headerPadding`           | `EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0)`                                                 | The padding applied to the dropdown header.                                                                                                                                                                                              |
| `Widget? headerWidget`                |                                                                                                       | The widget displayed as the title of the bottom sheet.                                                                                                                                                                                   |
| `Widget? submitButtonChild`           |                                                                                                       | Defines a custom widget to display as the child of the submit button when `enableMultipleSelection` is `true`.                                                                                                                           |
| `String submitButtonText`             | `"Submit"`                                                                                            | Specifies the text displayed on the submit button when `submitButtonChild` is not provided and `enableMultipleSelection` is `true`.                                                                                                      |
| `Widget? clearButtonChild`            |                                                                                                       | Defines a custom widget to display as the child of the clear button when `enableMultipleSelection` is `true`.                                                                                                                            |
| `String clearButtonText`              | `"Clear"`                                                                                             | Specifies the text displayed on the clear button when `clearButtonChild` is not provided` and enableMultipleSelection` is `true`.                                                                                                        |
| `bool isSearchVisible`                | `true`                                                                                                | Controls the visibility of the search widget.                                                                                                                                                                                            |
| `EdgeInsets? searchTextFieldPadding`  | `EdgeInsets.all(10)`                                                                                  | The padding applied to the search text field.                                                                                                                                                                                            |
| `TextFormField? searchWidget`         |                                                                                                       | Defines a custom widget to display the text box for searching.                                                                                                                                                                           |
| `String searchHintText`               | `"Search"`                                                                                            | Specifies the text displayed on the search widget as hint text.                                                                                                                                                                          |
| `Color? searchFillColor`              |                                                                                                       | The fill color for the search input field.                                                                                                                                                                                               |
| `Color? searchCursorColor`            |                                                                                                       | The color of the cursor for the search input field.                                                                                                                                                                                      |
| `BorderRadius? searchBorderRadius`    | `BorderRadius.circular(24.0)`                                                                         | The border radius of the search input field.                                                                                                                                                                                             |
| `Widget? searchPrefixIcon`            | `Icon(Icons.search)`                                                                                  | The prefix icon for the search input field.                                                                                                                                                                                              |
| `Color? searchPrefixColor`            | `BrightnessColor.bwa(alpha: 0.5)` <br/><sup>See [Custom Color Classes](#custom-color-classes).</sup>  | The prefix icon color for the search input field.                                                                                                                                                                                        |
| `Widget? searchSuffixIcon`            | `Icon(Icons.clear)`                                                                                   | The suffix icon for the search input field.                                                                                                                                                                                              |
| `Color? searchSuffixColor`            | `BrightnessColor.bwa(alpha: 0.5)` <br/><sup>See [Custom Color Classes](#custom-color-classes).</sup>  | The suffix icon color for the search input field.                                                                                                                                                                                        |
| `bool searchAutofocus`                | `false`                                                                                               | Controls whether the search input field will autofocus.                                                                                                                                                                                  |
| `bool isSelectAllVisible`             | `false`                                                                                               | Controls the visibility of the "select all" widget when `enableMultipleSelection` is `true`.                                                                                                                                             |
| `EdgeInsets? selectAllButtonPadding`  | `EdgeInsets.zero`                                                                                     | The padding applied to the "select all" and "deselect all" TextButtons.                                                                                                                                                                  |
| `Widget? selectAllButtonChild`        |                                                                                                       | Defines a custom widget to display as the child of the selectAll text button  when `enableMultipleSelection` and `isSelectAllVisible` is `true`.                                                                                         |
| `String selectAllButtonText`          | `"Select All"`                                                                                        | Specifies the text displayed on the selectAll text button  when `enableMultipleSelection` and `isSelectAllVisible` is `true`.                                                                                                            |
| `Widget? deselectAllButtonChild`      |                                                                                                       | Defines a custom widget to display as the child of the deSelectAll text button  when `enableMultipleSelection` and `isSelectAllVisible` is `true`.                                                                                       |
| `String deselectAllButtonText`        | `"Deselect All"`                                                                                      | Specifies the text displayed on the deSelectAll text button  when `enableMultipleSelection` and `isSelectAllVisible` is `true`.                                                                                                          |
| `Widget? dataLoadingWidget`           | `Align(alignment: Alignment.topCenter, child: CircularProgressIndicator())`                           | The widget to display when data is being loaded from `DropDownData.future`.                                                                                                                                                              |
| `Widget? dataFailureWidget`           | `Align(alignment: Alignment.topCenter, child: Text('Unable to load data.'))`                          | The widget to display when data fails to load from `DropDownData.future`. By default the text is pulled from `dataFailureText`.                                                                                                          |
| `String dataFailureText`              | `"Unable to load data."`                                                                              | The text to display when data fails to load from `DropDownData.future`.                                                                                                                                                                  |
| `DropDownStyleBuilder? builder`       |                                                                                                       | A style builder to make a `DropDownStyle`. If provided, all other style options will be ignored in favor of the style options in the `DropDownStyle` returned by the builder. <br/><sup>See [Type Definitions](#type-definitions).</sup> |

<br/>

## `DropDownItem<T>` Class
<!-- <sup>See [DropDownItem](#dropdownitemt-class)</sup> -->
| Parameter         | Default | Description                             |
|-------------------|---------|-----------------------------------------|
| `T data`          |         | Tha data of the item.                   |
| `bool isSelected` | `false` | Indicates whether the item is selected. |

| Method                                  | Description         |
|-----------------------------------------|---------------------|
| `void select([bool select = true])`     | Selects the item.   |
| `void deselect([bool deselect = true])` | Deselects the item. |

<br/>

## `DropDownResponse<T>` Class
<!-- <sup>See [DropDownResponse](#dropdownresponset-class)</sup> -->
| Parameter                         | Description                                                          |
|-----------------------------------|----------------------------------------------------------------------|
| `bool multipleSelection`          | Whether the response contains multiple items or a singular one.      |
| `DropDownItem<T>? single`         | The single selected item, null if `multipleSelection` is `true`.     |
| `List<DropDownItem<T>>? multiple` | The multiple selected items, null if `multipleSelection` is `false`. |
| `List<DropDownItem<T>> items`     | The selected items.                                                  |
| `List<T> data`                    | The data of the selected items.                                      |

<br/>

## Type Definitions
<!-- <sup>See [Type Definitions](#type-definitions).</sup> -->
| Name                              | Definition                                                                  | Description                                                                                 |
|---------------------------------- |-----------------------------------------------------------------------------|---------------------------------------------------------------------------------------------|
| `DropDownList<T>`                 | `List<DropDownItem<T>>`                                                     | An alias for a `List` of `DropDownItem`s.                                                   |
| `ItemSelectedCallback<T>`         | `void Function(List<DropDownItem<T>> items)`                                | A callback function that is invoked when items are selected.                                |
| `MultipleItemSelectedCallback<T>` | `void Function(List<DropDownItem<T>> items)`                                | A callback function that is invoked when multiple items are selected.                       |
| `SingleItemSelectedCallback<T>`   | `void Function(DropDownItem<T> item)`                                       | A callback function that is invoked when a single item is selected.                         |
| `ListItemBuilder<T>`              | `Widget Function(int index, DropDownItem<T> item)`                          | A function type definition for building a widget for a specific list item.                  |
| `SearchDelegate<T>`               | `List<DropDownItem<T>> Function(String query, List<DropDownItem<T>> items)` | A function type definition for searching through a list of items based on the user's query. |
| `SortDelegate<T>`                 | `int Function(DropDownItem<T> a, DropDownItem<T> b)`                        | A function type definition for sorting through the list of items.                           |
| `BottomSheetListener`             | `bool Function(DraggableScrollableNotification notification)`               | A function type definition for handling notifications from a draggable bottom sheet.        |
| `DropDownStyleBuilder`            | `DropDownStyle Function(BuildContext context)`                              | A function type definition for building a `DropDownStyle`.                                  |

<br/>

## Custom `Color` Classes
<!-- <sup>See [Custom Color Classes](#custom-color-classes).</sup> -->
These custom models can be used in any option that accepts a `Color`.
| Name              | Example Usage                                                                          | Description                                                                                                                                                  |
|-------------------|----------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `BrightnessColor` | `BrightnessColor(light: Colors.black, dark: Colors.white)`                             | A class extended from `Color` which allows a light and a dark color to be chosen to be rendered based on the theme brightness of the current `BuildContext`. |
| `ThemedColor`     | `ThemedColor((ThemeData theme) => theme.primaryColor)`                                 | A class extended from `Color` which allows for custom colors based on the theme of the current `BuildContext`.                                               |
| `ContextualColor` | `ContextualColor((BuildContext context) => FlutterFlowTheme.of(context).primaryText)`  | A class extended from `Color` which allows for custom colors based on the current `BuildContext`.                                                            |

| Model             | Constructor                                                                                | Description                                                                                             |
|-------------------|--------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------|
| `BrightnessColor` | `BrightnessColor({Color? light, Color? dark})`                                             |                                                                                                         |
|                   | `BrightnessColor.alpha({Color? light, Color? dark, double alpha})`                         | Alias for `BrightnessColor(light: light.withValues(alpha: alpha), dark: dark.withValues(alpha: alpha))` |
|                   | `BrightnessColor.inverted({Color? light})`                                                 | Alias for `BrightnessColor(light: light, dark: light.inverted)`                                         |
|                   | `BrightnessColor.inverted({Color? dark})`                                                  | Alias for `BrightnessColor(light: dark.inverted, dark: dark)`                                           |
|                   | `BrightnessColor.invertedOnDark(Color light)`                                              | Alias for `BrightnessColor.inverted(light: light) `                                                     |
|                   | `BrightnessColor.invertedOnLight(Color dark)`                                              | Alias for `BrightnessColor.inverted(dark: dark) `                                                       |
|                   | `BrightnessColor.bw()`                                                                     | Alias for `BrightnessColor(light: Colors.black, dark: Colors.white)`                                    |
|                   | `BrightnessColor.wb()`                                                                     | Alias for `BrightnessColor(light: Colors.white, dark: Colors.black)`                                    |
|                   | `BrightnessColor.bwa(double alpha)`                                                        | Alias for `BrightnessColor.alpha(light: Colors.black, dark: Colors.white, alpha: alpha)`                |
|                   | `BrightnessColor.wba(double alpha)`                                                        | Alias for `BrightnessColor.alpha(light: Colors.white, dark: Colors.black, alpha: alpha)`                |
| `ThemedColor`     | `ThemedColor(Color? Function(ThemeData theme))`                                            |                                                                                                         |
| `ContextualColor` | `ContextualColor(Color? Function(BuildContext context))`                                   |                                                                                                         |

<br/>

# Contribution

Contributions to this project are welcome. Feel free to open issues and to submit pull requests for general fixes or improvements.

<br/>

# Todo

These are some things I would like to add to the next release.

- Move some logic to `DropDownItem`
    - Move default item builder to `DropDownItem` (`Widget build(BuildContext)`?)
    - Move default search to `DropDownItem` (`bool satisfiesQuery(String)`?)
        - Move `_basicSearch` to `DropDownList` extension as `search`
    - Make `DropDownItem` implement `Comparable<DropDownItem>` (`compareTo`)
        - Add `DropDownOptions` option to sort after search (so default `.sort()` can work)
    - Make custom `DropDownItem` with subtitle for example
        - Builds subtitle text
        - Searches both title and subtitle
- Show a message when the drop down has no items (empty list)
    - Display basic widget
    - Add option to customize message
    - Add option to display custom widget
- Show a message when the drop down has no search results (but has items)
    - Display basic widget ("no options found from X total"?)
    - Add option to customize message (function?)
    - Add option to display custom widget
- Update example project to include more intuitive examples
    - Add examples to show the full capability of this package
    - Add new gif previews to README
    - Add more examples to README
- Add tests
    - Add tests for drop down
    - Add tests for contextual colors

<br/>

# Changelog

See the list of changes in the [changelog](https://github.com/AndrewMast/ff_drop_down_list/blob/main/CHANGELOG.md).

<br/>

# License

**ff_drop_down_list**
is [MIT-licensed.](https://github.com/AndrewMast/ff_drop_down_list/blob/main/LICENSE)
