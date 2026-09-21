import 'package:flutter/services.dart';

class KazakhstanPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // If the user deletes everything, allow an empty field.
    if (newValue.text.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // Number of digits before the cursor in the new raw value.
    final cursorPosition = newValue.selection.baseOffset.clamp(
      0,
      newValue.text.length,
    );

    final digitsBeforeCursor = newValue.text
        .substring(0, cursorPosition)
        .replaceAll(RegExp(r'\D'), '')
        .length;

    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Kazakhstan number starts with 7.
    if (digits.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    if (!digits.startsWith('7')) {
      digits = '7$digits';
    }

    if (digits.length > 11) {
      digits = digits.substring(0, 11);
    }

    final text = format(digits);

    // Calculate cursor position in formatted text.
    final targetDigitPosition = digitsBeforeCursor.clamp(0, digits.length);

    int selectionOffset = 0;
    int digitCount = 0;

    for (int i = 0; i < text.length; i++) {
      if (RegExp(r'\d').hasMatch(text[i])) {
        digitCount++;

        if (digitCount >= targetDigitPosition) {
          selectionOffset = i + 1;
          break;
        }
      }
    }

    if (targetDigitPosition == 0) {
      selectionOffset = 0;
    } else if (digitCount < targetDigitPosition) {
      selectionOffset = text.length;
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(
        offset: selectionOffset.clamp(0, text.length),
      ),
    );
  }

  String format(String digits) {
    final buffer = StringBuffer('+7');

    if (digits.length > 1) {
      buffer.write(' (');
      buffer.write(
        digits.substring(
          1,
          digits.length.clamp(1, 4),
        ),
      );
    }

    if (digits.length >= 4) {
      buffer.write(') ');
      buffer.write(
        digits.substring(
          4,
          digits.length.clamp(4, 7),
        ),
      );
    }

    if (digits.length >= 7) {
      buffer.write('-');
      buffer.write(
        digits.substring(
          7,
          digits.length.clamp(7, 9),
        ),
      );
    }

    if (digits.length >= 9) {
      buffer.write('-');
      buffer.write(
        digits.substring(
          9,
          digits.length.clamp(9, 11),
        ),
      );
    }

    return buffer.toString();
  }
}