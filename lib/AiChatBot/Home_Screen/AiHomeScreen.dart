import 'dart:ui';
import 'package:blog_with_ai_chatbot/AiChatBot/data/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AiHomeScreen extends StatefulWidget {
  const AiHomeScreen({super.key});

  @override
  State<AiHomeScreen> createState() => _AiHomeScreenState();
}

class _AiHomeScreenState extends State<AiHomeScreen> {

  final TextEditingController msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    //get chat provider
    final provider = Provider.of<ChatProvider>(context);

    //main root of screen
    return Scaffold(


      //body start with safe area
      body: SafeArea(
        child: Stack(
          children: [

            // ── Background Image ──
            SizedBox.expand(
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),

            // BACKGROUND

            Positioned(
              top: -100,
              right: -60,

              child: _blurCircle(
                size: 260,
                color: Colors.pink.withOpacity(0.35),
              ),
            ),

            Positioned(
              bottom: -80,
              left: -80,

              child: _blurCircle(
                size: 220,
                color: Colors.pink.withOpacity(0.25),
              ),
            ),

            // MAIN CHAT

            Column(
              children: [

                // TOP BAR

                Padding(
                  padding: const EdgeInsets.all(16),

                  child: Row(
                    children: [

                      //back Button
                      IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_outlined)
                      ),

                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.pinkAccent,

                        child: const Icon(
                          Icons.smart_toy,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(width: 12),

                      const Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          //Text with gemini version name
                          Text(
                            "AI Assistant (Gemini-3-Flash)",

                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 3),

                          //status text
                          Text(
                            "Online",

                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //current day text
                const Text(
                  "Today",

                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 10),

                //  MESSAGES

                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {

                      return ListView.builder(

                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),

                        itemCount: provider.messages.length +
                            (provider.isLoading ? 1 : 0),

                        itemBuilder: (context, index) {

                          // LOADING

                          if (provider.isLoading &&
                              index == provider.messages.length) {

                            return Align(
                              alignment: Alignment.centerLeft,

                              child: Container(

                                margin: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),

                                padding: const EdgeInsets.all(14),

                                decoration: BoxDecoration(
                                  color: Colors.white,

                                  borderRadius:
                                  BorderRadius.circular(22),

                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                      Colors.black.withOpacity(0.05),

                                      blurRadius: 10,

                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),

                                //AI response before msg loading
                                child: SizedBox(
                                  height: 20,
                                  width: 20,

                                  child: Lottie.asset('assets/loading/loading.json'),
                                ),
                              ),
                            );
                          }

                          // MESSAGE

                          final msg = provider.messages[index];

                          return Align(

                            alignment: msg.isUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,

                            child: Container(

                              constraints: BoxConstraints(
                                maxWidth: constraints.maxWidth * 0.72,
                              ),

                              margin: const EdgeInsets.symmetric(
                                vertical: 8,
                              ),

                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),

                              decoration: BoxDecoration(

                                color: msg.isUser
                                    ? Colors.pinkAccent
                                    : Colors.white,

                                borderRadius: BorderRadius.only(

                                  topLeft: const Radius.circular(22),

                                  topRight: const Radius.circular(22),

                                  bottomLeft:
                                  Radius.circular(msg.isUser ? 22 : 6),

                                  bottomRight:
                                  Radius.circular(msg.isUser ? 6 : 22),
                                ),

                                boxShadow: [

                                  BoxShadow(
                                    color:
                                    Colors.black.withOpacity(0.05),

                                    blurRadius: 10,

                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),

                              //user text msg
                              child: Text(
                                msg.text,

                                style: TextStyle(
                                  fontSize: 16,

                                  color: msg.isUser
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                // INPUT FIELD

                Padding(
                  padding: const EdgeInsets.all(16),

                  child: Row(
                    children: [

                      Expanded(
                        child: ClipRRect(

                          borderRadius:
                          BorderRadius.circular(30),

                          child: BackdropFilter(

                            filter: ImageFilter.blur(
                              sigmaX: 8,
                              sigmaY: 8,
                            ),

                            child: Container(

                              padding:
                              const EdgeInsets.symmetric(
                                horizontal: 18,
                              ),

                              decoration: BoxDecoration(
                                color: Colors.white
                                    .withOpacity(0.6),

                                borderRadius:
                                BorderRadius.circular(30),
                              ),

                              child: TextField(

                                controller: msgController,

                                decoration:
                                const InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                  "Type message...",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // SEND BUTTON

                      InkWell(

                        onTap: () {

                          if (msgController.text.trim().isNotEmpty) {

                            provider.sendMessage(msgController.text.trim(),
                            );

                            msgController.clear();
                          }
                        },

                        child: Container(

                          height: 55,
                          width: 55,

                          decoration: BoxDecoration(
                            color: Colors.pinkAccent,

                            borderRadius:
                            BorderRadius.circular(18),
                          ),

                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Extra widgets


  // BLUR CIRCLE

  Widget _blurCircle({
    required double size,
    required Color color,
  }) {

    return ClipOval(

      child: BackdropFilter(

        filter: ImageFilter.blur(
          sigmaX: 100,
          sigmaY: 100,
        ),

        child: Container(

          width: size,
          height: size,

          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ),
    );
  }
}