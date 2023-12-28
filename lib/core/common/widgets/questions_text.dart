import 'package:flutter/material.dart';

class QuestionText extends StatelessWidget {
  final String question;
  const QuestionText({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // Text will be added later from an api end point
        Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        decoration: const BoxDecoration(color: Colors.black),
        padding: const EdgeInsets.symmetric(vertical: 8),
        width: double.infinity,
        child: Text(
          question.split('\n')
      .map((line) => line.trimLeft())
      .join('\n'),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
