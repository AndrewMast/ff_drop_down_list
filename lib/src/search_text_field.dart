import 'package:ff_drop_down_list/model/contextual_property.dart';
import 'package:flutter/material.dart';

/// This is search text field class
class SearchTextField extends StatefulWidget {
  /// Called when the user initiates a change to the search text field
  final Function(String) onTextChanged;

  /// Used to show the hint text into the search text field
  final String? searchHintText;

  /// The fill color of the search text field
  final Color? searchFillColor;

  /// The color of the cursor of the search text field
  final Color? searchCursorColor;

  const SearchTextField({
    required this.onTextChanged,
    this.searchHintText,
    this.searchFillColor,
    this.searchCursorColor,
    super.key,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _editingController = TextEditingController();

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _editingController,
      cursorColor: ContextualProperty.resolveAs(
        widget.searchCursorColor,
        context,
      ),
      onChanged: (value) {
        widget.onTextChanged(value);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: ContextualProperty.resolveAs(
          widget.searchFillColor,
          context,
        ),
        contentPadding: const EdgeInsets.only(right: 15),
        hintText: widget.searchHintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        prefixIcon: IconButton(
          icon: Icon(
            Icons.search,
            color: BrightnessProperty.resolveAs(
              Colors.black,
              Colors.white,
              context,
            ).withValues(alpha: 0.5),
          ),
          onPressed: null,
        ),
        suffixIcon: GestureDetector(
          onTap: onClearTap,
          child: Icon(
            Icons.clear,
            color: BrightnessProperty.resolveAs(
              Colors.black,
              Colors.white,
              context,
            ).withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }

  void onClearTap() {
    widget.onTextChanged('');
    _editingController.clear();
  }
}
