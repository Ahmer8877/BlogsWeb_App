import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //initialize firebase auth
  FirebaseAuth auth=FirebaseAuth.instance;

  //init state
  @override
  void initState() {
    nextScreen();
    super.initState();
  }

  //next screen func..
  void nextScreen()async{
    Future.delayed(const Duration(seconds: 3), () {
      if(!mounted){
        return;
      }
      context.go(auth.currentUser==null? '/main' : '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    //amin root of screen
    return Scaffold(
      backgroundColor: const Color(0xFFF4ECE6),

      //body
      body: Center(child: CircularProgressIndicator(),),
    );
  }
}
