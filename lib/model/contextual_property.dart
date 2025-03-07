import 'package:flutter/material.dart';

typedef ContextualPropertyResolver<T> = T Function(BuildContext context);

typedef ThemedPropertyResolver<T> = T Function(ThemeData theme);

abstract interface class ContextualProperty<T> {
  const ContextualProperty();

  /// Resolves the value for the given context if `value` is a
  /// [ContextualProperty], otherwise returns the value itself.
  static T resolveAs<T>(T value, BuildContext context) {
    if (value is ContextualProperty<T>) {
      final ContextualProperty<T> property = value;

      return property.resolve(context);
    }

    return value;
  }

  /// Convenience method for creating a [ContextualProperty]
  /// from a [ContextualPropertyResolver] function alone.
  static ContextualProperty<T> resolveWith<T>(
    ContextualPropertyResolver<T> callback,
  ) =>
      _ContextualPropertyWith<T>(callback);

  /// Linearly interpolate between two [ContextualProperty]s.
  static ContextualProperty<T?>? lerp<T>(
    ContextualProperty<T>? a,
    ContextualProperty<T>? b,
    double t,
    T? Function(T?, T?, double) lerpFunction,
  ) {
    // Avoid creating a _LerpProperties object for a common case.
    if (a == null && b == null) {
      return null;
    }

    return _LerpProperties<T>(a, b, t, lerpFunction);
  }

  /// Returns a value of type `T` that depends on provided [BuildContext].
  T resolve(BuildContext context);
}

class _ContextualPropertyWith<T> implements ContextualProperty<T> {
  final ContextualPropertyResolver<T> _resolve;

  _ContextualPropertyWith(this._resolve);

  @override
  T resolve(BuildContext context) => _resolve(context);
}

class _LerpProperties<T> implements ContextualProperty<T?> {
  final ContextualProperty<T>? a;
  final ContextualProperty<T>? b;
  final double t;
  final T? Function(T?, T?, double) lerpFunction;

  const _LerpProperties(this.a, this.b, this.t, this.lerpFunction);

  @override
  T? resolve(BuildContext context) {
    final T? resolvedA = a?.resolve(context);
    final T? resolvedB = b?.resolve(context);

    return lerpFunction(resolvedA, resolvedB, t);
  }
}

interface class ThemedProperty<T> extends ContextualProperty<T> {
  final ThemedPropertyResolver<T> resolver;

  const ThemedProperty(this.resolver);

  @override
  T resolve(BuildContext context) {
    return resolver(Theme.of(context));
  }
}

mixin ContextualThemed<T> implements ThemedProperty<T> {
  @override
  T resolve(BuildContext context) {
    return resolver(Theme.of(context));
  }
}

interface class BrightnessProperty<T> extends ContextualProperty<T> {
  final T light;

  final T dark;

  const BrightnessProperty({
    required this.light,
    required this.dark,
  });

  @override
  T resolve(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light ? light : dark;
  }

  static T resolveAs<T>(T light, T dark, BuildContext context) {
    return Theme.of(context).brightness == Brightness.light ? light : dark;
  }
}

mixin ContextualBrightness<T> implements BrightnessProperty<T> {
  @override
  T resolve(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light ? light : dark;
  }
}
