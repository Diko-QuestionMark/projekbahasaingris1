import 'package:flutter/material.dart';
import 'lesson_intro_page.dart';
import 'lesson_theory_page.dart';
import 'lesson_quiz_page.dart';
import 'lesson_finish_page.dart';

List<Widget> buildMainIdeaLessonPages({
  required VoidCallback nextPage,
}) {
  return [

    // ===================== PAGE 1 — INTRO =====================
    LessonIntroPage(
      onNext: nextPage,
    ),

    // ===================== PAGE 2 — WHAT IS MAIN IDEA =====================
    LessonTheoryPage(
      title: "What Is a Main Idea?",
      text:
          "The main idea is the most important point the author wants to make in a paragraph. "
          "It expresses the overall message, not a single detail or example.",
      onNext: nextPage,
    ),

    // ===================== PAGE 3 — TOPIC VS MAIN IDEA =====================
    LessonTheoryPage(
      title: "Topic vs Main Idea",
      text:
          "The topic tells you what the paragraph is about. "
          "The main idea tells you what the author says about that topic.\n\n"
          "Example:\n"
          "Topic: Online learning\n"
          "Main Idea: Online learning offers flexibility but requires self-discipline.",
      onNext: nextPage,
    ),

    // ===================== PAGE 4 — QUIZ 1 =====================
    LessonQuizPage(
      paragraph:
          "Online learning has become increasingly popular in recent years. "
          "Many students enjoy the flexibility of studying from home, while others struggle "
          "because online classes require strong self-discipline and time management skills.",
      question: "Which statement best expresses the main idea of the paragraph?",
      options: [
        "Online learning",
        "Many students study from home",
        "Online learning is popular and has both advantages and challenges",
        "Time management skills are important",
      ],
      correctIndex: 2,
      explanation:
          "The correct answer summarizes the entire paragraph. "
          "Other options focus only on the topic or mention a single detail, "
          "which makes them too narrow to represent the main idea.",
      onContinue: nextPage,
    ),

    // ===================== PAGE 5 — SUPPORTING DETAILS =====================
    LessonTheoryPage(
      title: "Supporting Details",
      text:
          "Supporting details explain, prove, or give examples of the main idea. "
          "They are usually more specific and should not be confused with the main idea itself.",
      onNext: nextPage,
    ),

    // ===================== PAGE 6 — QUIZ 2 =====================
    LessonQuizPage(
      paragraph:
          "Regular exercise improves overall health. "
          "It strengthens the heart, helps control body weight, and reduces stress levels.",
      question: "Which option is a supporting detail, not the main idea?",
      options: [
        "Regular exercise improves overall health",
        "Exercise is important for the body",
        "Exercise strengthens the heart and reduces stress",
        "Exercise has many benefits",
      ],
      correctIndex: 2,
      explanation:
          "This option gives specific examples of how exercise benefits the body. "
          "The other choices are more general and describe the overall message of the paragraph.",
      onContinue: nextPage,
    ),

    // ===================== PAGE 7 — IMPLIED MAIN IDEA =====================
    LessonTheoryPage(
      title: "Implied Main Idea",
      text:
          "Sometimes, the main idea is not stated directly. "
          "In this case, you must combine all the details and infer what the author is trying to say.",
      onNext: nextPage,
    ),

    // ===================== PAGE 8 — QUIZ 3 (IMPLIED) =====================
    LessonQuizPage(
      paragraph:
          "Sarah wakes up early every morning to review her notes before class. "
          "She participates actively during lessons and asks questions when she does not understand. "
          "After school, she organizes her study schedule for the next day.",
      question: "What is the implied main idea of the paragraph?",
      options: [
        "Sarah wakes up early every day",
        "Sarah is a disciplined and responsible student",
        "Sarah studies only in the morning",
        "Sarah asks many questions in class",
      ],
      correctIndex: 1,
      explanation:
          "The paragraph does not directly state the main idea. "
          "However, all the details show that Sarah is organized, responsible, "
          "and serious about her studies.",
      onContinue: nextPage,
    ),

    // ===================== PAGE 9 — STRATEGY =====================
    LessonTheoryPage(
      title: "How to Find the Main Idea",
      text:
          "To find the main idea:\n"
          "1. Read the entire paragraph carefully.\n"
          "2. Identify the topic.\n"
          "3. Ask: What is the author saying about the topic?\n"
          "4. Ignore repeated examples or minor details.\n"
          "5. Choose the most general correct statement.",
      onNext: nextPage,
    ),

    // ===================== PAGE 10 — FINAL CHALLENGE =====================
    LessonQuizPage(
      paragraph:
          "Many people prefer to use public transportation in large cities. "
          "It reduces traffic congestion, lowers air pollution, and saves money. "
          "As cities continue to grow, public transportation plays an important role "
          "in creating a more sustainable urban environment.",
      question: "What is the main idea of the paragraph?",
      options: [
        "Public transportation is cheap",
        "Large cities have traffic problems",
        "Public transportation helps create sustainable cities",
        "Air pollution is caused by cars",
      ],
      correctIndex: 2,
      explanation:
          "The correct answer captures the overall message of the paragraph. "
          "The other options mention only one effect or problem, "
          "which makes them too specific to be the main idea.",
      onContinue: nextPage,
    ),

    // ===================== PAGE 11 — FINISH =====================
    const LessonFinishPage(),
  ];
}