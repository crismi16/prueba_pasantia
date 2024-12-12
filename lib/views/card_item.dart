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
        children: [
          Image.network(
            card.imageUrl,
            width: screenWidth * 0.2,
          ),
          SizedBox(width: screenWidth * 0.05),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card.name,
                  style: TextStyle(fontSize: screenWidth * 0.05),
                ),
                Text(
                  card.type,
                  style: TextStyle(fontSize: screenWidth * 0.04),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
