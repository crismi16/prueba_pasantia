import 'dart:convert';
import 'package:flutter_pasantia/models/card_model.dart';
import 'package:http/http.dart' as http;

class CardController {
  Future<List<CardModel>> fetchCards(int page) async {
    final response = await http.get(Uri.parse('https://db.ygoprodeck.com/api/v7/cardinfo.php?num=10&offset=${(page - 1) * 10}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['data'] as List).map((card) => CardModel.fromJson(card)).toList();
    } else {
      throw Exception('Failed to load cards');
    }
  }
}
