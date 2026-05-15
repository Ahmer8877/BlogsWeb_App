import 'package:flutter/material.dart';
import '../../../WIDGETS/forgetScreen_widget/forgetScreen_widget.dart';

class ForgetScreen extends StatelessWidget {
  const ForgetScreen({super.key});

  @override
  Widget build(BuildContext context) {

    //main root of screen
    return  Scaffold(
      backgroundColor: const Color(0xFFF4ECE6),
      //app bar
      body: LayoutBuilder(
        builder: (context, constraints) {

          bool isMobile = constraints.maxWidth < 900;

          return Center(
            child: Container(

              constraints: const BoxConstraints(
                maxWidth: 1200,
              ),

              child: isMobile

                  ? SingleChildScrollView(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: const [

                    //ForgetForm widget
                    ForgetForm(),

                    SizedBox(height: 30),

                    //RightImage widget
                    RightImage(),
                  ],
                ),
              )

                  : Row(
                children: const [

                  Expanded(
                    child: ForgetForm(),
                  ),

                  Expanded(
                    child: RightImage(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
