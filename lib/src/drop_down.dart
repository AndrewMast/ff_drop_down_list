import 'package:flutter/material.dart';

import 'search_text_field.dart';

/// This is a model class used to represent an item in a selectable list
class SelectedListItem<T> {
  /// Indicates whether the item is selected
  /// Default Value: [false]
  bool isSelected;

  /// Tha data of the item
  final T data;

  SelectedListItem({
    required this.data,
    this.isSelected = false,
  });
}

/// A callback function that is invoked when items are selected
typedef ItemSelectionCallback<T> = void Function(
  List<SelectedListItem<T>> selectedItems,
);

/// A callback function that is invoked when multiple items are selected
typedef MultipleItemSelectionCallback<T> = void Function(
  List<SelectedListItem<T>> selectedItems,
);

/// A callback function that is invoked when a single item is selected
typedef SingleItemSelectionCallback<T> = void Function(
  SelectedListItem<T> selectedItem,
);

/// A function type definition for building a widget for a specific list item
typedef ListItemBuilder<T> = Widget Function(
  int index,
  SelectedListItem<T> dataItem,
);

/// A function type definition for searching through a list of items based on the user's query
typedef SearchDelegate<T> = List<SelectedListItem<T>> Function(
  String query,
  List<SelectedListItem<T>> dataItems,
);

/// A function type definition for searching through a list of items based on the user's query
typedef ListSortDelegate<T> = int Function(
  SelectedListItem<T> a,
  SelectedListItem<T> b,
);

/// A function type definition for handling notifications from a draggable bottom sheet
typedef BottomSheetListener = bool Function(
  DraggableScrollableNotification draggableScrollableNotification,
);

/// A function type definition for building a [DropDownStyle]
typedef DropDownStyleBuilder = DropDownStyle Function(BuildContext context);

/// Manages the options and behavior of a dropdown
class DropDownOptions<T> {
  /// Enables single or multiple selection for the drop down list items
  /// Set to `true` to allow multiple items to be selected at once
  ///
  /// Default Value: [false]
  final bool enableMultipleSelection;

  /// The maximum number of items that can be selected when [enableMultipleSelection] is true
  final int? maxSelectedItems;

  /// A callback function triggered when the maximum selection limit is reached
  ///
  /// This callback is called when the number of selected items exceeds or reaches
  /// the value specified by [maxSelectedItems]
  final VoidCallback? onMaxSelectionReached;

  /// A callback function triggered when items are selected from the list
  final ItemSelectionCallback<T>? onSelected;

  /// A callback function triggered when items are selected from the list
  final MultipleItemSelectionCallback<T>? onMultipleSelected;

  /// A callback function triggered when a single item is selected from the list
  final SingleItemSelectionCallback<T>? onSingleSelected;

  /// A function that takes an [index] and [dataItem] as a parameter and returns a custom widget
  /// to display for the list item at that index
  final ListItemBuilder<T>? listItemBuilder;

  /// A delegate used to configure the custom search functionality in the dropdown
  final SearchDelegate<T>? searchDelegate;

  /// Controls whether the search list will be queried when the query string is empty.
  ///
  /// Particularly helpful when [searchDelegate] is set.
  ///
  /// Default Value: [false], The widget will not search when the query string is empty
  /// Set to [true] to search when the string is empty.
  final bool searchOnEmpty;

  /// A delegate used to sort the list of items after every search
  final ListSortDelegate<T>? listSortDelegate;

  /// Specifies whether a modal bottom sheet should be displayed using the root navigator
  ///
  /// Default Value: [false]
  final bool useRootNavigator;

  /// Specifies whether the bottom sheet can be dragged up and down and dismissed by swiping downwards
  ///
  /// Default Value: [true]
  final bool enableDrag;

  /// Specifies whether the bottom sheet will be dismissed when the user taps on the scrim
  ///
  /// Default Value: [true]
  final bool isDismissible;

  /// The initial fractional value of the parent container's height to use when
  /// displaying the [DropDown] widget in [DraggableScrollableSheet]
  ///
  /// Default Value: [0.7]
  final double initialSheetSize;

  /// The minimum fractional value of the parent container's height to use when
  /// displaying the [DropDown] widget in [DraggableScrollableSheet]
  ///
  /// Default Value: [0.3]
  final double minSheetSize;

  /// The maximum fractional value of the parent container's height to use when
  /// displaying the [DropDown] widget in [DraggableScrollableSheet]
  ///
  /// Default Value: [0.9]
  final double maxSheetSize;

  /// A listener that monitors events bubbling up from the BottomSheet
  ///
  /// The [bottomSheetListener] is triggered with a [DraggableScrollableNotification]
  /// when changes occur in the BottomSheet's draggable scrollable area
  final BottomSheetListener? bottomSheetListener;

  DropDownOptions({
    Key? key,
    this.enableMultipleSelection = false,
    this.maxSelectedItems,
    this.onMaxSelectionReached,
    this.onSelected,
    this.onMultipleSelected,
    this.onSingleSelected,
    this.listItemBuilder,
    this.searchDelegate,
    this.searchOnEmpty = false,
    this.listSortDelegate,
    this.useRootNavigator = false,
    this.enableDrag = true,
    this.isDismissible = true,
    this.initialSheetSize = 0.7,
    this.minSheetSize = 0.3,
    this.maxSheetSize = 0.9,
    this.bottomSheetListener,
  });
}

/// Manages the style and appearance of a dropdown
class DropDownStyle {
  /// The padding applied to the `ListView` that contains the dropdown items
  ///
  /// If not provided (i.e., null), [EdgeInsets.zero] will be applied
  final EdgeInsets? listPadding;

  /// The widget used as a separator between items in the dropdown list
  ///
  /// This can be any widget, such as a `Divider` or `SizedBox`
  ///
  /// If not provided (i.e., null), a default `Divider` with a color of
  /// [Colors.black12] and a height of 0 will be applied
  final Widget? listSeparator;

  /// The padding applied to the content of each `ListTile` in the dropdown list
  ///
  /// If not provided (i.e., null), the default padding of
  /// [EdgeInsets.symmetric(horizontal: 20)] will be applied
  final EdgeInsets? tileContentPadding;

  /// Defines the background color of each `ListTile` in the dropdown list
  ///
  /// Defaults to [Colors.transparent]
  final Color? tileColor;

  /// Defines the background color of each selected `ListTile` in the dropdown list
  ///
  /// Defaults to [tileColor]
  final Color? selectedTileColor;

  /// The widget displayed as a trailing icon when a list item is selected
  ///
  /// This is used only when [enableMultipleSelection] is true
  ///
  /// Default Value: [Icon(Icons.check_box)]
  final Widget selectedTileTrailingWidget;

  /// The widget displayed as a trailing icon when a list item is not selected
  ///
  /// This is used only when [enableMultipleSelection] is true
  ///
  /// Default Value: [Icon(Icons.check_box_outline_blank)]
  final Widget unselectedTileTrailingWidget;

  /// Sets the background color of the dropdown
  ///
  /// Default Value: [Colors.transparent]
  final Color backgroundColor;

  /// The padding applied to the dropdown container
  ///
  /// If not provided (i.e., null), the default value will be
  /// [EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom)]
  final EdgeInsets? padding;

  /// The padding applied to the dropdown header
  ///
  /// If not provided (i.e., null), the default value will be
  /// [EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0)]
  final EdgeInsets? headerPadding;

  /// The widget displayed as the title of the bottom sheet
  /// This allows customization of the title content
  ///
  /// If not provided, no title will be displayed
  final Widget? headerWidget;

  /// Defines a custom widget to display as the child of the submit button
  /// when [enableMultipleSelection] is true
  ///
  /// This is typically used with an [ElevatedButton]
  /// If not provided, a default button child will be used
  final Widget? submitButtonChild;

  /// Specifies the text displayed on the submit button when [enableMultipleSelection] is true
  ///
  /// This is only used if a custom [submitButtonChild] widget is not provided
  ///
  /// Default Value: [Submit]
  final String submitButtonText;

  /// Defines a custom widget to display as the child of the clear button
  /// when [enableMultipleSelection] is true
  ///
  /// This is typically used with an [ElevatedButton]
  /// If not provided, a default button child will be used
  final Widget? clearButtonChild;

  /// Specifies the text displayed on the clear button when [enableMultipleSelection] is true
  ///
  /// This is only used if a custom [clearButtonChild] widget is not provided
  ///
  /// Default Value: [Clear]
  final String clearButtonText;

  /// Controls the visibility of the search widget
  ///
  /// Default Value: [true], The widget will be visible by default
  /// Set to [false] to hide the widget
  final bool isSearchVisible;

  /// The padding applied to the search text field
  ///
  /// If not provided (i.e., null), the default value will be
  /// [EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)]
  final EdgeInsets? searchTextFieldPadding;

  /// Defines a custom widget to display the text box for searching
  ///
  /// If you provide a custom widget, you must include a [TextEditingController]
  /// for the [TextFormField] to manage the input
  ///
  /// If null, the default [SearchTextField] widget will be used
  final TextFormField? searchWidget;

  /// Specifies the text displayed on the search widget as hint text
  ///
  /// Default Value: [Search]
  final String searchHintText;

  /// This is the fill color for the input field
  ///
  /// Default Value: [Colors.black12]
  final Color searchFillColor;

  /// This is the cursor color for the input field
  ///
  /// Default Value: [Colors.black]
  final Color searchCursorColor;

  /// Controls the visibility of the "select all" widget when [enableMultipleSelection] is true
  ///
  /// Default Value: [true]
  final bool isSelectAllVisible;

  /// The padding applied to the "select all" and "deselect all" TextButtons
  ///
  /// If null, [EdgeInsets.zero] will be applied as the default padding
  final EdgeInsets? selectAllButtonPadding;

  /// Defines a custom widget to display as the child of the selectAll text button
  /// when [enableMultipleSelection] and [isSelectAllVisible] is true
  ///
  /// This is typically used with an [TextButton]
  /// If not provided, a default text button child will be used
  final Widget? selectAllButtonChild;

  /// Specifies the text displayed on the selectAll text button
  /// when [enableMultipleSelection] and [isSelectAllVisible] is true
  ///
  /// This is only used if a custom [selectAllButtonChild] widget is not provided
  ///
  /// Default Value: [Select All]
  final String selectAllButtonText;

  /// Defines a custom widget to display as the child of the deSelectAll text button
  /// when [enableMultipleSelection] and [isSelectAllVisible] is true
  ///
  /// This is typically used with an [TextButton]
  /// If not provided, a default text button child will be used
  final Widget? deselectAllButtonChild;

  /// Specifies the text displayed on the deSelectAll text button
  /// when [enableMultipleSelection] and [isSelectAllVisible] is true
  ///
  /// This is only used if a custom [deselectAllButtonChild] widget is not provided
  ///
  /// Default Value: [Deselect All]
  final String deselectAllButtonText;

  DropDownStyle({
    this.listPadding,
    this.listSeparator,
    this.tileContentPadding,
    this.tileColor,
    this.selectedTileColor,
    this.selectedTileTrailingWidget = const Icon(
      Icons.check_box,
    ),
    this.unselectedTileTrailingWidget = const Icon(
      Icons.check_box_outline_blank,
    ),
    this.backgroundColor = Colors.transparent,
    this.padding,
    this.headerPadding,
    this.headerWidget,
    this.submitButtonChild,
    this.submitButtonText = 'Submit',
    this.clearButtonChild,
    this.clearButtonText = 'Clear',
    this.isSearchVisible = true,
    this.searchTextFieldPadding,
    this.searchWidget,
    this.searchHintText = 'Search',
    this.searchFillColor = Colors.black12,
    this.searchCursorColor = Colors.black,
    this.isSelectAllVisible = true,
    this.selectAllButtonPadding,
    this.selectAllButtonChild,
    this.selectAllButtonText = 'Select All',
    this.deselectAllButtonChild,
    this.deselectAllButtonText = 'Deselect All',
  });
}

/// Manages the state and behavior of a dropdown
/// This includes configuring and displaying a modal bottom sheet containing the dropdown items
class DropDown<T> {
  /// The data for the dropdown
  ///
  /// If left blank, [unbuiltData] will used.
  final List<SelectedListItem<T>>? data;

  /// The data for the dropdown that is unbuilt
  ///
  /// Will be used if [data] is left blank.
  /// Each item in the list will be wrapped in a [SelectedListItem].
  final List<T>? unbuiltData;

  /// The drop down options
  ///
  /// If left blank, a default [DropDownOptions] will be used.
  final DropDownOptions<T>? options;

  /// The style for the drop down
  ///
  /// If left blank, [styleBuilder] will be used to build a style.
  /// If there is no provided builder, a default [DropDownStyle] will be used.
  final DropDownStyle? style;

  /// A style builder to make a [DropDownStyle] if [style] is not already provided.
  ///
  /// If left blank, a default [DropDownStyle] will be used.
  final DropDownStyleBuilder? styleBuilder;

  /// The shape of the bottom sheet
  ///
  /// If not provided (i.e., null), the default value will be
  /// [RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)))]
  final ShapeBorder? shapeBorder;

  DropDown({
    this.data,
    this.unbuiltData,
    this.options,
    this.style,
    this.styleBuilder,
    this.shapeBorder,
  });

  /// Show the drop down modal.
  void show(BuildContext context) {
    DropDownOptions<T> modalOptions = options ?? DropDownOptions<T>();

    List<SelectedListItem<T>> modalData = data ??
        unbuiltData
            ?.map<SelectedListItem<T>>(
                (T item) => SelectedListItem<T>(data: item))
            .toList() ??
        [];

    showModalBottomSheet(
      useRootNavigator: modalOptions.useRootNavigator,
      isScrollControlled: true,
      enableDrag: modalOptions.enableDrag,
      isDismissible: modalOptions.isDismissible,
      shape: shapeBorder ??
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15.0),
            ),
          ),
      context: context,
      clipBehavior: Clip.hardEdge,
      builder: (BuildContext context) {
        return DropDownBody<T>(
          data: modalData,
          options: modalOptions,
          style: style ?? styleBuilder?.call(context) ?? DropDownStyle(),
        );
      },
    );
  }
}

/// This is the dropdown widget will be displayed in the bottom sheet body
class DropDownBody<T> extends StatefulWidget {
  final List<SelectedListItem<T>> data;

  final DropDownOptions<T> options;

  final DropDownStyle style;

  const DropDownBody({
    required this.data,
    required this.options,
    required this.style,
    super.key,
  });

  @override
  State<DropDownBody<T>> createState() => _DropDownBodyState<T>();
}

class _DropDownBodyState<T> extends State<DropDownBody<T>> {
  /// The list of items that are currently being displayed
  List<SelectedListItem<T>> list = [];

  @override
  void initState() {
    super.initState();

    list = widget.data;

    _sortSearchList();

    _setSearchWidgetListener();
  }

  @override
  Widget build(BuildContext context) {
    final isSelectAll = list.fold(true, (p, e) => p && (e.isSelected));
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: widget.options.bottomSheetListener,
      child: DraggableScrollableSheet(
        initialChildSize: widget.options.initialSheetSize,
        minChildSize: widget.options.minSheetSize,
        maxChildSize: widget.options.maxSheetSize,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            color: widget.style.backgroundColor,
            padding: widget.style.padding ??
                EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: widget.style.headerPadding ??
                      const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 10.0,
                      ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Bottom sheet title text
                      (widget.style.headerWidget != null)
                          ? Expanded(
                              child: widget.style.headerWidget!,
                            )
                          : const Spacer(),

                      /// Submit Elevated Button
                      if (widget.options.enableMultipleSelection)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: onSubmitButtonPressed,
                              child: widget.style.submitButtonChild ??
                                  Text(widget.style.submitButtonText),
                            ),

                            /// Clear Elevated Button
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: ElevatedButton(
                                onPressed: onClearButtonPressed,
                                child: widget.style.clearButtonChild ??
                                    Text(widget.style.clearButtonText),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                /// A [TextField] that displays a list of suggestions as the user types with clear button.
                if (widget.style.isSearchVisible)
                  Padding(
                    padding: widget.style.searchTextFieldPadding ??
                        const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                    child: widget.style.searchWidget ??
                        SearchTextField(
                          onTextChanged: _buildSearchList,
                          searchHintText: widget.style.searchHintText,
                          searchFillColor: widget.style.searchFillColor,
                          searchCursorColor: widget.style.searchCursorColor,
                        ),
                  ),

                /// Select or Deselect TextButton when enableMultipleSelection is enabled
                if (widget.options.enableMultipleSelection &&
                    widget.style.isSelectAllVisible &&
                    list.isNotEmpty)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: widget.style.selectAllButtonPadding ??
                          EdgeInsets.zero,
                      child: TextButton(
                        onPressed: () => setState(() {
                          for (var element in list) {
                            element.isSelected = !isSelectAll;
                          }
                        }),
                        child: isSelectAll
                            ? widget.style.deselectAllButtonChild ??
                                Text(widget.style.deselectAllButtonText)
                            : widget.style.selectAllButtonChild ??
                                Text(widget.style.selectAllButtonText),
                      ),
                    ),
                  ),

                /// ListView (list of data with check box for multiple selection & on tile tap single selection)
                Flexible(
                  child: ListView.separated(
                    controller: scrollController,
                    itemCount: list.length,
                    padding: widget.style.listPadding ?? EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      bool isSelected = list[index].isSelected;
                      return Material(
                        color: Colors.transparent,
                        clipBehavior: Clip.hardEdge,
                        child: ListTile(
                          onTap: () {
                            if (widget.options.enableMultipleSelection) {
                              if (!isSelected &&
                                  widget.options.maxSelectedItems != null) {
                                if (list.where((e) => e.isSelected).length >=
                                    widget.options.maxSelectedItems!) {
                                  widget.options.onMaxSelectionReached?.call();
                                  return;
                                }
                              }
                              setState(() {
                                list[index].isSelected = !isSelected;
                              });
                            } else {
                              widget.options.onSelected?.call([list[index]]);

                              widget.options.onSingleSelected
                                  ?.call(list[index]);

                              _onUnFocusKeyboardAndPop();
                            }
                          },
                          title: widget.options.listItemBuilder
                                  ?.call(index, list[index]) ??
                              Text(
                                list[index].data.toString(),
                              ),
                          trailing: widget.options.enableMultipleSelection
                              ? isSelected
                                  ? widget.style.selectedTileTrailingWidget
                                  : widget.style.unselectedTileTrailingWidget
                              : const SizedBox.shrink(),
                          contentPadding: widget.style.tileContentPadding ??
                              const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                          tileColor: (isSelected
                                  ? widget.style.selectedTileColor
                                  : null) ??
                              widget.style.tileColor ??
                              Colors.transparent,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => getSeparatorWidget,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget get getSeparatorWidget =>
      widget.style.listSeparator ??
      const Divider(
        color: Colors.black12,
        height: 0,
      );

  /// Handle the submit button pressed
  void onSubmitButtonPressed() {
    List<SelectedListItem<T>> selectedList =
        widget.data.where((element) => element.isSelected).toList();

    widget.options.onSelected?.call(selectedList);

    widget.options.onMultipleSelected?.call(selectedList);

    _onUnFocusKeyboardAndPop();
  }

  /// Handle the clear button pressed
  void onClearButtonPressed() {
    for (final element in list) {
      element.isSelected = false;
    }

    setState(() {});
  }

  /// This helps when search enabled & show the filtered data in list.
  void _buildSearchList(String query) {
    if (query.isNotEmpty || widget.options.searchOnEmpty) {
      list = widget.options.searchDelegate?.call(query, widget.data) ??
          widget.data
              .where((element) => element.data
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
    } else {
      list = widget.data;
    }

    _sortSearchList();

    setState(() {});
  }

  /// Sorts the list items using the [DropDownOptions.listSortDelegate]
  void _sortSearchList() {
    if (widget.options.listSortDelegate != null) {
      list.sort(widget.options.listSortDelegate);
    }
  }

  /// This helps to UnFocus the keyboard & pop from the bottom sheet.
  void _onUnFocusKeyboardAndPop() {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();
  }

  /// This helps to add listener on search field controller
  void _setSearchWidgetListener() {
    TextFormField? searchField = widget.style.searchWidget;

    searchField?.controller?.addListener(() {
      _buildSearchList(searchField.controller?.text ?? '');
    });
  }
}
