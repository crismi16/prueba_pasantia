import 'package:flutter/material.dart';
import 'package:flutter_pasantia/models/card_model.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var logger = Logger();

class CardProvider with ChangeNotifier {
  List<CardModel> _allCards = [];
  List<CardModel> _filteredCards = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasResults = true;
  static const int _pageSize = 10;

  List<CardModel> get cards => _filteredCards;
  bool get isLoading => _isLoading;
  bool get hasResults => _hasResults;

  Future<void> fetchCards() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse('https://db.ygoprodeck.com/api/v7/cardinfo.php'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _allCards = (data['data'] as List).map((card) => CardModel.fromJson(card)).toList();
        _filteredCards = _allCards.take(_pageSize).toList();
        _page = 1;
      } else {
        logger.e('Failed to load cards');
      }
    } catch (e) {
      logger.e(e); 
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchFilteredCards(String query) async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse('https://db.ygoprodeck.com/api/v7/cardinfo.php?fname=$query'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<CardModel> filteredList = (data['data'] as List).map((card) => CardModel.fromJson(card)).toList();
        _filteredCards = filteredList.take(_pageSize).toList();
        _page = 1;
        _hasResults = _filteredCards.isNotEmpty;
      } else {
        logger.e('Failed to load filtered cards');
        _hasResults = false;
      }
    } catch (e) {
      logger.e(e);
      _hasResults = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreFilteredCards(String query) async {
    if (_isLoading || !_hasResults) return;

    _isLoading = true;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse('https://db.ygoprodeck.com/api/v7/cardinfo.php?fname=$query'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<CardModel> filteredList = (data['data'] as List).map((card) => CardModel.fromJson(card)).toList();
        _filteredCards.addAll(filteredList.skip(_page * _pageSize).take(_pageSize));
        _page++;
        _hasResults = _filteredCards.isNotEmpty;
      } else {
        logger.e('Failed to load more filtered cards');
        _hasResults = false;
      }
    } catch (e) {
      logger.e(e);
      _hasResults = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
