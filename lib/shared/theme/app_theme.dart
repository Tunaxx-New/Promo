import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() {
    const primary = Color(0xFF000000);

    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.light,
        ).copyWith(
          primary: const Color(0xFFFF6B35), // warm orange-red
          onPrimary: Colors.white,

          secondary: const Color(0xFFFFB000), // amber
          onSecondary: Colors.black,
          
          surface: const Color(0xFFF5F5F5),
          surfaceContainer: const Color(0xFFF0F0F0),
          surfaceContainerLow: const Color(0xFFF3F3F3),
          surfaceContainerHighest: const Color(0xFFE9E9E9),
          onSurfaceVariant: const Color(0xFF7A7A7A),
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,

      scaffoldBackgroundColor: colorScheme.surface,

      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainer,
        isDense: true,

        hintStyle: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 15),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),

        prefixIconConstraints: const BoxConstraints(
          minWidth: 32,
          minHeight: 32,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
