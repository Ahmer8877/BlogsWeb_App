import 'package:blog_with_ai_chatbot/AiChatBot/data/provider/chat_provider.dart';
import 'package:blog_with_ai_chatbot/data/Providers/auth_providers/auth_providers.dart';
import 'package:blog_with_ai_chatbot/utils/go_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

//scaffoldMessengerKey for global use
final scaffoldMessengerKey=GlobalKey<ScaffoldMessengerState>();

//main func.
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //without hash url strategy
  usePathUrlStrategy();

  runApp(const BlogWeb());
}

class BlogWeb extends StatelessWidget {
  const BlogWeb({super.key});

  @override
  Widget build(BuildContext context) {
    //multi providers
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=> AuthProviders()),
          ChangeNotifierProvider(create: (context)=> ChatProvider()),
        ],

      // Material app with routers
      child:  MaterialApp.router(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: scaffoldMessengerKey,
        routerConfig: GoRoutes.routes(),
      ),
    );
  }
}
