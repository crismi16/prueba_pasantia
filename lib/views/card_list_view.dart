import 'package:flutter/material.dart';
import 'package:flutter_pasantia/providers/card_provider.dart';
import 'package:flutter_pasantia/views/card_item.dart';
import 'package:flutter_pasantia/views/loading_indicator.dart';
import 'package:provider/provider.dart';

class CardListView extends StatefulWidget {
  const CardListView({super.key});

  @override
  CardListViewState createState() => CardListViewState();
}

class CardListViewState extends State<CardListView> {
  final ScrollController _scrollController = ScrollController();
  late CardProvider _cardProvider;
  String _searchQuery = "";

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
      _cardProvider.loadMoreFilteredCards(_searchQuery);
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    _cardProvider.fetchFilteredCards(query);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Yu-Gi-Oh! Card List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Consumer<CardProvider>(
        builder: (context, cardProvider, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search cards...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: cardProvider.hasResults 
                  ? ListView.builder(
                      controller: _scrollController,
                      itemCount: cardProvider.cards.length + (cardProvider.isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < cardProvider.cards.length) {
                          return CardItem(card: cardProvider.cards[index]);
                        } else {
                          return const LoadingIndicator();
                        }
                      },
                    )
                  : const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, color: Colors.white, size: 64.0),
                          SizedBox(height: 16.0),
                          Text(
                            'No results found',
                            style: TextStyle(color: Colors.white, fontSize: 24.0),
                          ),
                        ],
                      ),
                    ),
              ),
            ],
          );
        },
      ),
    );
  }
}
