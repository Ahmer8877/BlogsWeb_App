import 'package:flutter/material.dart';
import '../../../WIDGETS/loginScreen_widget/login_widgets.dart';
import '../../../WIDGETS/signUp_widget/signUp_widget.dart' hide rightImage;

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xFFF4ECE6),
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
                    form(context),
                    const SizedBox(height: 30),
                    rightImage(),
                  ],
                ),
              )
                  : Row(
                children: [
                  Expanded(child: form(context)),
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
