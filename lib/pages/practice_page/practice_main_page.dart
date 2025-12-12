import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:lottie/lottie.dart';

import '../../models/question_model.dart';
import '../../database/q_dta_p_main_idea.dart';


class PracticeMainIdea extends StatefulWidget {
  const PracticeMainIdea({super.key});

  @override
  State<PracticeMainIdea> createState() => _QuizPageState();
}          

class _QuizPageState extends State<PracticeMainIdea>
    with TickerProviderStateMixin {
  int currentQuestion = 0;
  int score = 0;
  bool quizFinished = false;

  bool answerLocked = false;
  int? selectedIndex;
  double progressValue = 0.0;

  late ConfettiController _confettiController;

  late AnimationController shakeController;
  late Animation<double> shakeAnimation;

  @override
  void initState() {
    super.initState();

    _confettiController = ConfettiController(
      duration: const Duration(milliseconds: 800),
    );

    shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    shakeAnimation = Tween<double>(begin: 0, end: 12).animate(
      CurvedAnimation(parent: shakeController, curve: Curves.elasticIn),
    );
  }

  @override
  void dispose() {
    shakeController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void handleAnswer(int index) async {
    if (answerLocked) return;

    setState(() {
      selectedIndex = index;
      answerLocked = true;
    });

    bool correct = index == questions[currentQuestion].correctIndex;

    if (correct) {
      score++;
      _confettiController.play();
    } else {
      // SHAKE ANIMATION (SEPERTI FILE FindMainIdea)
      shakeController.forward().then((_) => shakeController.reverse());
    }

    // Progress bar manual 3 detik
    progressValue = 0.0;
    const delay = Duration(milliseconds: 30);

    for (int i = 0; i < 100; i++) {
      await Future.delayed(delay);
      if (!mounted) return;
      setState(() => progressValue += 0.01);
    }

    _nextQuestion();
  }

  void _nextQuestion() {
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedIndex = null;
        answerLocked = false;
        progressValue = 0.0;
      });
    } else {
      setState(() => quizFinished = true);
    }
  }

  void restartQuiz() {
    setState(() {
      currentQuestion = 0;
      score = 0;
      quizFinished = false;
      answerLocked = false;
      selectedIndex = null;
      progressValue = 0.0;
    });
  }

  // ===================== DAFTAR SOAL =====================

  final List<Question> questions = [
    Question(
      text: "What is the Main Idea in a paragraph?",
      options: [
        "A specific example supporting the text.",
        "The most important point the writer wants to communicate.",
        "A minor detail mentioned in the passage.",
        "The longest sentence in the paragraph.",
      ],
      correctIndex: 1,
    ),
    Question(
      text: "What is the correct difference between Topic and Main Idea?",
      options: [
        "Topic is a full sentence; Main Idea is just a word.",
        "Topic tells what the paragraph is about; Main Idea tells what the writer says about that topic.",
        "Topic contains examples; Main Idea contains numbers and facts.",
        "Topic and Main Idea mean exactly the same thing.",
      ],
      correctIndex: 1,
    ),
    Question(
      text: "Which option is an example of a Topic?",
      options: [
        "Dogs are loyal pets.",
        "Dogs help protect houses.",
        "The reasons why dogs are useful.",
        "Dogs.",
      ],
      correctIndex: 3,
    ),
    Question(
      text:
          "`Dogs are popular pets because they are friendly, loyal, and helpful to humans. Many families choose dogs because they can protect homes and follow commands.`\n\nWhat is the Main Idea?",
      options: [
        "Dogs can follow commands.",
        "Dogs are popular pets because they are friendly, loyal, and helpful.",
        "Many families own dogs.",
        "Dogs bark to protect homes.",
      ],
      correctIndex: 1,
    ),
    Question(
      text: "What is the purpose of supporting details?",
      options: [
        "To introduce a new topic.",
        "To explain, support, or prove the Main Idea.",
        "To make the paragraph look longer.",
        "To distract the reader.",
      ],
      correctIndex: 1,
    ),
  ];

  // =============================================================

  @override
  Widget build(BuildContext context) {
    if (quizFinished) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Main Idea Practice Result"),
          backgroundColor: const Color.fromARGB(255, 231, 231, 231),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                child: Lottie.asset('assets/lottie/star.json'),
              ),
              const Text("Your Score:", style: TextStyle(fontSize: 28)),
              const SizedBox(height: 10),
              Text(
                "$score / ${questions.length}",
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: restartQuiz,
                child: const Text("Try Again"),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Return to Home"),
              ),
            ],
          ),
        ),
      );
    }

    final question = questions[currentQuestion];

    return Stack(
      children: [
        // ================= SHAKE AREA =================
        AnimatedBuilder(
          animation: shakeAnimation,
          builder: (context, child) {
            double offset = shakeAnimation.value;
            return Transform.translate(
              offset: Offset(
                answerLocked && selectedIndex != question.correctIndex
                    ? (offset % 2 == 0 ? offset : -offset)
                    : 0,
                0,
              ),
              child: child,
            );
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Main Idea Practice"),
              backgroundColor: const Color.fromARGB(255, 231, 231, 231),
            ),

            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pertanyaan ${currentQuestion + 1}/${questions.length}",
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),

                  Center(
                    child: SizedBox(
                      height: 200,
                      child: Lottie.asset('assets/lottie/education.json'),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    question.text,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ===================== OPTIONS =====================
                  ...List.generate(question.options.length, (index) {
                    Color? color;

                    if (answerLocked) {
                      if (index == question.correctIndex) {
                        color = Colors.green;
                      } else if (index == selectedIndex) {
                        color = Colors.red;
                      } else {
                        color = Colors.grey.shade400;
                      }
                    }

                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                        ),
                        onPressed: () => handleAnswer(index),
                        child: Text(
                          question.options[index],
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 20),

                  // ===================== PROGRESS =====================
                  if (answerLocked)
                    LinearProgressIndicator(
                      value: progressValue,
                      backgroundColor: Colors.grey.shade300,
                      color: Colors.purple,
                    ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),

        // ================= CONFETTI =================
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            numberOfParticles: 25,
            maxBlastForce: 10,
            minBlastForce: 5,
            emissionFrequency: 0.01,
            gravity: 0.3,
          ),
        ),
      ],
    );
  }
}
