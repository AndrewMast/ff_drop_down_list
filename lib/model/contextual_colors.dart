import 'package:ff_drop_down_list/model/contextual_property.dart';
import 'package:flutter/material.dart';
import 'dart:ui' show ColorSpace;

extension InvertColors on Color {
  Color get inverted =>
      withValues(alpha: a, red: 1.0 - r, green: 1.0 - g, blue: 1.0 - b);
}

class BrightnessColor extends Color with ContextualBrightness<Color> {
  @override
  final Color light;

  @override
  final Color dark;

  const BrightnessColor({
    required Color? light,
    required Color? dark,
  })  : light = light ?? Colors.transparent,
        dark = dark ?? Colors.transparent,
        super(0x00000000);

  const BrightnessColor.fallback({
    required Color? light,
    required Color? dark,
    int fallback = 0x00000000,
  })  : light = light ?? Colors.transparent,
        dark = dark ?? Colors.transparent,
        super(fallback);

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

  BrightnessColor.inverted({
    Color? light,
    Color? dark,
  }) : this(light: light ?? dark?.inverted, dark: dark ?? light?.inverted);

  BrightnessColor.invertedOnDark(Color light) : this.inverted(light: light);

  BrightnessColor.invertedOnLight(Color dark) : this.inverted(dark: dark);

  const BrightnessColor.bw()
      : light = Colors.black,
        dark = Colors.white,
        super(0x000000FF);

  const BrightnessColor.wb()
      : light = Colors.white,
        dark = Colors.black,
        super(0xFFFFFFFF);

  BrightnessColor.bwa({required super.alpha})
      : light = Color.from(alpha: alpha, red: 0.0, green: 0.0, blue: 0.0),
        dark = Color.from(alpha: alpha, red: 1.0, green: 1.0, blue: 1.0),
        super.from(red: 0.0, green: 0.0, blue: 0.0);

  BrightnessColor.wba({required super.alpha})
      : light = Color.from(alpha: alpha, red: 1.0, green: 1.0, blue: 1.0),
        dark = Color.from(alpha: alpha, red: 0.0, green: 0.0, blue: 0.0),
        super.from(red: 1.0, green: 1.0, blue: 1.0);

  BrightnessColor.alpha({
    required Color? light,
    required Color? dark,
    required double alpha,
  }) : this(
          light: light?.withValues(alpha: alpha),
          dark: dark?.withValues(alpha: alpha),
        );

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

class ThemedColor extends Color with ContextualThemed<Color?> {
  @override
  final ThemedPropertyResolver<Color?> resolver;

  const ThemedColor(this.resolver) : super(0x00000000);

  const ThemedColor.fallback(this.resolver, {int fallback = 0x00000000})
      : super(fallback);

  ThemedColor.themedFallback(this.resolver, {int fallback = 0x00000000})
      : super(resolver(ThemeData.fallback())?.toARGB32() ?? fallback);
}
