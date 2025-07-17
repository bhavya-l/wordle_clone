import 'package:flutter/material.dart';
import '../assets/colors.dart';
import '../models/letter_model.dart';

const _keys = [
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
  ['ENTER', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'DEL']
];

class Keyboard extends StatelessWidget {
  const Keyboard({
    Key? key,
    required this.onKeyTapped,
    required this.onDeleteTapped,
    required this.onEnterTapped,
    required this.keyboardLetters,
    }) : super(key: key);

  final void Function(String) onKeyTapped;
  final VoidCallback onDeleteTapped;
  final VoidCallback onEnterTapped;
  final Set<Letter> keyboardLetters;

  @override
  Widget build(BuildContext context) {
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _keys
        .map(
          (keyRow) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: keyRow.map(
              (letter) {
                if (letter == 'DEL') {
                  return _KeyboardButton.delete(onTap: onDeleteTapped);
                } else if (letter == 'ENTER') {
                  return _KeyboardButton.enter(onTap: onEnterTapped);
                }

                final letterKey = keyboardLetters.firstWhere(
                  (e) => e.val == letter,
                  orElse: () => Letter.empty(),
                );
                return _KeyboardButton(
                  onTap: () => onKeyTapped(letter),
                  letter: letter,
                  backgroundColor: letterKey != Letter.empty() ? letterKey.backgroundColor
                    : Colors.grey,
                );
              },
            ).toList(),
          )
        ).toList()
    );
  }
}

class _KeyboardButton extends StatelessWidget {
  const _KeyboardButton({
    Key? key,
    this.height = 48,
    this.width = 30,
    required this.onTap,
    required this.backgroundColor,
    required this.letter,
  }) : super(key: key);

  factory _KeyboardButton.delete({
    required VoidCallback onTap,
  }) => 
    _KeyboardButton(width: 56, onTap: onTap, backgroundColor: Colors.grey, letter: 'DEL');

  factory _KeyboardButton.enter({
    required VoidCallback onTap,
  }) => 
    _KeyboardButton(width: 56, onTap: onTap, backgroundColor: Colors.grey, letter: 'ENTER');

  final double height;
  final double width;
  final VoidCallback onTap;
  final Color backgroundColor;
  final String letter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 3.0,
        horizontal: 2.0
      ),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: height,
            width: width,
            alignment: Alignment.center,
            child: Text(
              letter,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              )
            )
          )
        )
      )
    );
  }
}
