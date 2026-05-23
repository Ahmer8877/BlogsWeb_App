import 'package:flutter/material.dart';
import '../../../WIDGETS/loginScreen_widget/login_widgets.dart';
import '../../../WIDGETS/signUp_widget/signUp_widget.dart' hide rightImage;

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
          LayoutBuilder(
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
                      // form widget wrap with expanded
                      Expanded(child: form(context)),
                      // rightImage widget wrap with expanded
                      Expanded(child: rightImage()),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
