import 'package:flutter/material.dart';

class AppColors {
  final Color grassBackgroundColor;
  final Color grassTextColor;
  final Color grassOutlineColor;

  AppColors({
    required this.grassBackgroundColor,
    required this.grassTextColor,
    required this.grassOutlineColor,
  });

  static final mainColors = AppColors(
    grassBackgroundColor: const Color(0xffcef79f),
    grassTextColor: const Color(0xff2a513f),
    grassOutlineColor: const Color(0xff378e8e),
  );
}
