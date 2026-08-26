import 'package:flutter/material.dart';
import 'package:promo/features/cards/widgets/card_card.dart';
import 'package:promo/shared/models/user_card.dart';

class CardsPage extends StatelessWidget {
  final List<UserCard> cards;
  final Future<void> Function()? onRefresh;

  const CardsPage({super.key, this.onRefresh, required this.cards});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await onRefresh?.call();
        },
        child: ListView.builder(
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
