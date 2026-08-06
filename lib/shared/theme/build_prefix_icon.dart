import 'package:flutter/material.dart';

Widget buildPrefixIcon(IconData icon) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
    child: Icon(icon, size: 22),
  );
}
