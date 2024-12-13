// lib/views/card_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_pasantia/models/card_model.dart';

class CardItem extends StatelessWidget {
  final CardModel card;

  const CardItem({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.9,
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2227),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            card.imageUrl,
            width: screenWidth * 0.3,
            height: screenWidth * 0.3,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID: ${card.id}',
                  style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  card.name,
                  style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.white),
                ),
                Text(
                  'Type: ${card.type}',
                  style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
                ),
                Text(
                  'Archetype: ${card.archetype ?? "N/A"}',
                  style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
