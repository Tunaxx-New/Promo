import 'package:flutter/material.dart';
import 'package:promo/shared/widgets/card/glass_card.dart';
import 'package:promo/shared/widgets/menus/grid_menu/menu_item.dart';

import 'menu_tile.dart';

/// Сетка быстрых действий 3 в ряд. Количество колонок и элементы
/// настраиваются, поэтому виджет переиспользуется на других экранах.
class MenuGrid extends StatelessWidget {
  const MenuGrid({
    super.key,
    this.items,
    this.crossAxisCount = 3,
    this.onItemTap,
  });

  final List<MenuItem>? items;
  final int crossAxisCount;
  final ValueChanged<MenuItem>? onItemTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final menuItems = items ?? MenuItem.defaults(colorScheme);

    return GlassCard(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: menuItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) => MenuTile(
          item: menuItems[index],
          onTap: onItemTap,
        ),
      ),
    );
  }
}
