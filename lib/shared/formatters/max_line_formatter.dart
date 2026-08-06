import 'package:flutter/services.dart';

class MaxLinesFormatter extends TextInputFormatter {
  final int maxLines;

  MaxLinesFormatter(this.maxLines);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if ('\n'.allMatches(newValue.text).length + 1 > maxLines) {
      return oldValue;
    }
    return newValue;
  }
}
