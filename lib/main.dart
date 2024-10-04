import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'theme/app_theme.dart';
import 'theme/colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(AppColors.mainColors).getTheme(),
      home: const HomeScreen(),
    );
  }
}