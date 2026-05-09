import 'package:blog_with_ai_chatbot/WIDGETS/addBlog_widget/addBlog_widget.dart';
import 'package:blog_with_ai_chatbot/data/Providers/auth_providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({super.key});

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {

  final title = TextEditingController();
  final des = TextEditingController();
  final author = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4ECE6),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // 🔥 responsive width
            double maxWidth = constraints.maxWidth > 900 ? 800 : double
                .infinity;

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 30),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // 🔥 TITLE
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "New ",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "Post",
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // author FIELD
                      Form(
                        key: formKey,
                        child: inputFieldForAddBlog(
                          controller: author,
                          hint: "Type Author Name",
                        ),
                      ),

                      // 🔥 TITLE FIELD
                      inputFieldForAddBlog(
                        controller: title,
                        hint: "Post title...",
                      ),
                      const SizedBox(height: 20),

                      // 🔥 CONTENT FIELD
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: TextFormField(
                          controller: des,
                          maxLines: 80,
                          decoration: const InputDecoration(
                            hintText: "Write your blog content here...\n\nYou can use the toolbar above for formatting.",
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // 🔥 BUTTON
                      Align(
                        alignment: Alignment.centerRight,
                        child: Consumer<AuthProviders>(
                          builder: (context,provider,child) {
                            return provider.isLoading? Center(child: CircularProgressIndicator(),): ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                side: const BorderSide(color: Colors.white24),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 14),
                              ),
                              onPressed: () {
                                if(formKey.currentState!.validate()){
                                  provider.addBlog(
                                    title: title.text,
                                    description: des.text,
                                    context: context,
                                    author: author.text,
                                  );
                                }

                              },
                              child: const Text(
                                "Publish Blog →",
                              ),
                            );
                          }
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
