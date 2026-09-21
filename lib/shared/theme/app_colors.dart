import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF087FEF);
  static const onPrimary = Colors.white;
  static const secondary = Color(0xFF52CEFE);
  static const onSecondary = Colors.black;
  static const splashBackground = Color(0xFF0103BA);
  static const textColorOnBackground = Colors.white;
  static const textColorOnBackgroundLight = Color(0xFFEEEEEE);

  // New interface colors
  // Фон экрана — вертикальный градиент от почти чёрного к тёмно-синему.
  static const Color backgroundTop = Color(0xFF040A16);
  static const Color backgroundBottom = Color(0xFF071B36);

  // Поверхности карточек.
  static const Color surface = Color(0xFF0C2340);
  static const Color surfaceLight = Color(0xFF123156);
  static const Color border = Color(0x3355A8FF);

  // Level colors
  static const Color bronze = Color(0xFFCD7F32);
  static const Color silver = Color(0xFFC0C0C0);
  static const Color gold = Color(0xFFF5C518);
  static const Color diamond = Color.fromARGB(255, 167, 224, 255);

  // Акценты.
  static const Color accent = Color(0xFF1E88FF);
  static const Color accentDark = Color(0xFF0B5FD0);
  static const Color danger = Color(0xFFE23B4E);
  static const Color success = Color(0xFF34C759);
  static const Color info = Color(0xFF007AFF);

  // Текст.
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA9C2DE);
  static const Color textMuted = Color(0xFF6E86A3);

  static const LinearGradient screenGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [backgroundTop, backgroundBottom],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0E2A4C), Color(0xFF08192F)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF2E9BFF), Color(0xFF1667D6)],
  );
}
