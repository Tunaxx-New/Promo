import 'package:flutter/material.dart';

class ScannerOverlay extends StatelessWidget {
  const ScannerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 260,
      child: Stack(
        children: const [
          _Corner(top: true, left: true),
          _Corner(top: true, left: false),
          _Corner(top: false, left: true),
          _Corner(top: false, left: false),
        ],
      ),
    );
  }
}

class _Corner extends StatelessWidget {
  final bool top;
  final bool left;

  const _Corner({required this.top, required this.left});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Positioned(
      top: top ? 0 : null,
      bottom: top ? null : 0,
      left: left ? 0 : null,
      right: left ? null : 0,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border(
            top: top ? BorderSide(color: color, width: 5) : BorderSide.none,
            bottom: !top ? BorderSide(color: color, width: 5) : BorderSide.none,
            left: left ? BorderSide(color: color, width: 5) : BorderSide.none,
            right: !left ? BorderSide(color: color, width: 5) : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
