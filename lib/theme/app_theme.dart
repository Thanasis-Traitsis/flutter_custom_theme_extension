import 'package:flutter/material.dart';

import 'colors.dart';
import 'grass_type_theme.dart';
import 'app_values.dart';

class AppTheme {
  final AppColors chosenColor;

  AppTheme(
    this.chosenColor,
  );

  ThemeData getTheme() {
    final values = AppValues();

    return ThemeData(
      useMaterial3: true,
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: values.largeText,
          color: chosenColor.grassTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      extensions: <ThemeExtension<dynamic>>[
        GrassTypeTheme(
          backgroundColor: chosenColor.grassBackgroundColor,
          textColor: chosenColor.grassTextColor,
          outlineColor: chosenColor.grassOutlineColor,
          cardBorderRadius: BorderRadius.circular(values.pokecardBorderRadius),
          cardPadding: EdgeInsets.all(values.pokecardPadding),
        ),
      ],
    );
  }
}
