## Unreleased

* Removed the default values for `searchFillColor` and `searchCursorColor` (now defaults to `null`).
* Added style option `listSeparatorColor` to customize the default color of the list separator divider, which has been changed from `Colors.black12` to `Colors.transparent`.
* Added contextual color models `BrightnessColor` and `ThemedColor` to allow for contextually aware colors ([see more](README#custom-color-models)).
* Allow for all options to utilize new contextual color models.
* Changed `listSeparatorColor` default from `Colors.transparent` to `BrightnessColor.bwa(alpha: 0.08)` and changed `SearchTextField` icon colors to be dependant on the brightness.
* Added documentation for the `BrightnessColor` and `ThemedColor` models.
* Added `contextualize` method for `Color` class.
* Added `ContextualColor` model and its documentation.
* Added additional options to `SearchTextField` to allow for custom icons and colors. Improved overall look and spacing of the search text field.
* Moved `shapeBorder` from `DropDown` class to `DropDownOptions` as `border`. Changed default to a rounded border of `24.0` instead of `15.0`.

## 0.0.1

* Initial creation of `ff_drop_down_list` library, forked from `drop_down_list` library [(Mindinventory/drop_down_list)](https://github.com/Mindinventory/drop_down_list).
* Added `searchOnEmpty` option to allow the `searchDelegate` to search on an empty query.
* Added `listSortDelegate` option that will be called in the widget `initState()` as well as after every search.
* Added `onMultipleSelection` and `onSingleSelection` callbacks. When `enableMultipleSelection` is `true`, `onMultipleSelection` is called alongside `onSelection`. Otherwise, `onSelection` is called normally with the `onSingleSelection` being called with a single `SelectedListItem` (not a list).
* Added `listSelectedTileColor` to change the background color of selected items.
* Restructured the drop down classes to allow for context-aware styling. `DropDownStyle` and `DropDownOptions` instead of `DropDown` for options. `DropDown` is now used to launch the modal instead of `DropDownState`.
* Moved `SelectedListItem` to the main library file to make usage easier.
* Renamed style and option parameter names to improve clarity.
* Updated example project to reflect changes.
* Updated README to reflect changes.
