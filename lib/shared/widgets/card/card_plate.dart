import 'dart:async';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/formatters/form_card_id.dart';
import 'package:promo/shared/formatters/form_time.dart';

class CardPlate extends StatefulWidget {
  final String barcode;
  final String? title;
  final VoidCallback? onTap;
  final VoidCallback? onExpired;
  final Duration duration;

  const CardPlate({
    super.key,
    required this.barcode,
    this.title,
    this.onTap,
    this.onExpired,
    this.duration = const Duration(seconds: 5),
  });

  @override
  State<CardPlate> createState() => _CardPlateState();
}

class _CardPlateState extends State<CardPlate> {
  Timer? _timer;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant CardPlate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.barcode != widget.barcode) {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer?.cancel();

    _remainingSeconds = widget.duration.inSeconds;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_remainingSeconds <= 1) {
        timer.cancel();

        setState(() {
          _remainingSeconds = 0;
        });

        widget.onExpired?.call();
        return;
      }

      setState(() {
        _remainingSeconds--;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final totalSeconds = widget.duration.inSeconds;
    final progress = totalSeconds == 0 ? 0.0 : _remainingSeconds / totalSeconds;

    final isActive = _remainingSeconds > 0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isActive ? widget.onTap : null,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorScheme.onSurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (widget.title != null)
                          Expanded(
                            child: Text(
                              widget.title!,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: colorScheme.surface),
                            ),
                          ),

                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            isActive
                                ? context.l10n.refresh_in
                                : context.l10n.code_has_expired,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: colorScheme.surface),
                          ),
                        ),

                        SizedBox(
                          width: 44,
                          height: 44,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: progress,
                                strokeWidth: 4,
                              ),
                              Text(
                                formatTime(_remainingSeconds),
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.surface,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    BarcodeWidget(
                      barcode: Barcode.code128(),
                      data: widget.barcode,
                      height: 70,
                      drawText: false,
                    ),

                    const SizedBox(height: 6),

                    Text(formatCardId(widget.barcode)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
