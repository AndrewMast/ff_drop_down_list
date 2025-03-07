# ff_drop_down_list

<a href="https://flutter.dev/"><img src="https://img.shields.io/badge/flutter-website-deepskyblue.svg" alt="Flutter Website"></a>
<a href="https://dart.dev"><img src="https://img.shields.io/badge/dart-website-deepskyblue.svg" alt="Dart Website"></a>
<a href="https://github.com/AndrewMast/ff_drop_down_list/blob/main/LICENSE" style="pointer-events: stroke;" target="_blank"><img src="https://img.shields.io/github/license/AndrewMast/ff_drop_down_list"></a>
<a href="https://pub.dev/packages/ff_drop_down_list"><img src="https://img.shields.io/pub/v/ff_drop_down_list?color=as&label=ff_drop_down_list&logo=as1&logoColor=blue&style=social"></a>

A customizable dropdown widget supporting single/multiple selection, integrated search in a bottom
sheet, generic support for flexible, type-safe handling of custom data.

Forked from [MindInventory/drop_down_list](https://github.com/Mindinventory/drop_down_list) to optimize for FlutterFlow usage.

<br/>

# Preview

### Dropdown with a Multiple Selection

![drop_down_with_multiple_selection](https://github.com/AndrewMast/ff_drop_down_list/raw/main/screenshots/drop_down_with_multiple_selection.gif)

### Dropdown with a Single Selection

![drop_down_with_single_selection](https://github.com/AndrewMast/ff_drop_down_list/raw/main/screenshots/drop_down_with_single_selection.gif)

<br/><br/>

# Basic Usage

Import it to your project file

```dart
import 'package:ff_drop_down_list/ff_drop_down_list.dart';
```

And add it in its most basic form like it:

```dart
DropDown<String>(
  data: <SelectedListItem<String>>[
    SelectedListItem<String>(data: 'Tokyo'),
    SelectedListItem<String>(data: 'New York'),
    SelectedListItem<String>(data: 'London'),
  ],
  options: DropDownOptions(
    onSingleSelected: (SelectedListItem<String> selectedItem) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(selectedItem.data),
        ),
      );
    },
  ),
).show(context);
```

<br/><br/>

# Documentation

## `ff_drop_down_list` Classes
| Class                 | Description                                     |
|-----------------------|-------------------------------------------------|
| `DropDown<T>`         | The main class to build and display a dropdown. |
| `DropDownOptions<T>`  | The options on how the dropdown should behave.  |
| `DropDownStyle`       | The style on how the dropdown should look.      |
| `SelectedListItem<T>` | The datatype for each dropdown item.            |

<br/>

## `DropDown<T>` Class Parameters
| Parameter                            | Description                                                                   |
|--------------------------------------|-------------------------------------------------------------------------------|
| `List<SelectedListItem<T>>? data`    | The data for the dropdown.                                                    |
| `List<T>? unbuiltData`               | The unbuilt data for the dropdown. Only used if `data` is not provided.       |
| `DropDownOptions<T>? options`        | The options for the dropdown.                                                 |
| `DropDownStyle? style`               | The style for the dropdown.                                                   |
| `DropDownStyleBuilder? styleBuilder` | A style builder to make a `DropDownStyle` if `style` is not already provided. |
| `ShapeBorder? shapeBorder`           | The border shape of the bottom sheet                                          |

<br/>

## `DropDown<T>` Class Methods
| Method                            | Description                                         |
|-----------------------------------|-----------------------------------------------------|
| `void show(BuildContext context)` | Displays the dropdown menu as a modal bottom sheet. |

<br/>

## `DropDownOptions<T>` Class Parameters
| Parameter                                              | Default | Description                                                                                                 |
|--------------------------------------------------------|---------|-------------------------------------------------------------------------------------------------------------|
| `bool enableMultipleSelection`                         | `false` | Enables single or multiple selection for the drop down list items.                                          |
| `int? maxSelectedItems`                                |         | The maximum number of items that can be selected when `enableMultipleSelection` is `true`.                  |
| `VoidCallback? onMaxSelectionReached`                  |         | A callback function triggered when the maximum selection limit is reached.                                  |
| `ItemSelectionCallback<T>? onSelected`                 |         | A callback function triggered when items are selected from the list.                                        |
| `MultipleItemSelectionCallback<T>? onMultipleSelected` |         | A callback function triggered when multiple items are selected from the list.                               |
| `SingleItemSelectionCallback<T>? onSingleSelected`     |         | A callback function triggered when a single item is selected from the list.                                 |
| `ListItemBuilder<T>? listItemBuilder`                  |         | A function that takes an `index` and `dataItem` as a parameter and returns a custom widget.                 |
| `SearchDelegate<T>? searchDelegate`                    |         | A delegate used to configure the custom search functionality in the dropdown.                               |
| `bool searchOnEmpty`                                   | `false` | Controls whether the search list will be queried when the query string is empty.                            |
| `ListSortDelegate<T>? listSortDelegate`                |         | A delegate used to sort the list of items after every search.                                               |
| `bool useRootNavigator`                                | `false` | Specifies whether a modal bottom sheet should be displayed using the root navigator.                        |
| `bool enableDrag`                                      | `true`  | Specifies whether the bottom sheet can be dragged up and down and dismissed by swiping downwards.           |
| `bool isDismissible`                                   | `true`  | Specifies whether the bottom sheet will be dismissed when the user taps on the scrim.                       |
| `double initialSheetSize`                              | `0.7`   | The initial fractional value of the parent container's height to use when displaying the `DropDown` widget. |
| `double minSheetSize`                                  | `0.3`   | The minimum fractional value of the parent container's height to use when displaying the `DropDown` widget. |
| `double maxSheetSize`                                  | `0.9`   | The maximum fractional value of the parent container's height to use when displaying the `DropDown` widget. |
| `BottomSheetListener? bottomSheetListener`             |         | A listener that monitors events bubbling up from the `BottomSheet`.                                         |

<br/>

## `DropDownStyle` Class Parameters
| Parameter                             | Default                                                                                            | Description                                                                                                                                        |
|---------------------------------------|----------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
| `EdgeInsets? listPadding`             | `EdgeInsets.zero`                                                                                  | The padding applied to the `ListView` that contains the dropdown items.                                                                            |
| `Widget? listSeparator`               | `Divider(color: listSeparatorColor, height: 0)`                                                    | The widget used as a separator between items in the dropdown list.                                                                                 |
| `Color? listSeparatorColor`           | `BrightnessColor.bwa(alpha: 0.08)`<br/><sup>See [Custom Color Models](#custom-color-models).</sup> | Defines the color of the default list separator `Divider`.                                                                                         |
| `EdgeInsets? tileContentPadding`      | `EdgeInsets.symmetric(horizontal: 20)`                                                             | The padding applied to the content of each `ListTile` in the dropdown list.                                                                        |
| `Color? tileColor`                    | `Colors.transparent`                                                                               | Defines the background color of each `ListTile` in the dropdown list.                                                                              |
| `Color? selectedTileColor`            | `Colors.transparent`                                                                               | Defines the background color of each selected `ListTile` in the dropdown list.                                                                     |
| `Widget selectedTileTrailingWidget`   | `Icon(Icons.check_box)`                                                                            | The widget displayed as a trailing icon when a list item is selected and when `enableMultipleSelection` is `true`.                                 |
| `Widget unselectedTileTrailingWidget` | `Icon(Icons.check_box_outline_blank)`                                                              | The widget displayed as a trailing icon when a list item is not selected and when `enableMultipleSelection` is `true`.                             |
| `Color backgroundColor`               | `Colors.transparent`                                                                               | Sets the background color of the dropdown.                                                                                                         |
| `EdgeInsets? padding`                 | `EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom)`                                   | The padding applied to the dropdown container.                                                                                                     |
| `EdgeInsets? headerPadding`           | `EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0)`                                              | The padding applied to the dropdown header.                                                                                                        |
| `Widget? headerWidget`                |                                                                                                    | The widget displayed as the title of the bottom sheet.                                                                                             |
| `Widget? submitButtonChild`           |                                                                                                    | Defines a custom widget to display as the child of the submit button when `enableMultipleSelection` is `true`.                                     |
| `String submitButtonText`             | `"Submit"`                                                                                         | Specifies the text displayed on the submit button when `submitButtonChild` is not provided and `enableMultipleSelection` is `true`.                |
| `Widget? clearButtonChild`            |                                                                                                    | Defines a custom widget to display as the child of the clear button when `enableMultipleSelection` is `true`.                                      |
| `String clearButtonText`              | `"Clear"`                                                                                          | Specifies the text displayed on the clear button when `clearButtonChild` is not provided` and enableMultipleSelection` is `true`.                  |
| `bool isSearchVisible`                | `true`                                                                                             | Controls the visibility of the search widget.                                                                                                      |
| `EdgeInsets? searchTextFieldPadding`  | `EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)`                                           | The padding applied to the search text field.                                                                                                      |
| `TextFormField? searchWidget`         |                                                                                                    | Defines a custom widget to display the text box for searching.                                                                                     |
| `String searchHintText`               | `"Search"`                                                                                         | Specifies the text displayed on the search widget as hint text.                                                                                    |
| `Color? searchFillColor`              |                                                                                                    | This is the fill color for the input field.                                                                                                        |
| `Color? searchCursorColor`            |                                                                                                    | This is the cursor color for the input field.                                                                                                      |
| `bool isSelectAllVisible`             |                                                                                                    | Controls the visibility of the "select all" widget when `enableMultipleSelection` is `true`.                                                       |
| `EdgeInsets? selectAllButtonPadding`  | `EdgeInsets.zero`                                                                                  | The padding applied to the "select all" and "deselect all" TextButtons.                                                                            |
| `Widget? selectAllButtonChild`        |                                                                                                    | Defines a custom widget to display as the child of the selectAll text button  when `enableMultipleSelection` and `isSelectAllVisible` is `true`.   |
| `String selectAllButtonText`          | `"Select All"`                                                                                     | Specifies the text displayed on the selectAll text button  when `enableMultipleSelection` and `isSelectAllVisible` is `true`.                      |
| `Widget? deselectAllButtonChild`      |                                                                                                    | Defines a custom widget to display as the child of the deSelectAll text button  when `enableMultipleSelection` and `isSelectAllVisible` is `true`. |
| `String deselectAllButtonText`        | `"Deselect All"`                                                                                   | Specifies the text displayed on the deSelectAll text button  when `enableMultipleSelection` and `isSelectAllVisible` is `true`.                    |

<br/>

## `SelectedListItem<T>` Class Parameters
| Parameter         | Default | Description                             |
|-------------------|---------|-----------------------------------------|
| `bool isSelected` | `false` | Indicates whether the item is selected. |
| `T data`          |         | Tha data of the item.                   |

<br/>

## Type Definitions
| Name                               | Definition                                                                              | Description                                                                                 |
|------------------------------------|-----------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------|
| `ItemSelectionCallback<T>`         | `void Function(List<SelectedListItem<T>> selectedItems)`                                | A callback function that is invoked when items are selected.                                |
| `MultipleItemSelectionCallback<T>` | `void Function(List<SelectedListItem<T>> selectedItems)`                                | A callback function that is invoked when multiple items are selected.                       |
| `SingleItemSelectionCallback<T>`   | `void Function(SelectedListItem<T> selectedItem)`                                       | A callback function that is invoked when a single item is selected.                         |
| `ListItemBuilder<T>`               | `Widget Function(int index, SelectedListItem<T> dataItem)`                              | A function type definition for building a widget for a specific list item.                  |
| `SearchDelegate<T>`                | `List<SelectedListItem<T>> Function(String query, List<SelectedListItem<T>> dataItems)` | A function type definition for searching through a list of items based on the user's query. |
| `ListSortDelegate<T>`              | `int Function(SelectedListItem<T> a, SelectedListItem<T> b)`                            | A function type definition for sorting through the list of items.                           |
| `BottomSheetListener`              | `bool Function(DraggableScrollableNotification draggableScrollableNotification)`        | A function type definition for handling notifications from a draggable bottom sheet.        |
| `DropDownStyleBuilder`             | `DropDownStyle Function(BuildContext context)`                                          | A function type definition for building a `DropDownStyle`.                                  |

<br/>

## Custom `Color` Models
These custom models can be used in any option that accepts a `Color`.
| Name              | Usage                                                      | Description                                                                                                                                                  |
|-------------------|------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `BrightnessColor` | `BrightnessColor(light: Colors.black, dark: Colors.white)` | A class extended from `Color` which allows a light and a dark color to be chosen to be rendered based on the theme brightness of the current `BuildContext`. |
| `ThemedColor`     | `ThemedColor((ThemeData theme) => theme.primaryColor)`     | A class extended from `Color` which allows for custom colors based on the theme of the current `BuildContext`.                                               |

<br/>

# Contribution

Contributions to this project are welcome. Feel free to open issues and to submit pull requests for general fixes or improvements.

<br/>

# License

**ff_drop_down_list**
is [MIT-licensed.](https://github.com/AndrewMast/ff_drop_down_list/blob/main/LICENSE)
