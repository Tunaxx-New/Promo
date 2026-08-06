import 'package:flutter/material.dart';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:promo/core/api/api.dart';
import 'package:promo/features/scanner/widgets/scanner_overlay.dart';
import 'package:promo/shared/app_exception.dart';

import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/widgets/api_form/api_exception.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';
import 'package:promo/shared/widgets/error_handler.dart';
import 'package:promo/shared/widgets/user/user_service.dart';

class ScannerPage extends StatefulWidget {
  final bool isActive;
  final ValueChanged<String>? onPromocodeActivated;

  const ScannerPage({
    super.key,
    required this.isActive,
    this.onPromocodeActivated,
  });

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final MobileScannerController _controller = MobileScannerController();

  bool _sending = false;
  bool _handled = false;

  @override
  void initState() {
    super.initState();

    if (!widget.isActive) {
      _controller.stop();
    }
  }

  @override
  void didUpdateWidget(covariant ScannerPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isActive != widget.isActive) {
      if (widget.isActive) {
        _controller.start();
      } else {
        _controller.stop();
      }
    }
  }

  Future<void> _onDetect(String value) async {
    if (_handled || _sending || !widget.isActive) return;

    _handled = true;
    _sending = true;

    await _controller.stop();

    try {
      String? user_id = await UserService().userId;
      if (user_id == null) throw AppException(context.l10n.userIdIsNull);

      final json = await api.request(
        route: '/promo/promocode/collect',
        method: HttpMethod.post,
        body: {'user_id': user_id, 'promocode_id': value},
      );

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.success)));

      widget.onPromocodeActivated?.call(json['promocode']['id']);
    } on ApiException catch (e) {
      ErrorHandler.show(context, e);
      if (e.statusCode == 409) widget.onPromocodeActivated?.call(value);
    } catch (e) {
      if (!mounted) return;
      ErrorHandler.show(context, e);
    } finally {
      _handled = false;
      _sending = false;
      await Future.delayed(const Duration(seconds: 2));
      await _controller.start();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: (capture) {
              if (capture.barcodes.isEmpty) return;

              final barcode = capture.barcodes.first;
              final value = barcode.rawValue;

              if (value != null) {
                _onDetect(value);
              }
            },
          ),
          const IgnorePointer(child: Center(child: ScannerOverlay())),
          if (_sending)
            const ColoredBox(
              color: Colors.black45,
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
