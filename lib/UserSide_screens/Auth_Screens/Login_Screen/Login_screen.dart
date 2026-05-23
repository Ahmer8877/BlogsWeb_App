
import 'package:flutter/material.dart';
import '../../../WIDGETS/loginScreen_widget/login_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

            //set constraints
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
                      // loginForm widget wrap with expanded
                      Expanded(child: loginForm(context)),
                      // rightImage idget wrap with expanded
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

