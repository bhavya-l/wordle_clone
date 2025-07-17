import 'package:flutter/material.dart';
import 'package:wordle_clone/models/letter_model.dart';
import 'letter_tile.dart';
import '../models/word_model.dart';
import 'package:flip_card/flip_card.dart';

class Board extends StatelessWidget {
  const Board({
    Key? key,
    required this.board,
    required this.flipCards,
    }) : super(key: key);

  final List<Word> board;
  final List<List<GlobalKey<FlipCardState>>> flipCards;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: board
      .asMap()
      .map(
        (i, word) => MapEntry(
          i, 
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: word.letters
            .asMap()
            .map((j, letter) => MapEntry(
              j, 
              FlipCard(
                key: flipCards[i][j],
                flipOnTouch: false,
                direction: FlipDirection.VERTICAL,
                front: LetterTile(
                  letter: Letter(val: letter.val, status: LetterStatus.initial)
                ),
                back: LetterTile(letter: letter),
              ),
              )).values.toList(),
          )
        )
      ).values.toList()
    );
  }
}
