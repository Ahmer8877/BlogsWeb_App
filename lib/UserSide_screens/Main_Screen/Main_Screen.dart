import 'package:flutter/material.dart';
import '../../WIDGETS/MainScreen_widget/left,right,statCard_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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

          Padding(
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
                          // leftContent widget
                          Expanded(flex: 2, child: leftContent()),
                          // rightSection widget
                          Expanded(flex: 2, child: rightSection()),
                        ],
                      );
                    },
                  ),
                ),

                //caution text

                Center(child: Text(' CAUTION: If you are new user or read Blogs to click GET STARTED, Read world-wide Blogs ')
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}