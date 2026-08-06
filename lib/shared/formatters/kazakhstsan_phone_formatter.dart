import 'package:flutter/services.dart';

class KazakhstanPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (digits.isEmpty) {
      digits = '7';
    }

    if (!digits.startsWith('7')) {
      digits = '7${digits.substring(digits.length > 0 ? 1 : 0)}';
    }

    if (digits.length > 11) {
      digits = digits.substring(0, 11);
    }

    final buffer = StringBuffer('+7');

    if (digits.length > 1) {
      buffer.write(' (');
      buffer.write(digits.substring(1, digits.length.clamp(1, 4)));
    }

    if (digits.length >= 4) {
      buffer.write(') ');
      buffer.write(digits.substring(4, digits.length.clamp(4, 7)));
    }

    if (digits.length >= 7) {
      buffer.write('-');
      buffer.write(digits.substring(7, digits.length.clamp(7, 9)));
    }

    if (digits.length >= 9) {
      buffer.write('-');
      buffer.write(digits.substring(9, digits.length.clamp(9, 11)));
    }

    final text = buffer.toString();

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
