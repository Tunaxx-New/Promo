import 'package:flutter/material.dart';
import 'package:promo/features/cards/widgets/card_card.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/models/user_card.dart';

class CardsPage extends StatelessWidget {
  final List<UserCard> cards;
  final Future<void> Function()? onRefresh;
  final bool isLoading;
  final bool showAppBar;

  const CardsPage({
    super.key,
    this.onRefresh,
    required this.cards,
    required this.isLoading,
    this.showAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? AppBar(title: Text(context.l10n.myCards)) : null,
      body: RefreshIndicator(
        onRefresh: () async {
          await onRefresh?.call();
        },
        child: isLoading
            ? const Center(
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(strokeWidth: 3),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return CardCard(card: cards[index]);
                },
              ),
      ),
    );
  }
}
