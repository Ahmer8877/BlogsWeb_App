import 'package:blog_with_ai_chatbot/WIDGETS/myBlogs_widget/myBlog_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../data/model/Blog_mddel.dart';

class MyBlogsScreen extends StatefulWidget {
  const MyBlogsScreen({super.key});

  @override
  State<MyBlogsScreen> createState() => _MyBlogsScreenState();
}

class _MyBlogsScreenState extends State<MyBlogsScreen> {

  //initialize firebase firestore databse
  FirebaseFirestore db=FirebaseFirestore.instance;
  //initialize firebase auth
  FirebaseAuth auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //main root of screen
    return Scaffold(

        body: Stack(
          children: [

            // ── Background Image ──
            SizedBox.expand(
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),

                  child: Column(
                    children: [

                      //TOP BAR
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                        children: [

                      // LOGO
                      Row(
                      children: const [

                      Icon(
                      Icons.auto_awesome,
                        color: Colors.greenAccent,
                      ),

                      SizedBox(width: 8),

                      //App name
                      Text(
                        "Mir_Blogs",

                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                        ]
                  ),
                      const SizedBox(height: 35),

                      // TITLE
                      const Align(
                        alignment: Alignment.centerLeft,

                        child: Text(
                          "My Articles",

                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),

                      //set constraints
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {

                            int crossAxisCount = 1;

                            if (constraints.maxWidth > 1200) {
                              crossAxisCount = 4;
                            } else if (constraints.maxWidth > 900) {
                              crossAxisCount = 3;
                            } else if (constraints.maxWidth > 600) {
                              crossAxisCount = 2;
                            } else {
                              crossAxisCount = 1;
                            }

                            return StreamBuilder(
                              stream: db.collection('Blogs').where('userId',isEqualTo: auth.currentUser?.uid).snapshots(),
                              builder: (context,snapshot) {

                                // LOADING
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return const Center(child: CircularProgressIndicator(),
                                  );
                                }

                                // EMPTY
                                if(!snapshot.hasData || snapshot.data!.docs.isEmpty){

                                  return const Center(
                                    child: Text(
                                      "No Blogs Found",

                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  );
                                }

                                // DATA
                                final blogs = snapshot.data!.docs
                                    .map((e) => BlogModel.fromMap(
                                  e.data(),
                                ))
                                    .toList();
                                return GridView.builder(
                                  padding: const EdgeInsets.all(20),

                                  itemCount: blogs.length,

                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 1.2,
                                  ),

                                  itemBuilder: (context, index) {

                                    final blog = blogs[index];

                                    //MyBlogWid widgets
                                    return MyBlogWid(
                                      blog: blog,
                                    );
                                  },
                                );
                              }
                            );
                          },
                        ),
                      )
                    ]
                  )
                )
            ),
          ],
        )
    );
  }
}


