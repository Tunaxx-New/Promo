import 'package:flutter/material.dart';

class DailyForecastTile extends StatelessWidget {
  final String weekday;
  final String imagePath;
  final String maxTemp;
  final String minTemp;

  const DailyForecastTile({
    super.key,
    required this.weekday,
    required this.imagePath,
    required this.maxTemp,
    required this.minTemp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              weekday,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          Image.asset(imagePath, width: 20, height: 20),
          const Spacer(),
          Text(
            maxTemp,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            minTemp,
            style: const TextStyle(color: Colors.white54, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
