import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:promo/shared/app_exception.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/widgets/api_form/api_exception.dart';

class ErrorHandler {
  static void show(BuildContext context, Object error, {Color? color}) {
    if (!context.mounted) return;
    
    String message;

    switch (error) {
      case ApiException e:
        message = e.message ?? context.l10n.unknownError;

      case ClientException _:
        message = context.l10n.connectionError;

      case AppException e:
        message = e.message;

      default:
        message = context.l10n.unknownError;
    }

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 4),
          backgroundColor: color ?? Colors.red.shade700,
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
