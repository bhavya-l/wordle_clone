import 'package:flutter/material.dart';
import 'letter_tile.dart';
import '../models/word_model.dart';

class Board extends StatelessWidget {
  const Board({
    Key? key,
    required this.board,
    }) : super(key: key);

  final List<Word> board;

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
