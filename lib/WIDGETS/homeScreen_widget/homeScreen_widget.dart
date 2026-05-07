import 'package:blog_with_ai_chatbot/data/model/Blog_mddel.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
 final BlogModel blog;

  const BlogCard({
    super.key, required this.blog,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.withOpacity(0.3),
            Colors.black.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Spacer(),

          // TITLE
          Text(
            blog.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          // AUTHOR + TIME
          Text(
            "${blog.des} • ${blog.createAt}",
          ),
        ],
      ),
    );
  }
}