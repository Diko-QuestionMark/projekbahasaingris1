import 'package:flutter/material.dart';
import 'lesson_scaffold.dart';

class LessonTheoryPage extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback onNext;

  const LessonTheoryPage({
    super.key,
    required this.title,
    required this.text,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return LessonScaffold(
      icon: Icons.lightbulb_outline,
      title: title,
      text: text,
      buttonText: "Lanjut",
      onPressed: onNext,
    );
  }
}
