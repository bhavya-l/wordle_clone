import 'package:flutter/material.dart';
import '../assets/colors.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 360, 
          child: buildRow(['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P']),
        ),
        SizedBox(height: 2),
        SizedBox(
          width: 320, 
          child: buildRow(['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L']),
        ),
        SizedBox(height: 2),
        SizedBox(
          width: 340, 
          child: buildRow(['ENTER', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', '⌫']),
        ),
      ],
    );
  }

  Widget buildRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((key) => buildKey(key)).toList(),
    );
  }

  Widget buildKey(String label) {
    bool isSpecial = label == 'ENTER' || label == '⌫';
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: isSpecial ? 40 : 30,
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: keyboardColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isSpecial ? 10 : 14,
          ),
        ),
      ),
    );
  }
}
