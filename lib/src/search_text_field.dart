import 'package:ff_drop_down_list/model/contextual_colors.dart';
import 'package:ff_drop_down_list/model/contextual_property.dart';
import 'package:flutter/material.dart';

/// This is search text field class
class SearchTextField extends StatefulWidget {
  /// Called when the user initiates a change to the search text field
  final Function(String) onTextChanged;

  /// Used to show the hint text into the search text field
  final String? hintText;

  /// The fill color for the search input field
  final Color? fillColor;

  /// The color of the cursor for the search input field
  final Color? cursorColor;

  /// The border radius of the search input field
  ///
  /// Default Value: [BorderRadius.circular(24.0)]
  final BorderRadius borderRadius;

  /// The prefix icon for the search input field
  ///
  /// Default Value: [Icon(Icons.search)]
  final Widget prefixIcon;

  /// The prefix icon color for the search input field
  ///
  /// Default Value: [BrightnessColor.bwa(alpha: 0.5)]
  final Color? prefixColor;

  /// The suffix icon for the search input field
  ///
  /// Pressing this icon clears the search text field.
  ///
  /// Default Value: [Icon(Icons.clear)]
  final Widget suffixIcon;

  /// The suffix icon color for the search input field
  ///
  /// Default Value: [BrightnessColor.bwa(alpha: 0.5)]
  final Color? suffixColor;

  const SearchTextField({
    required this.onTextChanged,
    this.hintText,
    this.fillColor,
    this.cursorColor,
    BorderRadius? borderRadius,
    Widget? prefixIcon,
    this.prefixColor,
    Widget? suffixIcon,
    this.suffixColor,
    super.key,
  })  : borderRadius =
            borderRadius ?? const BorderRadius.all(Radius.circular(24.0)),
        prefixIcon = prefixIcon ?? const Icon(Icons.search),
        suffixIcon = suffixIcon ?? const Icon(Icons.clear);

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
        widget.cursorColor,
        context,
      ),
      onChanged: (value) {
        widget.onTextChanged(value);
      },
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: ContextualProperty.resolveAs(
          widget.fillColor,
          context,
        ),
        contentPadding: EdgeInsets.zero,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
          borderRadius: widget.borderRadius,
        ),
        prefixIcon: IconButton(
          icon: widget.prefixIcon,
          iconSize: 24,
          disabledColor: ContextualProperty.resolveAs(
            widget.prefixColor ?? BrightnessColor.bwa(alpha: 0.5),
            context,
          ),
          onPressed: null,
        ),
        suffixIcon: IconButton(
          icon: widget.suffixIcon,
          iconSize: 24,
          color: ContextualProperty.resolveAs(
            widget.suffixColor ?? BrightnessColor.bwa(alpha: 0.5),
            context,
          ),
          onPressed: () {
            widget.onTextChanged('');
            _editingController.clear();
          },
        ),
      ),
    );
  }
}
