import 'package:flutter/material.dart';
import '../widgets/board.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Wordle')
      ),
      body: Center(
        child: Board(),
      ),
    );
  }
}