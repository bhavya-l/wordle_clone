import 'package:equatable/equatable.dart';
import 'package:wordle_clone/assets/colors.dart';
import 'package:flutter/material.dart';

enum LetterStatus { initial, notInWord, inWord, correct }

class Letter extends Equatable {
  const Letter({
    required this.val,
    this.status = LetterStatus.initial
  });

  factory Letter.empty() => const Letter(val: '');
  final String val; 
  final LetterStatus status; 

  Color get backgroundColor {
    switch (status) {
      case LetterStatus.initial: 
        return initialColor;
      case LetterStatus.notInWord: 
        return notCorrectColor;
      case LetterStatus.correct:
        return correctColor; 
      case LetterStatus.inWord:
        return partialCorrectColor;
    }
  }
  
  Color get borderColor {
    switch (status) {
      case LetterStatus.initial:
        return Colors.grey;
      default: 
        return Colors.transparent;
    }
  }

  Letter copyWith({
    String? val,
    LetterStatus? status,
  }) {
    return Letter( 
      val: val ?? this.val,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [val, status];
}