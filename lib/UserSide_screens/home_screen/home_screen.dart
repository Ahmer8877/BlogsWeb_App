import 'package:blog_with_ai_chatbot/WIDGETS/homeScreen_widget/homeScreen_widget.dart';
import 'package:blog_with_ai_chatbot/data/model/Blog_mddel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  FirebaseFirestore db=FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4ECE6),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            // 🔝 TOP BAR
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.auto_awesome, color: Colors.greenAccent),
                    SizedBox(width: 8),
                    Text(
                      "MirBlogs",
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                OutlinedButton(
                  onPressed: () {
                    context.goNamed('addBlog');
                  },
                  child: const Text(
                    "+ Write Post",
                  ),
                )
              ],
            ),

            const SizedBox(height: 30),

            // 🔥 TITLE
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Latest Articles",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔥 STREAM BUILDER GRID
            Expanded(
              child: StreamBuilder(
                stream:db.collection('Blogs').where('status',isEqualTo: 'approved').snapshots(),

                builder: (context, snapshot){

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Blogs Found",
                      ));
                  }

                  List<BlogModel>? blogs=snapshot.data?.docs.map((e)=>BlogModel.fromMap(e.data())).toList();
                  return ListView(
                    children: blogs!.map((e){
                      return BlogCard(blog: e,);
                    }).toList(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}