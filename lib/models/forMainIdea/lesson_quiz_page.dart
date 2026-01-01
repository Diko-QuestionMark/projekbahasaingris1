import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class LessonQuizPage extends StatefulWidget {
  final String paragraph;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final VoidCallback onContinue;

  const LessonQuizPage({
    super.key,
    required this.paragraph,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    required this.onContinue,
  });

  @override
  State<LessonQuizPage> createState() => _LessonQuizPageState();
}

class _LessonQuizPageState extends State<LessonQuizPage> {
  int? _selectedIndex;
  bool _answered = false;

  // 🔊 AUDIO PLAYER
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playCorrect() {
    _audioPlayer.play(AssetSource('sound/correct.mp3'), volume: 0.4);
  }

  void _playWrong() {
    _audioPlayer.play(AssetSource('sound/wrong.mp3'), volume: 0.4);
  }

  void _playClick() {
    _audioPlayer.play(AssetSource('sound/click.mp3'), volume: 0.25);
  }

  void _resetQuiz() {
    setState(() {
      _selectedIndex = null;
      _answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionLabel("Read the paragraph"),
            _paragraphCard(),
            const SizedBox(height: 20),
            _questionCard(),
            const SizedBox(height: 20),
            _options(),
            if (_answered) ...[
              const SizedBox(height: 24),
              _feedbackCard(),
              const SizedBox(height: 16),
              _actionButtons(),
            ],
          ],
        ),
      ),
    );
  }

  // ================= UI =================

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade600,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget _paragraphCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        widget.paragraph,
        style: const TextStyle(fontSize: 15, height: 1.6),
      ),
    );
  }

  Widget _questionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Text(
        widget.question,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _options() {
    return Column(
      children: List.generate(widget.options.length, (index) {
        final isSelected = _selectedIndex == index;
        final isCorrect = index == widget.correctIndex;

        Color bg = Colors.white;
        Color border = Colors.grey.shade300;

        if (_answered) {
          if (isCorrect) {
            bg = Colors.green.shade100;
            border = Colors.green;
          } else if (isSelected) {
            bg = Colors.red.shade100;
            border = Colors.red;
          }
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: bg,
              foregroundColor: Colors.black87,
              minimumSize: const Size.fromHeight(54),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(color: border),
              ),
            ),
            onPressed: _answered
                ? null
                : () {
                    setState(() {
                      _selectedIndex = index;
                      _answered = true;
                    });

                    if (index == widget.correctIndex) {
                      _playCorrect();
                    } else {
                      _playWrong();
                    }
                  },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.options[index]),
            ),
          ),
        );
      }),
    );
  }

  Widget _feedbackCard() {
    final bool correct = _selectedIndex == widget.correctIndex;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: correct ? Colors.green.shade50 : Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: correct ? Colors.green.shade200 : Colors.red.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            correct ? "✅ Great job!" : "❌ Almost there",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(widget.explanation,
              style: const TextStyle(fontSize: 14, height: 1.5)),
        ],
      ),
    );
  }

  Widget _actionButtons() {
    final bool correct = _selectedIndex == widget.correctIndex;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (!correct)
          TextButton(
            onPressed: () {
              _playClick();
              _resetQuiz();
            },
            child: const Text("Try Again"),
          ),
        if (correct)
          ElevatedButton(
            onPressed: () {
              _playClick();
              widget.onContinue();
            },
            child: const Text("Continue"),
          ),
      ],
    );
  }
}
