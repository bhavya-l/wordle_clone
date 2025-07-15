import 'package:flutter/material.dart';

class LetterTile extends StatelessWidget {
  const LetterTile({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48, // or use MediaQuery for dynamic sizing
      height: 48,
      alignment: Alignment.center,
      margin: EdgeInsets.all(4), // spacing between tiles
      decoration: BoxDecoration(
        color: Colors.white, // background color
        border: Border.all(
          color: Colors.grey.shade300, // light border like Wordle
          width: 2,
        ),
      )
      //NEED TO ADD IN TEXT() FOR LETTER VALUE
    );
  }
}