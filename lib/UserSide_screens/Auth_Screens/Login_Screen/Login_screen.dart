
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
                    loginForm(context),
                    const SizedBox(height: 30),
                    rightImage(),
                  ],
                ),
              )
                  : Row(
                children: [
                  Expanded(child: loginForm(context)),
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

