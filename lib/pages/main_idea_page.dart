import 'package:flutter/material.dart';
import '../models/forMainIdea/lesson_pages.dart';

class MainIdeaPage extends StatefulWidget {
  const MainIdeaPage({super.key});

  @override
  State<MainIdeaPage> createState() => _MainIdeaPageState();
}

class _MainIdeaPageState extends State<MainIdeaPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  void _nextPage() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = buildMainIdeaLessonPages(nextPage: _nextPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Idea"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: LinearProgressIndicator(
            value: (_currentPage + 1) / pages.length,
            minHeight: 6,
          ),
        ),
      ),
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (i) => setState(() => _currentPage = i),
        children: pages,
      ),
    );
  }
}
