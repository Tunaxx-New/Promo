import 'package:flutter/material.dart';
import 'package:promo/shared/theme/app_colors.dart';


/// Нижняя навигация. Состояние хранит родитель, поэтому виджет
/// можно переиспользовать в любом контейнере экранов.
class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const List<_NavigationEntry> _entries = <_NavigationEntry>[
    _NavigationEntry('Главная', Icons.home),
    _NavigationEntry('История', Icons.receipt_long),
    _NavigationEntry('Карта', Icons.place_outlined),
    _NavigationEntry('Профиль', Icons.person_outline),
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
              final color =
                  selected ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.onSurfaceVariant;

              return Expanded(
                child: InkWell(
                  onTap: () => onTap(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(entry.icon, size: 32, color: color),
                      const SizedBox(height: 2),
                      Text(
                        entry.label,
                        style: TextStyle(
                          color: color,
                          fontSize: 11,
                          fontWeight:
                              selected ? FontWeight.w600 : FontWeight.w400,
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
  const _NavigationEntry(this.label, this.icon);

  final String label;
  final IconData icon;
}
