import 'package:flutter/material.dart';
import 'package:flutter_pasantia/models/card_model.dart';

class CardItem extends StatelessWidget {
  final CardModel card;

  CardItem({required this.card});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.9,
      padding: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            card.imageUrl,
            width: screenWidth * 0.3,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID: ${card.id}',
                  style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Name: ${card.name}',
                  style: TextStyle(fontSize: screenWidth * 0.05),
                ),
                Text(
                  'Type: ${card.type}',
                  style: TextStyle(fontSize: screenWidth * 0.04),
                ),
                Text(
                  'Archetype: ${card.archetype ?? "N/A"}',
                  style: TextStyle(fontSize: screenWidth * 0.04),
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
