## Unreleased

* Added extension on `List<DropDownItem>` (aka `DropDownList`) that allows for selection/deselection of items in the list. Also added `selected` and `unselected` getters to return subsets of the list depending on the selection status of the `DropDownItem`.
* Added methods on `DropDownData` that match new extension methods and apply it to both its `data` and its `future` data.
* Added `select()` and `deselect()` methods to `DropDownItem`.
* `DropDownItem` now implements `Comparable` (sorts by `data`).
* Added `DropDownOptions.sortAfterSearch` option to enable sorting. `DropDownOptions.sortDelegate` is still optional, as now `DropDownItem.compareTo` can be used by default.
* Moved default item builder to `DropDownItem.build`.
* Added `DropDownItemBuilder` interface to allow the `T` of `DropDownItem<T>` to determine the widget displayed in the drop down list.
* Moved search logic to `DropDownItem.satisfiesSearch` which is now called from `DropDownList.search`.
* Added `DropDownItemSearchable` interface to allow the `T` of `DropDownItem<T>` to determine the way items are searched.
* Added `toString` method to `DropDownItem` to use for `DropDownItem.build` and `DropDownItem.satisfiesSearch`.

## 0.0.4

* Updated inline documentation.
* Added `DropDownResponse` and now `DropDown.show` returns `Future<DropDownResponse?>`.
* Added `DropDownData` and moved style builder to `DropDownStyle`.
* Added asynchronous data support through `DropDownData.future()`. `DropDownStyle` now has options to display a data loading widget and a failure widget.
* Added new constructors for `DropDown`.
* Updated README to reflect documentation changes.
* Updated basic example in README and removed outdated preview gifs.
* Renamed some of the type definitions and renamed the `listSortDelegate` option to `sortDelegate` to match the `searchDelegate` option.

## 0.0.3

* Fixed `Color.toARGB32()` not working on Flutter 3.27.3 by adding an extension.

## 0.0.2

* Removed the default values for `searchFillColor` and `searchCursorColor` (now defaults to `null`).
* Added style option `listSeparatorColor` to customize the default color of the list separator divider, which has been changed from `Colors.black12` to `Colors.transparent`.
* Added contextual color models `BrightnessColor` and `ThemedColor` to allow for contextually aware colors ([see more](README.md#custom-color-classes)).
* Allow for all options to utilize new contextual color models.
* Changed `listSeparatorColor` default from `Colors.transparent` to `BrightnessColor.bwa(alpha: 0.08)` and changed `SearchTextField` icon colors to be dependant on the brightness.
* Added documentation for the `BrightnessColor` and `ThemedColor` models.
* Added `contextualize` method for `Color` class.
* Added `ContextualColor` model and its documentation.
* Added additional options to `SearchTextField` to allow for custom icons and colors. Improved overall look and spacing of the search text field.
* Moved `shapeBorder` from `DropDown` class to `DropDownOptions` as `border`. Changed default to a rounded border of `24.0` instead of `15.0`.
* Added new constructors and static helper methods to `SelectedListItem` class.
* Added option to autofocus `SearchTextField`.
* Upgraded minimum Flutter SDK to 3.27.0.

## 0.0.1

* Initial creation of `ff_drop_down_list` library, forked from `drop_down_list` library [(MindInventory/drop_down_list)](https://github.com/Mindinventory/drop_down_list).
* Added `searchOnEmpty` option to allow the `searchDelegate` to search on an empty query.
* Added `listSortDelegate` option that will be called in the widget `initState()` as well as after every search.
* Added `onMultipleSelection` and `onSingleSelection` callbacks. When `enableMultipleSelection` is `true`, `onMultipleSelection` is called alongside `onSelection`. Otherwise, `onSelection` is called normally with the `onSingleSelection` being called with a single `SelectedListItem` (not a list).
* Added `listSelectedTileColor` to change the background color of selected items.
* Restructured the drop down classes to allow for context-aware styling. `DropDownStyle` and `DropDownOptions` instead of `DropDown` for options. `DropDown` is now used to launch the modal instead of `DropDownState`.
* Moved `SelectedListItem` to the main library file to make usage easier.
* Renamed style and option parameter names to improve clarity.
* Updated example project to reflect changes.
* Updated README to reflect changes.
