import 'package:flutter/material.dart';
import 'package:promo/shared/theme/app_colors.dart';

class AppTheme {
  /// Радиусы, которые повторяются во всех карточках.
  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(20));
  static const BorderRadius tileRadius = BorderRadius.all(Radius.circular(18));
  static const BorderRadius pillRadius = BorderRadius.all(Radius.circular(24));

  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );

  static ThemeData light() {
    const primary = Color(0xFF000000);

    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.primary,
          onPrimary: AppColors.onPrimary,

          secondary: AppColors.secondary,
          onSecondary: AppColors.onSecondary,

          surface: const Color(0xFFF5F5F5),
          surfaceContainer: const Color(0xFFF0F0F0),
          surfaceContainerLow: const Color(0xFFF3F3F3),
          surfaceContainerHighest: const Color(0xFFE9E9E9),
          onSurfaceVariant: const Color(0xFF7A7A7A),
          onSurface: const Color(0xFF000000),
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(foregroundColor: Colors.black),
      ),

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

  static ThemeData dark() {
    const primary = Color(0xFF000000);

    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.dark,
        ).copyWith(
          primary: AppColors.primary,
          onPrimary: AppColors.onPrimary,

          secondary: AppColors.secondary,
          onSecondary: AppColors.onSecondary,

          surface: const Color(0xFF001324),
          surfaceContainer: const Color(0xFF001B2E),
          surfaceContainerLow: const Color(0xFF01010F),
          surfaceContainerHighest: const Color(0xFF00243A),
          onSurfaceVariant: const Color(0xFF9FB3C1),
          onSurface: const Color(0xFFFFFFFF),
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(foregroundColor: Colors.white),
      ),

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
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
