import 'package:flutter/material.dart';

class AppColors {
  static const bg = Color(0xFF0A0B10), surface = Color(0xFF12141C), card = Color(0xFF181B26);
  static const primary = Color(0xFF7C5CFF), accent = Color(0xFF22D3EE);
  static const text = Color(0xFFE8EAF2), muted = Color(0xFF8A90A6), error = Color(0xFFFF5C7A);
  static const gradient = LinearGradient(colors: [primary, accent]);
}

ThemeData buildTheme() => ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: const ColorScheme.dark(
          primary: AppColors.primary, secondary: AppColors.accent, surface: AppColors.surface, error: AppColors.error),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
    );
