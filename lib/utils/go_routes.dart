import 'package:blog_with_ai_chatbot/UserSide_screens/Auth_Screens/Login_Screen/Login_screen.dart';
import 'package:blog_with_ai_chatbot/UserSide_screens/Auth_Screens/SignUp_Screen/SignUp_Screen.dart';
import 'package:blog_with_ai_chatbot/UserSide_screens/Auth_Screens/forget_Screen/forget_screen.dart';
import 'package:blog_with_ai_chatbot/UserSide_screens/Main_Screen/Main_Screen.dart';
import 'package:blog_with_ai_chatbot/UserSide_screens/addBlog_screen/addBlog_screen.dart';
import 'package:blog_with_ai_chatbot/UserSide_screens/home_screen/home_screen.dart';
import 'package:blog_with_ai_chatbot/UserSide_screens/splash_screen/splash_Screen.dart';
import 'package:go_router/go_router.dart';

class GoRoutes {


 static GoRouter routes() => GoRouter(
      routes: [
        GoRoute(path: '/',builder: (context,state)=> SplashScreen()
        ),
        GoRoute(path: '/main',builder: (context,state)=> MainScreen()),
        GoRoute(path: '/login',builder: (context,state)=> LoginScreen(),
            // login routes
            routes: [
          GoRoute(path: '/forget',name: 'forget',builder: (context,state)=> ForgetScreen()),
        ]),
        GoRoute(path: '/signUp',builder: (context,state)=> SignupScreen()),
        GoRoute(path: '/home',builder: (context,state)=> HomeScreen(),
            routes: [
              GoRoute(path: '/addBlog',name: 'addBlog',builder: (context,state)=> AddBlogScreen()),
            ]
        ),
      ],
  );
}