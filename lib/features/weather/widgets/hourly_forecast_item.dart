import 'package:flutter/material.dart';

class HourlyForecastTile extends StatelessWidget {
  final String time;
  final String imagePath;
  final String temperature;

  const HourlyForecastTile({
    super.key,
    required this.time,
    required this.imagePath,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(time, style: const TextStyle(color: Colors.white70, fontSize: 13)),
        const SizedBox(height: 10),
        Image.asset(imagePath, width: 26, height: 26),
        const SizedBox(height: 10),
        Text(
          temperature,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
