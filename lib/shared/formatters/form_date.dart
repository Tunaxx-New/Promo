import 'package:intl/intl.dart';

String formatDate(String? value) {
  if (value == null || value.isEmpty) return '';

  try {
    final date = DateTime.parse(value).toLocal();

    return DateFormat('dd MMM yyyy, HH:mm').format(date);
  } catch (_) {
    return value;
  }
}
