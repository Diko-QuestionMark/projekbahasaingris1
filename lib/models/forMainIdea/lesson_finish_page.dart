import 'package:flutter/material.dart';
import 'lesson_scaffold.dart';

class LessonFinishPage extends StatelessWidget {
  const LessonFinishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonScaffold(
      icon: Icons.emoji_events,
      title: "Selesai 🎉",
      text: "Kamu sudah menyelesaikan pelajaran Main Idea!",
      buttonText: "Kembali",
      onPressed: () => Navigator.pop(context),
    );
  }
}
