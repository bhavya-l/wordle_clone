import 'letter_model.dart';
import 'package:equatable/equatable.dart';

class Word extends Equatable {
  const Word({required this.letters});

  factory Word.fromString(String word) => 
    Word(letters: word.split('').map((e) => Letter(val: e)).toList());
  
  final List<Letter> letters;

  String get wordString => letters.map((e) => e.val).join();

  void addLetter(String val) {
    final currentIndex = letters.indexWhere((e) => e.val.isEmpty);
    if (currentIndex != -1) {
      letters[currentIndex] = Letter(val: val);
    }
  }

  void removeLetter() {
    final currentIndex = letters.indexWhere((e) => e.val.isNotEmpty);
    if (currentIndex != -1) {
      letters[currentIndex] = Letter.empty();
    }
  }

  @override 
  List<Object?> get props => [letters];
}
