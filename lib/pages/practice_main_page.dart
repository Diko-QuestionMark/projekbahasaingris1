import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:lottie/lottie.dart';
import '../models/question_model.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  int currentQuestion = 0;
  int score = 0;
  bool quizFinished = false;

  int? selectedIndex;
  bool answered = false;

  late ConfettiController _confettiController;
  late AnimationController _progressController;

  final List<Question> questions = [
    Question(
      text: "What is the Main Idea in a paragraph?",
      options: [
        "A specific example supporting the text.",
        "The most important point the writer wants to communicate.",
        "A minor detail mentioned in the passage.",
        "The longest sentence in the paragraph.",
      ],
      correctIndex: 2,
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
          "`Dogs are popular pets because they are friendly, loyal, and helpful to humans. Many families around the world choose dogs as companions because they can protect homes, play with children, and follow commands.` \n\nWhat is the Main Idea of the paragraph about dogs?",
      options: [
        "Dogs can follow many commands.",
        "Dogs are popular pets because they are friendly, loyal, and helpful to humans.",
        "Many families own dogs as pets.",
        "Dogs bark when strangers come.",
      ],
      correctIndex: 1,
    ),

    Question(
      text: "What is the purpose of supporting details in a paragraph?",
      options: [
        "To introduce a completely new topic.",
        "To explain, support, or prove the Main Idea.",
        "To make the paragraph look longer.",
        "To distract the reader from the topic.",
      ],
      correctIndex: 1,
    ),

    Question(
      text:
          "`Regular exercise plays an important role in keeping the body healthy. "
          "It helps improve heart function, strengthens muscles, and boosts energy levels. "
          "People who exercise regularly often feel more active and less stressed.`\n\n"
          "Which sentence is a Supporting Detail of the idea 'Exercise improves health'?",
      options: [
        "Exercise is important for everyone.",
        "Exercise helps keep the heart strong.",
        "People should exercise more often.",
        "Health is a basic need for humans.",
      ],
      correctIndex: 1,
    ),

    Question(
      text: "How do you find the Main Idea of a paragraph?",
      options: [
        "Read only the first sentence.",
        "Ignore all details and examples.",
        "Read the whole paragraph and identify the central message.",
        "Look only at numbers and data.",
      ],
      correctIndex: 2,
    ),

    Question(
      text:
          "`Water is essential for the body because it helps with digestion, keeps the body hydrated, "
          "and supports overall health. While many people like to drink sugary beverages such as soda "
          "or sweet tea, these drinks often contain too much sugar and can be unhealthy if consumed too often. "
          "That’s why choosing water is usually a better and healthier option.`\n\n"
          "What is the Main Idea of the paragraph about water?",
      options: [
        "Sugary drinks taste good.",
        "Water helps the body function but sugary drinks contain too much sugar.",
        "People buy many different drinks each day.",
        "Water is a healthier choice than sugary drinks.",
      ],
      correctIndex: 3,
    ),

    Question(
      text:
          "`Social media has become an important part of modern life. "
          "People use it to communicate with friends and family, share information instantly, "
          "and stay updated on events happening around the world. Because of these benefits, "
          "social media plays a significant role in helping people stay connected.`\n\n"
          "According to the paragraph, social media is important because...",
      options: [
        "Everyone uses social media every day.",
        "It helps people communicate, share information, and stay connected.",
        "It is only used for entertainment and fun.",
        "It completely replaces face-to-face interactions.",
      ],
      correctIndex: 1,
    ),

    Question(
      text:
          "Based on the strategies explained in the video about finding the main idea, which strategy is NOT mentioned in the video?",
      options: [
        "Using titles and headings",
        "Using topic sentences",
        "Using concluding sentences",
        "Find the most difficult word",
      ],
      correctIndex: 3,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void answerQuestion(int index) {
    if (answered) return;

    setState(() {
      selectedIndex = index;
      answered = true;
    });

    final correct = questions[currentQuestion].correctIndex;

    if (index == correct) {
      score++;
      _confettiController.play();
    }

    _progressController.forward(from: 0);

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      if (currentQuestion < questions.length - 1) {
        setState(() {
          currentQuestion++;
          selectedIndex = null;
          answered = false;
        });
      } else {
        setState(() {
          quizFinished = true;
        });
      }
    });
  }

  Color getButtonColor(int index) {
    if (!answered) return Colors.purple;

    final correct = questions[currentQuestion].correctIndex;

    if (index == selectedIndex) {
      return index == correct ? Colors.green.shade700 : Colors.red.shade700;
    }

    if (index == correct) {
      return Colors.green.shade700;
    }

    return Colors.grey.shade400;
  }

  void restartQuiz() {
    setState(() {
      currentQuestion = 0;
      score = 0;
      quizFinished = false;
      selectedIndex = null;
      answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (quizFinished) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Main Idea Practice Result"),
          backgroundColor: Color.fromARGB(255, 231, 231, 231),
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
                onPressed: () =>
                    Navigator.popUntil(context, (route) => route.isFirst),
                child: const Text("Return to Home"),
              ),
            ],
          ),
        ),
      );
    }

    final question = questions[currentQuestion];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Idea Practice"),
        backgroundColor: Colors.purple.shade200,
      ),
      body: Stack(
        children: [
          // CONFETTI ============================================================
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                emissionFrequency: 0,
                numberOfParticles: 25,
                gravity: 0.3,
              ),
            ),
          ),

          SingleChildScrollView(
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
                    height: 230,
                    child: Lottie.asset('assets/lottie/education.json'),
                  ),
                ),

                Text(
                  question.text,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),

                ...List.generate(question.options.length, (index) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ElevatedButton(
                      onPressed: answered ? null : () => answerQuestion(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: getButtonColor(index),
                        foregroundColor: Colors.white,
                      ),
                      child: Text(question.options[index]),
                    ),
                  );
                }),

                const SizedBox(height: 40),
              ],
            ),
          ),

          if (answered)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: 6,
                child: AnimatedBuilder(
                  animation: _progressController,
                  builder: (_, __) => LinearProgressIndicator(
                    value: _progressController.value,
                    backgroundColor: Colors.grey.shade300,
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
