import 'package:flutter/material.dart';
import 'package:ujicoba1/pages/test_page/find_main_idea.dart';

class ChoseTest extends StatefulWidget {
  const ChoseTest({super.key});

  @override
  State<ChoseTest> createState() => _ChoseTestState();
}

class _ChoseTestState extends State<ChoseTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("Knowledge Test"),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade600, Colors.purple.shade400],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade600, Colors.purple.shade400],
                ),
              ),
              child: Column(
                children: [
                  Icon(Icons.quiz_rounded, size: 50, color: Colors.white),
                  const SizedBox(height: 12),
                  const Text(
                    "Uji Kepamahaman Materi",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Uji dan latih kepahaman mengenai ReadingText 1",
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // 1
                  _buildFullMenuCard(
                    icon: Icons.book_online,
                    title: "Find Main Idea",
                    subtitle: "Read a random paragraph and identify its main idea",
                    color: Colors.red.shade600,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FindMainIdea(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // 2
                  _buildFullMenuCard(
                    icon: Icons.menu_book,
                    title: "Test 2",
                    subtitle: "Soal vocabulary lanjutan",
                    color: Colors.blue.shade600,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChoseTest(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // 3
                  _buildFullMenuCard(
                    icon: Icons.lightbulb_outline,
                    title: "Test 3",
                    subtitle: "Soal main idea",
                    color: Colors.green.shade600,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChoseTest(),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 16,),

                  // 4
                  _buildFullMenuCard(
                    icon: Icons.assignment,
                    title: "Test 4",
                    subtitle: "Soal inference",
                    color: Colors.orange.shade600,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChoseTest(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // 5
                  _buildFullMenuCard(
                    icon: Icons.fact_check,
                    title: "Test 5",
                    subtitle: "Kesimpulan & ringkasan",
                    color: Colors.purple.shade600,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChoseTest(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Full Menu Card (sesuai style permintaanmu)
  // -------------------------------------------------------------------------
  Widget _buildFullMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.25)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: color.withOpacity(0.95),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
