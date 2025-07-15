import 'package:flutter/material.dart';
import '../widgets/board.dart';
import '../widgets/keyboard.dart';
import '../models/letter_model.dart';
import '../models/word_model.dart';
import '../services/words.dart';
import 'dart:math';

enum GameStatus { playing, submitting, lost, won }

class HomeScreen extends StatefulWidget {
  const HomeScreen ({ Key? key }) : super(key: key);

  @override 
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GameStatus _gameStatus = GameStatus.playing;

  final List<Word> _board = List.generate(
    6,
    (_) => Word(letters: List.generate(5, (_) => Letter.empty()))
  );

  int _currentWordIndex = 0;

  Word? get _currentWord => 
    _currentWordIndex < _board.length ? _board[_currentWordIndex] : null;
  
  Word _solution = Word.fromString(
    fiveLetterWords[Random().nextInt(fiveLetterWords.length)].toUpperCase(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Wordle')
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Board(board: _board),
          SizedBox(height: 200),
          Keyboard(),
      ]),
    );
  }
} 