import 'package:blog_with_ai_chatbot/data/Providers/mainLoading_provider/main_Loading_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../WIDGETS/MainScreen_widget/left,right,statCard_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {

    return Consumer<MainLoadingProvider>(
      builder: (context,provider,child) {
        return Skeletonizer(
          enabled:provider.isLoading ,
          child: Scaffold(
            backgroundColor: const Color(0xFFF4ECE6),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // LOGO
                  Row(
                    children: const [
                      Icon(Icons.auto_awesome, color: Colors.greenAccent),
                      SizedBox(width: 8),
                      Text(
                        "Mir_Blogs",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // MAIN CONTENT
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        bool isMobile = constraints.maxWidth < 900;

                        return isMobile
                            ? SingleChildScrollView(
                          child: Column(
                            children: [
                              leftContent(),
                              const SizedBox(height: 40),
                              rightSection(),
                            ],
                          ),
                        )
                            : Row(
                          children: [
                            Expanded(flex: 2, child: leftContent()),
                            Expanded(flex: 2, child: rightSection()),
                          ],
                        );
                      },
                    ),
                  ),

                  //caution text

                  Center(child: Text(' CAUTION: If you are new user or read Blogs to click GET STARTED')
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}