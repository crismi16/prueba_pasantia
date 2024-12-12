import 'package:flutter/material.dart';
import 'package:flutter_pasantia/views/card_list_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar( 
        title: Text('Yu-Gi-Oh! Card List'), 
      ), 
        body: CardListView(), 
    );
  }
}
