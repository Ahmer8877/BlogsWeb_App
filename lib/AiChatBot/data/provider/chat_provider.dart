import 'dart:convert';

import 'package:blog_with_ai_chatbot/AiChatBot/data/meaasge_model/measge_model.dart';
import 'package:blog_with_ai_chatbot/utils/showMsg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatProvider with ChangeNotifier {

  final String geminiBaseUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-3-flash-preview:generateContent';
  bool isLoading = false;

  List<MessageModel> messages = [];

  Future<void> sendMessage(String msg) async {

    // USER MESSAGE

    messages.add(
      MessageModel(msg, true),
    );

    notifyListeners();

    try {

      isLoading = true;
      notifyListeners();

      final result = await http.post(

        Uri.parse(geminiBaseUrl),

        headers: {

          'Content-Type': 'application/json',

          'x-goog-api-key': 'AIzaSyAtzdLnok2VUaYSJBL30SfaQOfOKV5TzDs',
        },

        body: jsonEncode({

          "contents": [

            {

              "parts": [

                {
                  "text": msg.trim(),
                }

              ]
            }

          ]
        }),
      );

      final data = jsonDecode(result.body);

      // DEBUG
      print(data);

      // AI RESPONSE

      String answer =
      data['candidates'][0]['content']['parts'][0]['text'];

      messages.add(
        MessageModel(answer, false),
      );

    }

    catch (e) {

      showFailureMsg(e.toString());
    }

    finally {

      isLoading = false;

      notifyListeners();
    }
  }
}