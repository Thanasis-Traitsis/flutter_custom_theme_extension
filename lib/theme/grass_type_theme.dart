import 'package:flutter/material.dart';

class GrassTypeTheme extends ThemeExtension<GrassTypeTheme> {
  final Color backgroundColor;
  final Color textColor;
  final Color outlineColor;
  final EdgeInsets cardPadding;
  final BorderRadius cardBorderRadius;

  GrassTypeTheme({
    required this.backgroundColor,
    required this.textColor,
    required this.outlineColor,
    required this.cardPadding,
    required this.cardBorderRadius,
  });

  @override
  ThemeExtension<GrassTypeTheme> copyWith({
    Color? backgroundColor,
    Color? textColor,
    Color? outlineColor,
    EdgeInsets? cardPadding,
    BorderRadius? cardBorderRadius,
  }) {
    return GrassTypeTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      outlineColor: outlineColor ?? this.outlineColor,
      cardPadding: cardPadding ?? this.cardPadding,
      cardBorderRadius: cardBorderRadius ?? this.cardBorderRadius,
    );
  }

  @override
  ThemeExtension<GrassTypeTheme> lerp(
      covariant ThemeExtension<GrassTypeTheme>? other, double t) {
    if (other is! GrassTypeTheme) return this;
    return GrassTypeTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      outlineColor: Color.lerp(outlineColor, other.textColor, t)!,
      cardPadding: EdgeInsets.lerp(cardPadding, other.cardPadding, t)!,
      cardBorderRadius:
          BorderRadius.lerp(cardBorderRadius, other.cardBorderRadius, t)!,
    );
  }
}
