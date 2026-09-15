import 'package:flutter/material.dart';
import 'package:promo/shared/theme/app_colors.dart';

class AppBarRoof extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? description;
  final bool showBackButton;
  final Widget child;

  const AppBarRoof({
    super.key,
    required this.title,
    required this.child,
    this.description,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        toolbarHeight: 56,
        automaticallyImplyLeading: false,

        leading: showBackButton
            ? Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => Navigator.of(context).pop(),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: colorScheme.onSurface,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(width: 56),

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height * 0.15,
          ),
          child: Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(24, showBackButton ? 24 : 0, 24, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.normal,
                    color: AppColors.textColorOnBackground,
                  ),
                ),
                if (description != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    description!,
                    style: const TextStyle(fontSize: 12, color: AppColors.textColorOnBackgroundLight),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
        ),
        child: SafeArea(top: false, child: child),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(128);
}
