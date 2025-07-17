import 'package:flutter/material.dart';
import 'package:wordle_clone/assets/colors.dart';
import '../widgets/board.dart';
import '../widgets/keyboard.dart';
import '../models/letter_model.dart';
import '../models/word_model.dart';
import '../services/words.dart';
import 'dart:math';
import 'package:flip_card/flip_card.dart';

enum GameStatus { playing, submitting, lost, won }

class HomeScreen extends StatefulWidget {
  const HomeScreen ({ Key? key }) : super(key: key);

  @override 
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GameStatus _gameStatus = GameStatus.playing;

  final List<List<GlobalKey<FlipCardState>>> _flipCards = List.generate(
    6,
    (_) => List.generate(5, (_) => GlobalKey<FlipCardState>())
  );

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

  final Set<Letter> _keyboardLetters = {};

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
          Board(board: _board, flipCards: _flipCards),
          SizedBox(height: 200),
          Keyboard(
            onDeleteTapped: _onDeleteTapped,
            onEnterTapped: _onEnterTapped,
            onKeyTapped: _onKeyTapped,
            keyboardLetters: _keyboardLetters,
          ),
      ]),
    );
  }

  void _onKeyTapped(String val) {
    if (_gameStatus == GameStatus.playing) {
      setState(() => _currentWord?.addLetter(val));
    }
  }

  void _onDeleteTapped() {
    if (_gameStatus == GameStatus.playing) {
      setState(() => _currentWord?.removeLetter());
    }
  }

  Future<void> _onEnterTapped() async {
    if (_gameStatus == GameStatus.playing &&
      _currentWord != null &&
      !_currentWord!.letters.contains(Letter.empty())) {
        _gameStatus = GameStatus.submitting;

        for (var i = 0; i < _currentWord!.letters.length; i++) {
          final currentWordLetter = _currentWord!.letters[i];
          final currentSolutionLetter = _solution.letters[i];

          setState(() {
            if (currentWordLetter == currentSolutionLetter) {
              _currentWord!.letters[i] = 
                currentWordLetter.copyWith(status: LetterStatus.correct);
            }
            else if (_solution.letters.contains(currentWordLetter)) {
              _currentWord!.letters[i] = currentWordLetter.copyWith(status: LetterStatus.inWord);
            }
            else {
              _currentWord!.letters[i] = currentWordLetter.copyWith(status: LetterStatus.notInWord);
            }
          });
                
          final letter = _keyboardLetters.firstWhere(
            (e) => e.val == currentWordLetter.val,
            orElse: () => Letter.empty(),
          );
          if (letter.status != LetterStatus.correct) {
            _keyboardLetters.removeWhere((e) => e.val == currentWordLetter.val);
            _keyboardLetters.add(_currentWord!.letters[i]);
          }

          await Future.delayed(
            const Duration(milliseconds: 150),
            () => _flipCards[_currentWordIndex][i].currentState?.toggleCard()
          );
        }
      _checkIfWinOrLoss();
    }
  }

  void _checkIfWinOrLoss() {
    if (_currentWord!.wordString == _solution.wordString) {
      _gameStatus = GameStatus.won;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.none,
          duration: const Duration(days: 1),
          backgroundColor: correctColor,
          content: const Text(
            'You Won!'
          ),
          action: SnackBarAction(
            onPressed: _restart,
            textColor: Colors.white,
            label: 'New Game'
          )
        )
      );
    } else if (_currentWordIndex + 1 >= _board.length) {
      _gameStatus = GameStatus.lost;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.none,
          duration: const Duration(days: 1),
          backgroundColor: Colors.redAccent[200],
          content: Text(
            'You lost! The word was ${_solution.wordString}'
          ),
          action: SnackBarAction(
            onPressed: _restart,
            textColor: Colors.white,
            label: 'New Game'
          )
        )
      );
    } else {
      _gameStatus = GameStatus.playing;
      _currentWordIndex += 1;
    }
  }

  void _restart() {
    setState(() {
      _gameStatus = GameStatus.playing;
      _currentWordIndex = 0;
      _board
        ..clear()
        ..addAll(
          List.generate(
            6,
            (_) => Word(letters: List.generate(5, (_) => Letter.empty()))
          )
        );
      _solution = Word.fromString(
        fiveLetterWords[Random().nextInt(fiveLetterWords.length)].toUpperCase(),
      );
      _flipCards
        ..clear()
        ..addAll(
          List.generate(
            6,
            (_) => List.generate(5, (_) => GlobalKey<FlipCardState>())
          )
        );
      _keyboardLetters.clear();
    });
  }
} 