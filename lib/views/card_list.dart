import 'package:flutter/material.dart';
import 'package:flutter_pasantia/views/card_item.dart';
import 'package:flutter_pasantia/models/card_model.dart';

class CardList extends StatelessWidget {
  final List<CardModel> cards;

  const CardList({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return CardItem(card: cards[index]);
      },
    );
  }
}
