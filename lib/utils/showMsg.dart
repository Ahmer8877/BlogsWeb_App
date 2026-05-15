import 'package:blog_with_ai_chatbot/main.dart';
import 'package:flutter/material.dart';


//showSuccessMsg in snack bar Func..
  void showSuccessMsg(String? msg){

    scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(content: Text(msg!),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.green,
    ));
  }

//showFailureMsg in snack bar Func..

void showFailureMsg(String? msg){

    scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(content: Text(msg!),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
    ));
  }