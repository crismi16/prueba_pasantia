import 'package:flutter/material.dart';
import 'package:flutter_pasantia/providers/card_provider.dart';
import 'package:flutter_pasantia/views/card_item.dart';
import 'package:flutter_pasantia/views/loading_indicator.dart';
import 'package:provider/provider.dart';

class CardListView extends StatefulWidget {
  @override
  _CardListViewState createState() => _CardListViewState();
}

class _CardListViewState extends State<CardListView> {
  ScrollController _scrollController = ScrollController();
  late CardProvider _cardProvider;

  @override
  void initState() {
    super.initState();
    _cardProvider = Provider.of<CardProvider>(context, listen: false);
    _scrollController.addListener(_scrollListener);

    Future.delayed(Duration.zero, () {
      _cardProvider.fetchCards();
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_cardProvider.isLoading) {
      _cardProvider.fetchCards();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CardProvider>(
      builder: (context, cardProvider, child) {
        return ListView.builder(
          controller: _scrollController,
          itemCount: cardProvider.cards.length + (cardProvider.isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < cardProvider.cards.length) {
              return CardItem(card: cardProvider.cards[index]);
            } else {
              return LoadingIndicator();
            }
          },
        );
      },
    );
  }
}
