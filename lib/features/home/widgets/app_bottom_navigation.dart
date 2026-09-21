import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/theme/app_colors.dart';

/// Нижняя навигация. Состояние хранит родитель, поэтому виджет
/// можно переиспользовать в любом контейнере экранов.
class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int? currentIndex;
  final ValueChanged<int> onTap;

  static final List<_NavigationEntry> _entries = [
    _NavigationEntry(Icons.home, (context) => context.l10n.main),
    _NavigationEntry(Icons.receipt_long, (context) => context.l10n.history),
    _NavigationEntry(Icons.place_outlined, (context) => context.l10n.map),
    _NavigationEntry(Icons.person_outline, (context) => context.l10n.profile),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF061428),
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 62,
          child: Row(
            children: List.generate(_entries.length, (index) {
              final entry = _entries[index];
              final selected = index == currentIndex;
              final label = entry.label(context);
              final color = selected
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.onSurfaceVariant;

              return Expanded(
                child: InkWell(
                  onTap: () => onTap(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(entry.icon, size: 32, color: color),
                      const SizedBox(height: 2),
                      Text(
                        label,
                        style: TextStyle(
                          color: color,
                          fontSize: 11,
                          fontWeight: selected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavigationEntry {
  const _NavigationEntry(this.icon, this.label);

  final IconData icon;
  final String Function(BuildContext) label;
}
