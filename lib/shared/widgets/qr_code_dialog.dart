import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/capture_qr.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:promo/shared/extensions/localization_extension.dart';

class QrCodeDialog extends StatefulWidget {
  final String id;
  final bool activateOrShare;
  final String code;
  final String title;
  final String filePrefix;

  const QrCodeDialog({
    super.key,
    required this.id,
    required this.activateOrShare,
    required this.code,
    required this.title,
    required this.filePrefix,
  });

  @override
  State<QrCodeDialog> createState() => _QrCodeDialogState();
}

class _QrCodeDialogState extends State<QrCodeDialog> {
  final GlobalKey _qrKey = GlobalKey();

  Future<void> _shareQr() async {
    final bytes = await captureQr(_qrKey);

    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile.fromData(
            bytes,
            mimeType: 'image/png',
            name: 'promocode_${widget.title}.png',
          ),
        ],
        text: '${context.l10n.promocode} ${context.l10n.qr_code}',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: widget.activateOrShare
          ? Colors.yellow.shade400
          : Theme.of(context).colorScheme.surfaceBright,
      title: Text(
        widget.activateOrShare
            ? context.l10n.promocodeActivate
            : context.l10n.promocodeShare,
      ),
      content: SizedBox(
        width: 240,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RepaintBoundary(
              key: _qrKey,
              child: QrImageView(
                data: widget.id,
                version: QrVersions.auto,
                size: 220,
              ),
            ),
            const SizedBox(height: 16),
            SelectableText(widget.code),
          ],
        ),
      ),
      actions: [
        FilledButton.icon(
          onPressed: _shareQr,
          icon: const Icon(Icons.share),
          label: Text(context.l10n.share),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.l10n.cancel),
        ),
      ],
    );
  }
}
