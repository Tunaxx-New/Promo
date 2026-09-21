import 'package:flutter/material.dart';

class SelectionItem {
  const SelectionItem({required this.label, required this.color});

  final String label;
  final Color color;
}

class HorizontalSelection extends StatefulWidget {
  const HorizontalSelection({
    super.key,
    required this.items,
    required this.onSelect,
    this.initialIndex = 0,
  });
  final List<SelectionItem> items;
  final ValueChanged<int> onSelect;
  final int initialIndex;
  @override
  State<HorizontalSelection> createState() => _HorizontalSelectionState();
}

class _HorizontalSelectionState extends State<HorizontalSelection> {
  late int _selectedIndex;
  final ScrollController _scrollController = ScrollController();
  late List<GlobalKey> _itemKeys;
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _itemKeys = List.generate(widget.items.length, (_) => GlobalKey());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _selectItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onSelect(index);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _itemKeys[index].currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.5,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = index == _selectedIndex;
          return Container(
            key: _itemKeys[index],
            child: Material(
              color: selected
                  ? widget.items[index].color
                  : widget.items[index].color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _selectItem(index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: Text(
                      widget.items[index].label,
                      style: TextStyle(
                        color: selected
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                        fontSize: 14,
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
