import 'package:flutter/material.dart';
import 'lesson_scaffold.dart';

class LessonIntroPage extends StatelessWidget {
  final VoidCallback onNext;

  const LessonIntroPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return LessonScaffold(
      icon: Icons.menu_book,
      title: "Belajar Main Idea",
      text: "Belajar sedikit demi sedikit, lalu langsung latihan 🎯",
      buttonText: "Mulai",
      onPressed: onNext,
    );
  }
}
