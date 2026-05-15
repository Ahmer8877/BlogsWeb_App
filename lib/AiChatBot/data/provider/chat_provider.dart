import 'dart:convert';
import 'package:blog_with_ai_chatbot/AiChatBot/data/meaasge_model/measge_model.dart';
import 'package:blog_with_ai_chatbot/utils/showMsg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//Chat side provider
class ChatProvider with ChangeNotifier {

  //base gemini url
  final String geminiBaseUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-3-flash-preview:generateContent';
  //use for loading
  bool isLoading = false;
  //create empty list to get data
  List<MessageModel> messages = [];

  //send msg function
  Future<void> sendMessage(String msg) async {

    // USER MESSAGE

    messages.add(
      MessageModel(msg, true),
    );

    notifyListeners();

    try {

      isLoading = true;
      notifyListeners();

      final result = await http.post(Uri.parse(geminiBaseUrl),

        //api headers
        headers: {

          'Content-Type': 'application/json',

          'x-goog-api-key': 'AIzaSyC1DzRP0pOP9qTXbukaAcFLQrRNSRL3KCg',
        },

        //api data content
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

      //json data decode
      final data = jsonDecode(result.body);

      // DEBUG
      if (kDebugMode) {
        print(data);
      }

      // AI RESPONSE

      String answer =
      data['candidates'][0]['content']['parts'][0]['text'];

      //result add in list
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