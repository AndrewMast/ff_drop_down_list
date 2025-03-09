/// Provides colors that can change depending on the current [BuildContext].
library;

import 'package:ff_drop_down_list/model/contextual_property.dart';
import 'package:flutter/material.dart';
import 'dart:ui' show ColorSpace;

/// Provides the [inverted] getter to invert a color.
extension InvertColors on Color {
  /// Invert the color.
  Color get inverted =>
      withValues(alpha: a, red: 1.0 - r, green: 1.0 - g, blue: 1.0 - b);
}

/// Provides the [contextualize] method which runs [ContextualProperty.resolveAs].
extension ContextualizeColors on Color {
  /// Contextualizes the color if it is an instance of [BrightnessColor],
  /// [ThemedColor], or [ContextualColor].
  ///
  /// Runs [ContextualProperty.resolveAs] to resolve the Color.
  Color contextualize(BuildContext context) {
    return ContextualProperty.resolveAs(this, context);
  }
}

/// Provides the [contextualize] method which runs [ContextualProperty.resolveAs].
extension ContextualizeNullableColors on Color? {
  /// Contextualizes the color if it is an instance of [BrightnessColor],
  /// [ThemedColor], or [ContextualColor].
  ///
  /// Runs [ContextualProperty.resolveAs] to resolve the Color.
  Color? contextualize(BuildContext context) {
    return ContextualProperty.resolveAs(this, context);
  }
}

/// Allows for a color to change depending on the [Brightness] of
/// the theme for the current [BuildContext].
///
/// Run [ContextualizeColors.contextualize] (`Color.contextualize`) or
/// [ContextualProperty.resolveAs] to resolve the correct color for
/// a given [BuildContext].
///
/// ```dart
/// BrightnessColor iconColor = BrightnessColor(
///   light: Colors.black,
///   dark: Colors.white,
/// );
///
/// BrightnessColor? otherColor = BrightnessColor.bwa(alpha: 0.5);
///
/// Widget build(BuildContext context) {
///   return IconButton(
///     icon: const Icon(Icons.search),
///     color: iconColor.contextualize(context),
///     focusColor: ContextualProperty.resolveAs<Color?>(otherColor, context),
///     onPressed: () {},
///   );
/// }
/// ```
class BrightnessColor extends Color with ContextualBrightness<Color> {
  /// The color to display when the brightness of the theme
  /// for the current [BuildContext] is [Brightness.light].
  @override
  final Color light;

  /// The color to display when the brightness of the theme
  /// for the current [BuildContext] is [Brightness.dark].
  @override
  final Color dark;

  /// Create [Color] that is rendered differently based on
  /// the current brightness of the [BuildContext]'s theme.
  ///
  /// If not resolved using [ContextualProperty.resolveAs], the color
  /// will be displayed as the default color, [Colors.transparent].
  const BrightnessColor({
    required Color? light,
    required Color? dark,
  })  : light = light ?? Colors.transparent,
        dark = dark ?? Colors.transparent,
        super(0x00000000);

  /// Create a [BrightnessColor] using the provided fallback color integer.
  ///
  /// Defaults to 0x00000000, which is [Colors.transparent].
  const BrightnessColor.fallback({
    required Color? light,
    required Color? dark,
    int fallback = 0x00000000,
  })  : light = light ?? Colors.transparent,
        dark = dark ?? Colors.transparent,
        super(fallback);

  /// Create a [BrightnessColor] using the provided fallback [Color].
  BrightnessColor.colorFallback({
    required Color? light,
    required Color? dark,
    Color fallback = Colors.transparent,
  })  : light = light ?? Colors.transparent,
        dark = dark ?? Colors.transparent,
        super.from(
          alpha: fallback.a,
          red: fallback.r,
          green: fallback.g,
          blue: fallback.b,
        );

  /// Create a [BrightnessColor] which has a custom [alpha] level for
  /// both of the brightnesses.
  BrightnessColor.alpha({
    required Color? light,
    required Color? dark,
    required double alpha,
  }) : this(
          light: light?.withValues(alpha: alpha),
          dark: dark?.withValues(alpha: alpha),
        );

  /// Create a [BrightnessColor] using the provided light or dark.
  ///
  /// When one of the provided colors ([light] or [dark]) is missing,
  /// then it will be resolved to be the inverted color of the provided
  /// color.
  ///
  /// For example, `BrightnessColor.inverted(dark: Colors.white)` will
  /// have its `light` be resolved as `Colors.black`.
  ///
  /// If both colors are missing, it will be displayed as [Colors.transparent].
  BrightnessColor.inverted({
    Color? light,
    Color? dark,
  }) : this(light: light ?? dark?.inverted, dark: dark ?? light?.inverted);

  /// Create a [BrightnessColor] which inverts the [light] color for [dark].
  BrightnessColor.invertedOnDark(Color light) : this.inverted(light: light);

  /// Create a [BrightnessColor] which inverts the [dark] color for [light].
  BrightnessColor.invertedOnLight(Color dark) : this.inverted(dark: dark);

  /// Create a [BrightnessColor] which has [Colors.black] for light
  /// and [Colors.white] for dark.
  const BrightnessColor.bw()
      : light = Colors.black,
        dark = Colors.white,
        super(0x000000FF);

  /// Create a [BrightnessColor] which has [Colors.white] for light
  /// and [Colors.black] for dark.
  const BrightnessColor.wb()
      : light = Colors.white,
        dark = Colors.black,
        super(0xFFFFFFFF);

  /// Create a [BrightnessColor] which has [Colors.black] for light
  /// and [Colors.white] for dark, both with a custom [alpha] level.
  BrightnessColor.bwa({required super.alpha})
      : light = Color.from(alpha: alpha, red: 0.0, green: 0.0, blue: 0.0),
        dark = Color.from(alpha: alpha, red: 1.0, green: 1.0, blue: 1.0),
        super.from(red: 0.0, green: 0.0, blue: 0.0);

  /// Create a [BrightnessColor] which has [Colors.white] for light
  /// and [Colors.black] for dark, both with a custom [alpha] level.
  BrightnessColor.wba({required super.alpha})
      : light = Color.from(alpha: alpha, red: 1.0, green: 1.0, blue: 1.0),
        dark = Color.from(alpha: alpha, red: 0.0, green: 0.0, blue: 0.0),
        super.from(red: 1.0, green: 1.0, blue: 1.0);

  /// Invert the colors for both of the brightnesses.
  BrightnessColor get inverted => BrightnessColor.colorFallback(
        light: light.inverted,
        dark: dark.inverted,
        fallback: super.withValues(
          alpha: a,
          red: 1.0 - r,
          green: 1.0 - g,
          blue: 1.0 - b,
        ),
      );

  /// Flip the colors of the two brightnesses.
  BrightnessColor get flipped => BrightnessColor(light: dark, dark: light);

  @override
  BrightnessColor withValues({
    double? alpha,
    double? red,
    double? green,
    double? blue,
    ColorSpace? colorSpace,
  }) =>
      BrightnessColor.colorFallback(
        light: light.withValues(
          alpha: alpha,
          red: red,
          green: green,
          blue: blue,
          colorSpace: colorSpace,
        ),
        dark: dark.withValues(
          alpha: alpha,
          red: red,
          green: green,
          blue: blue,
          colorSpace: colorSpace,
        ),
        fallback: super.withValues(
          alpha: alpha,
          red: red,
          green: green,
          blue: blue,
          colorSpace: colorSpace,
        ),
      );
}

/// Allows for a color to change depending on the [ThemeData] of
/// the current [BuildContext].
///
/// Run [ContextualizeColors.contextualize] (`Color.contextualize`) or
/// [ContextualProperty.resolveAs] to resolve the correct color for
/// a given [BuildContext].
class ThemedColor extends Color with ContextualThemed<Color?> {
  /// The function to resolve [Color] with the given [ThemeData].
  @override
  final ThemedPropertyResolver<Color?> resolver;

  /// Create a [Color] that can be resolved from a [ThemeData] object.
  ///
  /// If not resolved using [ContextualProperty.resolveAs], the color
  /// will be displayed as the default color, [Colors.transparent].
  const ThemedColor(this.resolver) : super(0x00000000);

  /// Create a [ThemedColor] using the provided fallback color integer.
  const ThemedColor.fallback(this.resolver, {int fallback = 0x00000000})
      : super(fallback);

  /// The resolver will be called with [ThemeData.fallback] first
  /// to try to get a fallback color.
  ///
  /// Otherwise, the provided fallback color integer will be used.
  ThemedColor.themedFallback(this.resolver, {int fallback = 0x00000000})
      : super(resolver(ThemeData.fallback())?.toARGB32() ?? fallback);
}

/// Adds the [toARGB32] method to [Color] which gets
/// added to the Flutter SDK in version 3.29
extension ColorToArgb32 on Color {
  /// Converts the Color into an [int] value.
  int toARGB32() {
    return _floatToInt8(a) << 24 |
        _floatToInt8(r) << 16 |
        _floatToInt8(g) << 8 |
        _floatToInt8(b) << 0;
  }

  static int _floatToInt8(double x) {
    return (x * 255.0).round() & 0xff;
  }
}

/// Allows for a color to change depending on the current [BuildContext].
///
/// Run [ContextualizeColors.contextualize] (`Color.contextualize`) or
/// [ContextualProperty.resolveAs] to resolve the correct color for
/// a given [BuildContext].
class ContextualColor extends Color
    with ContextualPropertyWithResolver<Color?> {
  /// The function to resolve [Color] with the given [BuildContext].
  @override
  final ContextualPropertyResolver<Color?> resolver;

  /// Create a [Color] that can be resolved from a [BuildContext] object.
  ///
  /// If not resolved using [ContextualProperty.resolveAs], the color
  /// will be displayed as the default color, [Colors.transparent].
  const ContextualColor(this.resolver) : super(0x00000000);

  /// Create a [ContextualColor] using the provided fallback color integer.
  const ContextualColor.fallback(this.resolver, {int fallback = 0x00000000})
      : super(fallback);
}
