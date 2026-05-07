import 'package:flutter/material.dart';

import '../../../WIDGETS/forgetScreen_widget/forgetScreen_widget.dart';
import '../../../WIDGETS/loginScreen_widget/login_widgets.dart' hide rightImage;

class ForgetScreen extends StatelessWidget {
  const ForgetScreen({super.key});

  @override
  Widget build(BuildContext context) {

    //main root of screen
    return  Scaffold(
      backgroundColor: const Color(0xFFF4ECE6),
      //app bar
      appBar: AppBar(
        backgroundColor: Color(0xFFF4ECE6),
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 900;

          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: isMobile
                  ? SingleChildScrollView(
                child: Column(
                  children: [
                    loginForm(context),
                    const SizedBox(height: 30),
                    rightImage(),
                  ],
                ),
              )
                  : Row(
                children: [
                  Expanded(child: forgetForm(context)),
                  Expanded(child: rightImage()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
