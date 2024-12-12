import 'package:flutter/material.dart';
import 'package:flutter_pasantia/controllers/card_controller.dart';
import 'package:flutter_pasantia/models/card_model.dart';

class CardProvider with ChangeNotifier {
  List<CardModel> _cards = [];
  int _page = 1;
  bool _isLoading = false;

  List<CardModel> get cards => _cards;
  bool get isLoading => _isLoading;

  Future<void> fetchCards() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();
    try {
      final newCards = await CardController().fetchCards(_page);
      _cards.addAll(newCards);
      _page++;
    } catch (e) {
      print('Error fetching cards: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
