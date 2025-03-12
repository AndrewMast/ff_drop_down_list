import 'package:flutter/material.dart';
import 'dart:async';

import '../model/contextual_property.dart';
import '../model/contextual_colors.dart';
import 'search_text_field.dart';

/// An alias for a [List] of [DropDownItem]s.
typedef DropDownList<T> = List<DropDownItem<T>>;

/// A callback function that is invoked when items are selected
typedef ItemSelectedCallback<T> = void Function(DropDownList<T> items);

/// A callback function that is invoked when multiple items are selected
typedef MultipleItemSelectedCallback<T> = void Function(DropDownList<T> items);

/// A callback function that is invoked when a single item is selected
typedef SingleItemSelectedCallback<T> = void Function(DropDownItem<T> item);

/// A function type definition for building a widget for a specific list item
typedef ListItemBuilder<T> = Widget Function(int index, DropDownItem<T> item);

/// A function type definition for searching through a list of items based on the user's query
typedef SearchDelegate<T> = DropDownList<T> Function(
  String query,
  DropDownList<T> items,
);

/// A function type definition for sorting through the list of items.
typedef SortDelegate<T> = int Function(DropDownItem<T> a, DropDownItem<T> b);

/// A function type definition for handling notifications from a draggable bottom sheet
typedef BottomSheetListener = bool Function(
  DraggableScrollableNotification notification,
);

/// A function type definition for building a [DropDownStyle]
typedef DropDownStyleBuilder = DropDownStyle Function(BuildContext context);

/// This is a model class used to represent an item in a selectable list
class DropDownItem<T> implements Comparable<DropDownItem<T>> {
  /// Tha data of the item.
  final T data;

  /// Indicates whether the item is selected.
  ///
  /// Default Value: `false`
  bool isSelected;

  /// Create a new [DropDownItem].
  DropDownItem(this.data, {this.isSelected = false});

  /// Create a new selected [DropDownItem].
  DropDownItem.selected(this.data) : isSelected = true;

  /// Create a new unselected [DropDownItem].
  DropDownItem.unselected(this.data) : isSelected = false;

  /// Build a [DropDownItem] list.
  static DropDownList<T> list<T>(List<T> items) {
    return items.map((item) => DropDownItem(item)).toList();
  }

  /// Selects the item
  void select([bool select = true]) => isSelected = select;

  /// Deselects the item
  void deselect([bool deselect = true]) => select(!deselect);

  /// Compares this drop down item to another drop down item.
  ///
  /// Assumes the datatype of [data] can be cast as [Comparable]
  /// or implements [Comparable.compareTo].
  ///
  /// Gets overridden by [DropDownOptions.sortDelegate].
  @override
  int compareTo(DropDownItem<T> other) {
    return Comparable.compare(data as Comparable, other.data as Comparable);
  }
}

/// Adds a method to convert a list into a list of [DropDownItem]s.
extension ListAsDropDownItems<T> on List<T> {
  /// Convert the list into a list of [DropDownItem]s.
  DropDownList<T> asDropDownItems() => DropDownItem.list(this);
}

/// Adds a method to convert a list of [DropDownItem] into a normal list.
extension ListAsItemData<T> on DropDownList<T> {
  /// Convert the list from a list of [DropDownItem]s to a list of normal items.
  List<T> asItemData() => map<T>((item) => item.data).toList();
}

/// Adds methods to select or deselect [DropDownItem]s and adds
/// getters for selected/unselected subsets of the list.
extension DropDownListSelection<T> on DropDownList<T> {
  /// Selects all of the [DropDownItem]s in the list
  void selectAll([bool select = true]) {
    for (final item in this) {
      item.isSelected = select;
    }
  }

  /// Deselects all of the [DropDownItem]s in the list
  void deselectAll([bool deselect = true]) => selectAll(!deselect);

  /// Selects all of the [DropDownItem]s with data contained in the provided list of data
  void select(
    List<T> data, {
    bool select = true,
    bool deselectOthers = false,
  }) {
    for (final item in this) {
      if (data.contains(item.data)) {
        item.isSelected = select;
      } else if (deselectOthers) {
        item.isSelected = !select;
      }
    }
  }

  /// Deselects all of the [DropDownItem]s with data contained in the provided list of data
  void deselect(
    List<T> data, {
    bool deselect = true,
    bool selectOthers = false,
  }) =>
      select(
        data,
        select: !deselect,
        deselectOthers: selectOthers,
      );

  /// Returns the subset of [DropDownItem]s that are selected
  DropDownList<T> get selected =>
      where((e) => e.isSelected).toList(growable: false);

  /// Returns the subset of [DropDownItem]s that are unselected
  DropDownList<T> get unselected =>
      where((e) => !e.isSelected).toList(growable: false);
}

/// Manages the data of a dropdown
class DropDownData<T> {
  /// The items for the dropdown
  ///
  /// If [future] is provided, these items will be ignored.
  final DropDownList<T>? items;

  /// A future that will return the items for the dropdown
  final Future<DropDownList<T>>? future;

  /// Whether the items are coming from a [Future]
  bool get isFuture => future != null;

  /// Create a data object from a list of [DropDownItem]s
  const DropDownData(DropDownList<T> this.items) : future = null;

  /// Create a data object from a list of items
  DropDownData.raw(List<T> items) : this(items.asDropDownItems());

  /// Create a data object from a future that will return a list of [DropDownItem]s
  const DropDownData.future(Future<DropDownList<T>> this.future) : items = null;

  /// Create a data object from a future that will return a list of items
  DropDownData.rawFuture(Future<List<T>> future)
      : this.future(future.then((list) => list.asDropDownItems()));

  /// Create a data object from either a list of [DropDownItem]s
  /// or a future that will return a list
  DropDownData.from(FutureOr<DropDownList<T>> data)
      : items = data is DropDownList<T> ? data : null,
        future = data is Future<DropDownList<T>> ? data : null;

  /// Create a data object from either a list of items
  /// or a future that will return a list
  DropDownData.fromRaw(FutureOr<List<T>> data)
      : items = data is List<T> ? data.asDropDownItems() : null,
        future = data is Future<List<T>>
            ? data.then((list) => list.asDropDownItems())
            : null;

  /// Selects all of the [DropDownItem]s in the list
  void selectAll([bool select = true]) {
    items?.selectAll(select);

    // ignore: discarded_futures
    future?.then((list) => list.selectAll(select));
  }

  /// Deselects all of the [DropDownItem]s in the list
  void deselectAll([bool deselect = true]) {
    items?.deselectAll(deselect);

    // ignore: discarded_futures
    future?.then((list) => list.deselectAll(deselect));
  }

  /// Selects all of the [DropDownItem]s with data contained in the provided list of data
  void select(
    List<T> data, {
    bool select = true,
    bool deselectOthers = false,
  }) {
    items?.select(data, select: select, deselectOthers: deselectOthers);

    // ignore: discarded_futures
    future?.then(
      (list) => list.select(
        data,
        select: select,
        deselectOthers: deselectOthers,
      ),
    );
  }

  /// Deselects all of the [DropDownItem]s with data contained in the provided list of data
  void deselect(
    List<T> data, {
    bool deselect = true,
    bool selectOthers = false,
  }) {
    items?.deselect(data, deselect: deselect, selectOthers: selectOthers);

    // ignore: discarded_futures
    future?.then(
      (list) => list.deselect(
        data,
        deselect: deselect,
        selectOthers: selectOthers,
      ),
    );
  }
}

/// Manages the options and behavior of a dropdown
class DropDownOptions<T> {
  /// Enables single or multiple selection for the drop down list items
  /// Set to `true` to allow multiple items to be selected at once
  ///
  /// Default Value: `false`
  final bool enableMultipleSelection;

  /// The maximum number of items that can be selected when [enableMultipleSelection] is true
  final int? maxSelectedItems;

  /// A callback function triggered when the maximum selection limit is reached
  ///
  /// This callback is called when the number of selected items exceeds or reaches
  /// the value specified by [maxSelectedItems]
  final VoidCallback? onMaxSelectionReached;

  /// A callback function triggered when items are selected from the list
  final ItemSelectedCallback<T>? onSelected;

  /// A callback function triggered when multiple items are selected from the list
  final MultipleItemSelectedCallback<T>? onMultipleSelected;

  /// A callback function triggered when a single item is selected from the list
  final SingleItemSelectedCallback<T>? onSingleSelected;

  /// A function that takes an [int] index and [DropDownItem] item as a parameter
  /// and returns a custom widget to display for the list item at that index.
  final ListItemBuilder<T>? listItemBuilder;

  /// Controls whether the search list will be queried when the query string is empty
  ///
  /// Particularly helpful when [searchDelegate] is set.
  ///
  /// Default Value: `false`, The widget will not search when the query string is empty
  /// Set to `true` to search when the string is empty.
  final bool searchOnEmpty;

  /// A delegate used to configure the custom search functionality in the dropdown
  final SearchDelegate<T>? searchDelegate;

  /// Whether the list of items will be sorted after every search
  ///
  /// When enabled, unless a [sortDelegate] is set, the default [List.sort] will be
  /// used, which will utilize the [DropDownItem.compareTo] method to sort the list.
  ///
  /// Default Value: `false`
  final bool sortAfterSearch;

  /// A delegate used to sort the list of items after every search
  final SortDelegate<T>? sortDelegate;

  /// Specifies whether a modal bottom sheet should be displayed using the root navigator
  ///
  /// Default Value: `false`
  final bool useRootNavigator;

  /// Specifies whether the bottom sheet can be dragged up and down and dismissed by swiping downwards
  ///
  /// Default Value: `true`
  final bool enableDrag;

  /// Specifies whether the bottom sheet will be dismissed when the user taps on the scrim
  ///
  /// Default Value: `true`
  final bool isDismissible;

  /// The initial fractional value of the parent container's height to use when
  /// displaying the [DropDown] widget in [DraggableScrollableSheet]
  ///
  /// Default Value: `0.7`
  final double initialSheetSize;

  /// The minimum fractional value of the parent container's height to use when
  /// displaying the [DropDown] widget in [DraggableScrollableSheet]
  ///
  /// Default Value: `0.3`
  final double minSheetSize;

  /// The maximum fractional value of the parent container's height to use when
  /// displaying the [DropDown] widget in [DraggableScrollableSheet]
  ///
  /// Default Value: `0.9`
  final double maxSheetSize;

  /// A listener that monitors events bubbling up from the BottomSheet
  ///
  /// The [bottomSheetListener] is triggered with a [DraggableScrollableNotification]
  /// when changes occur in the BottomSheet's draggable scrollable area
  final BottomSheetListener? bottomSheetListener;

  const DropDownOptions({
    Key? key,
    this.enableMultipleSelection = false,
    this.maxSelectedItems,
    this.onMaxSelectionReached,
    this.onSelected,
    this.onMultipleSelected,
    this.onSingleSelected,
    this.listItemBuilder,
    this.searchOnEmpty = false,
    this.searchDelegate,
    this.sortAfterSearch = false,
    this.sortDelegate,
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
  /// [Colors.transparent] and a height of 0 will be applied
  final Widget? listSeparator;

  /// Defines the color of the default list separator `Divider`.
  ///
  /// Defaults to [Colors.transparent]
  final Color? listSeparatorColor;

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
  /// This is used only when [DropDownOptions.enableMultipleSelection] is true
  ///
  /// Default Value: [Icon(Icons.check_box)]
  final Widget selectedTileTrailingWidget;

  /// The widget displayed as a trailing icon when a list item is not selected
  ///
  /// This is used only when [DropDownOptions.enableMultipleSelection] is true
  ///
  /// Default Value: [Icon(Icons.check_box_outline_blank)]
  final Widget unselectedTileTrailingWidget;

  /// Sets the background color of the dropdown
  ///
  /// Default Value: [Colors.transparent]
  final Color backgroundColor;

  /// The border shape of the bottom sheet
  ///
  /// If not provided (i.e., null), the default value will be
  /// [RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)))]
  final ShapeBorder? border;

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
  /// when [DropDownOptions.enableMultipleSelection] is true
  ///
  /// This is typically used with an [ElevatedButton]
  /// If not provided, a default button child will be used
  final Widget? submitButtonChild;

  /// Specifies the text displayed on the submit button when [DropDownOptions.enableMultipleSelection] is true
  ///
  /// This is only used if a custom [submitButtonChild] widget is not provided
  ///
  /// Default Value: `"Submit"`
  final String submitButtonText;

  /// Defines a custom widget to display as the child of the clear button
  /// when [DropDownOptions.enableMultipleSelection] is true
  ///
  /// This is typically used with an [ElevatedButton]
  /// If not provided, a default button child will be used
  final Widget? clearButtonChild;

  /// Specifies the text displayed on the clear button when [DropDownOptions.enableMultipleSelection] is true
  ///
  /// This is only used if a custom [clearButtonChild] widget is not provided
  ///
  /// Default Value: `"Clear"`
  final String clearButtonText;

  /// Controls the visibility of the search widget
  ///
  /// Default Value: `true`, The widget will be visible by default
  /// Set to `false` to hide the widget
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
  /// Default Value: `"Search"`
  final String searchHintText;

  /// The fill color for the search input field
  ///
  /// If null, will default to the theme's default input decoration fill color.
  final Color? searchFillColor;

  /// The color of the cursor for the search input field
  ///
  /// If null, will default to the theme's default input cursor color.
  final Color? searchCursorColor;

  /// The border radius of the search input field
  ///
  /// Default Value: [BorderRadius.circular(24.0)]
  final BorderRadius? searchBorderRadius;

  /// The prefix icon for the search input field
  ///
  /// Default Value: [Icon(Icons.search)]
  final Widget? searchPrefixIcon;

  /// The prefix icon color for the search input field
  ///
  /// Default Value: [BrightnessColor.bwa(alpha: 0.5)]
  final Color? searchPrefixColor;

  /// The suffix icon for the search input field
  ///
  /// Pressing this icon clears the input field.
  ///
  /// Default Value: [Icon(Icons.clear)]
  final Widget? searchSuffixIcon;

  /// The suffix icon color for the search input field
  ///
  /// Default Value: [BrightnessColor.bwa(alpha: 0.5)]
  final Color? searchSuffixColor;

  /// Controls whether the search input field will autofocus
  ///
  /// Default Value: `false`
  final bool searchAutofocus;

  /// Controls the visibility of the "select all" widget when [DropDownOptions.enableMultipleSelection] is true
  ///
  /// Default Value: `true`
  final bool isSelectAllVisible;

  /// The padding applied to the "select all" and "deselect all" TextButtons
  ///
  /// If null, [EdgeInsets.zero] will be applied as the default padding
  final EdgeInsets? selectAllButtonPadding;

  /// Defines a custom widget to display as the child of the selectAll text button
  /// when [DropDownOptions.enableMultipleSelection] and [isSelectAllVisible] is true
  ///
  /// This is typically used with an [TextButton]
  /// If not provided, a default text button child will be used
  final Widget? selectAllButtonChild;

  /// Specifies the text displayed on the selectAll text button
  /// when [DropDownOptions.enableMultipleSelection] and [isSelectAllVisible] is true
  ///
  /// This is only used if a custom [selectAllButtonChild] widget is not provided
  ///
  /// Default Value: `"Select All"`
  final String selectAllButtonText;

  /// Defines a custom widget to display as the child of the deSelectAll text button
  /// when [DropDownOptions.enableMultipleSelection] and [isSelectAllVisible] is true
  ///
  /// This is typically used with an [TextButton]
  /// If not provided, a default text button child will be used
  final Widget? deselectAllButtonChild;

  /// Specifies the text displayed on the deSelectAll text button
  /// when [DropDownOptions.enableMultipleSelection] and [isSelectAllVisible] is true
  ///
  /// This is only used if a custom [deselectAllButtonChild] widget is not provided
  ///
  /// Default Value: `"Deselect All"`
  final String deselectAllButtonText;

  /// The widget to display when data is being loaded from [DropDownData.future]
  ///
  /// Default Value: [Align(alignment: Alignment.topCenter, child: CircularProgressIndicator())]
  final Widget? dataLoadingWidget;

  /// The widget to display when data fails to load from [DropDownData.future]
  ///
  /// By default the text is pulled from [dataFailureText].
  ///
  /// Default Value: [Align(alignment: Alignment.topCenter, child: Text('Unable to load data.'))]
  final Widget? dataFailureWidget;

  /// The text to display when data fails to load from [DropDownData.future]
  ///
  /// Default Value: `"Unable to load data."`
  final String dataFailureText;

  /// A style builder to make a [DropDownStyle]
  ///
  /// If provided, all other style options will be ignored in favor of
  /// the style options in the [DropDownStyle] returned by the builder.
  final DropDownStyleBuilder? builder;

  const DropDownStyle({
    this.listPadding,
    this.listSeparator,
    this.listSeparatorColor,
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
    this.border,
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
    this.searchFillColor,
    this.searchCursorColor,
    this.searchBorderRadius,
    this.searchPrefixIcon,
    this.searchPrefixColor,
    this.searchSuffixIcon,
    this.searchSuffixColor,
    this.searchAutofocus = false,
    this.isSelectAllVisible = false,
    this.selectAllButtonPadding,
    this.selectAllButtonChild,
    this.selectAllButtonText = 'Select All',
    this.deselectAllButtonChild,
    this.deselectAllButtonText = 'Deselect All',
    this.dataLoadingWidget,
    this.dataFailureWidget,
    this.dataFailureText = 'Unable to load data.',
    this.builder,
  });

  /// Create a [DropDownStyle] that will use a [DropDownStyleBuilder]
  /// to resolve its style options using the provided [BuildContext].
  const DropDownStyle.build(DropDownStyleBuilder builder)
      : this(builder: builder);

  /// Resolves the style by potentially using the optional [builder]
  /// to create a contextually aware [DropDownStyle]
  DropDownStyle resolve(BuildContext context) => builder?.call(context) ?? this;
}

/// The response returned from a drop down
class DropDownResponse<T> {
  /// Whether the response contains multiple items or a singular one
  final bool multipleSelection;

  /// The single selected item, null if [multipleSelection] is `true`
  final DropDownItem<T>? single;

  /// The multiple selected items, null if [multipleSelection] is `false`
  final DropDownList<T>? multiple;

  /// The selected items
  final DropDownList<T> items;

  /// The data of the selected items
  List<T> get data => items.asItemData();

  /// Create a new response
  DropDownResponse({
    required this.items,
    this.single,
    this.multiple,
    this.multipleSelection = false,
  });

  /// Create a new response for a single selected item
  DropDownResponse.single(DropDownItem<T> singleItem)
      : single = singleItem,
        multiple = null,
        items = [singleItem],
        multipleSelection = false;

  /// Create a new response for multiple selected items
  DropDownResponse.multiple(DropDownList<T> multipleItems)
      : single = null,
        multiple = multipleItems,
        items = multipleItems,
        multipleSelection = true;
}

/// Manages the state and behavior of a dropdown
///
/// This includes configuring and displaying a modal bottom sheet containing the dropdown items.
class DropDown<T> {
  /// The data for the dropdown
  final DropDownData<T> data;

  /// The options for the dropdown
  ///
  /// If left blank, a default [DropDownOptions] will be used.
  final DropDownOptions<T>? options;

  /// The style for the dropdown
  ///
  /// If left blank, a default [DropDownStyle] will be used.
  final DropDownStyle? style;

  const DropDown({
    required this.data,
    this.options,
    this.style,
  });

  /// Create a [DropDown] using a list of [DropDownItem]s
  DropDown.items(DropDownList<T> items, {this.options, this.style})
      : data = DropDownData(items);

  /// Create a [DropDown] using a list of items
  DropDown.raw(List<T> items, {this.options, this.style})
      : data = DropDownData.raw(items);

  /// Create a [DropDown] using a future that will return a list of [DropDownItem]s
  DropDown.future(Future<DropDownList<T>> future, {this.options, this.style})
      : data = DropDownData.future(future);

  /// Create a [DropDown] using a future that will return a list of items
  DropDown.rawFuture(Future<List<T>> future, {this.options, this.style})
      : data = DropDownData.rawFuture(future);

  /// Show the drop down modal.
  Future<DropDownResponse<T>?> show(BuildContext context) async {
    final DropDownOptions<T> modalOptions = options ?? DropDownOptions<T>();
    final DropDownStyle modalStyle = style?.resolve(context) ?? DropDownStyle();

    return showModalBottomSheet<DropDownResponse<T>>(
      useRootNavigator: modalOptions.useRootNavigator,
      isScrollControlled: true,
      enableDrag: modalOptions.enableDrag,
      isDismissible: modalOptions.isDismissible,
      shape: modalStyle.border ??
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24.0),
            ),
          ),
      context: context,
      clipBehavior: Clip.hardEdge,
      builder: (BuildContext context) {
        return DropDownBody<T>(
          data: data,
          options: modalOptions,
          style: style?.resolve(context) ?? DropDownStyle(),
        );
      },
    );
  }
}

/// This is the dropdown widget that will be displayed in the bottom sheet body
class DropDownBody<T> extends StatefulWidget {
  final DropDownData<T> data;

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
  DropDownList<T> list = [];

  /// The full, unfiltered list of items
  DropDownList<T> unfilteredList = [];

  /// The current search query
  String? search;

  /// Whether the [DropDownData.future] is loading
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.data.isFuture) {
      isLoading = true;
    } else {
      unfilteredList = list = widget.data.items ?? [];
    }

    _sortSearchList();

    _setSearchWidgetListener();
  }

  /// Saves the data coming from the [DropDownData.future]
  /// if the data has not been saved yet.
  void _saveFutureData(DropDownList<T>? items) {
    if (items != null && isLoading) {
      isLoading = false;

      unfilteredList = list = items;

      if (search != null) {
        _performSearch(search!);
      }

      _sortSearchList();
    }
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
            color: ContextualProperty.resolveAs(
              widget.style.backgroundColor,
              context,
            ),
            padding: widget.style.padding ??
                EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.style.headerWidget != null ||
                    widget.options.enableMultipleSelection)
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
                        const EdgeInsets.all(10),
                    child: widget.style.searchWidget ??
                        SearchTextField(
                          onTextChanged: _updateSearchQuery,
                          hintText: widget.style.searchHintText,
                          fillColor: widget.style.searchFillColor,
                          cursorColor: widget.style.searchCursorColor,
                          borderRadius: widget.style.searchBorderRadius,
                          prefixIcon: widget.style.searchPrefixIcon,
                          prefixColor: widget.style.searchPrefixColor,
                          suffixIcon: widget.style.searchSuffixIcon,
                          suffixColor: widget.style.searchSuffixColor,
                          autofocus: widget.style.searchAutofocus,
                        ),
                  )

                /// The search is not visible, add some padding.
                else if (widget.style.headerWidget != null ||
                    widget.options.enableMultipleSelection)
                  const Padding(padding: EdgeInsets.only(bottom: 10)),

                /// Select or Deselect TextButton when enableMultipleSelection is enabled
                /// and maxSelectedItems is not set
                if (widget.style.isSelectAllVisible &&
                    widget.options.enableMultipleSelection &&
                    widget.options.maxSelectedItems == null &&
                    list.isNotEmpty)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: widget.style.selectAllButtonPadding ??
                          EdgeInsets.zero,
                      child: TextButton(
                        onPressed: () => setState(() {
                          for (final element in list) {
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
                  child: FutureBuilder<DropDownList<T>>(
                    future: widget.data.future,
                    builder: (BuildContext context,
                        AsyncSnapshot<DropDownList<T>> snapshot) {
                      if (snapshot.hasData) {
                        _saveFutureData(snapshot.data);
                      }

                      if (snapshot.connectionState == ConnectionState.none ||
                          snapshot.hasData) {
                        return ListView.separated(
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
                                        widget.options.maxSelectedItems !=
                                            null) {
                                      if (unfilteredList.selected.length >=
                                          widget.options.maxSelectedItems!) {
                                        widget.options.onMaxSelectionReached
                                            ?.call();
                                        return;
                                      }
                                    }
                                    setState(() {
                                      list[index].isSelected = !isSelected;
                                    });
                                  } else {
                                    _submitSingle(list[index]);
                                  }
                                },
                                title: widget.options.listItemBuilder
                                        ?.call(index, list[index]) ??
                                    Text(
                                      list[index].data.toString(),
                                    ),
                                trailing: widget.options.enableMultipleSelection
                                    ? isSelected
                                        ? widget
                                            .style.selectedTileTrailingWidget
                                        : widget
                                            .style.unselectedTileTrailingWidget
                                    : const SizedBox.shrink(),
                                contentPadding:
                                    widget.style.tileContentPadding ??
                                        const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                tileColor: ContextualProperty.resolveAs(
                                  (isSelected
                                          ? widget.style.selectedTileColor
                                          : null) ??
                                      widget.style.tileColor ??
                                      Colors.transparent,
                                  context,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              widget.style.listSeparator ??
                              Divider(
                                color: ContextualProperty.resolveAs(
                                  widget.style.listSeparatorColor ??
                                      BrightnessColor.bwa(alpha: 0.08),
                                  context,
                                ),
                                height: 0,
                              ),
                        );
                      } else if (snapshot.connectionState ==
                              ConnectionState.active ||
                          snapshot.connectionState == ConnectionState.waiting) {
                        return widget.style.dataLoadingWidget ??
                            const Align(
                              alignment: Alignment.topCenter,
                              child: CircularProgressIndicator(),
                            );
                      } else {
                        return widget.style.dataFailureWidget ??
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text(widget.style.dataFailureText),
                            );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Handle the submit button pressed
  void onSubmitButtonPressed() {
    _submitMultiple(unfilteredList.selected);
  }

  /// Handle the clear button pressed
  void onClearButtonPressed() {
    for (final item in unfilteredList) {
      item.isSelected = false;
    }

    setState(() {});
  }

  /// This helps when search enabled & show the filtered data in list.
  void _updateSearchQuery(String query) {
    search = query;

    _performSearch(query);

    _sortSearchList();

    setState(() {});
  }

  /// Perform the search on all of the items.
  void _performSearch(String query) {
    if (query.isNotEmpty || widget.options.searchOnEmpty) {
      list = widget.options.searchDelegate?.call(query, unfilteredList) ??
          _basicSearch(query);
    } else {
      list = unfilteredList;
    }
  }

  /// Perform a basic search.
  DropDownList<T> _basicSearch(String query) {
    final String searchQuery = query.toLowerCase();

    return unfilteredList
        .where(
          (item) => item.data.toString().toLowerCase().contains(searchQuery),
        )
        .toList();
  }

  /// Sorts the list items using the [DropDownOptions.sortDelegate].
  ///
  /// When [DropDownOptions.sortDelegate] is `null`, then the [List.sort] method
  /// will utilize the [DropDownItem.compareTo] method to sort the list.
  void _sortSearchList() {
    if (widget.options.sortAfterSearch) {
      list.sort(widget.options.sortDelegate);
    }
  }

  /// Submits multiple items and closes the modal.
  void _submitMultiple(DropDownList<T> items) {
    widget.options.onSelected?.call(items);

    widget.options.onMultipleSelected?.call(items);

    _onUnFocusKeyboardAndPop(DropDownResponse.multiple(items));
  }

  /// Submits a single item and closes the modal.
  void _submitSingle(DropDownItem<T> item) {
    widget.options.onSelected?.call([item]);

    widget.options.onSingleSelected?.call(item);

    _onUnFocusKeyboardAndPop(DropDownResponse.single(item));
  }

  /// This helps to UnFocus the keyboard & pop from the bottom sheet.
  void _onUnFocusKeyboardAndPop([DropDownResponse<T>? response]) {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop<DropDownResponse<T>>(response);
  }

  /// This helps to add listener on search field controller
  void _setSearchWidgetListener() {
    TextFormField? searchField = widget.style.searchWidget;

    searchField?.controller?.addListener(() {
      _updateSearchQuery(searchField.controller?.text ?? '');
    });
  }
}
