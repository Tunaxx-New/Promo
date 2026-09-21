import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:promo/shared/theme/app_colors.dart';

class CoinIcon extends StatelessWidget {
  const CoinIcon({this.width = 40.0, this.height = 40.0, this.fontSize = 20});

  final double width;
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFD75E), Color(0xFFE0A100)],
        ),
        boxShadow: [
          BoxShadow(color: AppColors.gold.withOpacity(0.35), blurRadius: 14),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        '\u20B8',
        style: TextStyle(
          color: Color(0xFF7A5200),
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
