import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(BuildContext context, String? value) {
  if (value == null || value.isEmpty) return '';

  try {
    final date = DateTime.parse(value).toLocal();
    final locale = Localizations.localeOf(context).toLanguageTag();

    return DateFormat('dd MMM yyyy, HH:mm', locale).format(date);
  } catch (_) {
    return value;
  }
}
