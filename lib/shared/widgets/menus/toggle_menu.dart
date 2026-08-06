import 'package:flutter/material.dart';

class ToggleMenu extends StatelessWidget {
  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  final double height;
  final double padding;
  final Duration animationDuration;
  final BorderRadius? borderRadius;

  const ToggleMenu({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onChanged,
    this.height = 44,
    this.padding = 3,
    this.animationDuration = const Duration(milliseconds: 200),
    this.borderRadius,
  }) : assert(options.length >= 2);

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(8);

    return LayoutBuilder(
      builder: (context, constraints) {
        final contentWidth = constraints.maxWidth - padding * 2;
        final indicatorWidth = contentWidth / options.length;

        return Container(
          height: height,
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: radius,
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: animationDuration,
                curve: Curves.easeInOutCubic,
                left: indicatorWidth * selectedIndex,
                child: Container(
                  width: indicatorWidth,
                  height: height - padding * 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: radius,
                  ),
                ),
              ),
              Row(
                children: List.generate(options.length, (index) {
                  return Expanded(
                    child: InkWell(
                      borderRadius: radius,
                      onTap: () => onChanged(index),
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: animationDuration,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          child: Text(options[index]),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
