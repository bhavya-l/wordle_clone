import 'package:flutter/material.dart';
import '../models/letter_model.dart';

class LetterTile extends StatelessWidget {
  const LetterTile({
    Key? key,
    required this.letter,
    }) : super(key: key);

  final Letter letter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64, 
      height: 64,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(4), 
      decoration: BoxDecoration(
        color: letter.backgroundColor, 
        border: Border.all(
          color: letter.backgroundColor, 
          width: 2,
        ),
      ),
      child: Text(
        letter.val,
        style: const TextStyle(
            fontSize: 32, 
            fontWeight: FontWeight.bold,
          )
        )
      //NEED TO ADD IN TEXT() FOR LETTER VALUE
    );
  }
}