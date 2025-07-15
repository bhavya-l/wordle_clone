import 'package:flutter/material.dart';
import 'letter_tile.dart';

class Board extends StatelessWidget {
  const Board({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (col) {
            return LetterTile();
          }),
        );
      })
    );
  }
}
