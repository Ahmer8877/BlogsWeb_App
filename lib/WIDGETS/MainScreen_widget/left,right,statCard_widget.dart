// LEFT CONTENT
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class leftContent extends StatelessWidget {
  const leftContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Blogs Web App",
              style: TextStyle(color: Colors.greenAccent),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Share Your ",
            style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Knowledge",
            style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Colors.greenAccent),
          ),
          const Text(
            "With The World",
            style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          const Text(
            "A modern blogging platform ,upload blogs the world-wide\n and describe your motives ->",
          ),

          const SizedBox(height: 30),

          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                ),
                onPressed: () {
                  context.go('/login');
                },
                child: const Text("Get Started", style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ],
      );
  }
}


// RIGHT SIDE (IMAGE + FLOATING CARDS)
Widget rightSection() {
  return Center(
    child: Stack(
      alignment: Alignment.center,
      children: [
        // BACKGROUND CIRCLE
        Container(
          height: 350,
          width: 350,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.greenAccent.withOpacity(0.2),
          ),
        ),

        // IMAGE (ASSET)
        ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: Image.asset(
            "assets/images/student.png",
            height: 300,
            fit: BoxFit.cover,
          ),
        ),

        // LEFT CARD
        Positioned(
          left: 0,
          child: statCard("2K+", "Blog Posts"),
        ),

        // TOP RIGHT
        Positioned(
          top: 20,
          right: 0,
          child: statCard("5K+", "Readers"),
        ),

        // BOTTOM RIGHT
        Positioned(
          bottom: 20,
          right: 0,
          child: statCard("250+", "Authors"),
        ),
      ],
    ),
  );
}

// CARD WIDGET
Widget statCard(String title, String subtitle) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 10,
        )
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(color: Colors.black54),
        ),
      ],
    ),
  );
}

