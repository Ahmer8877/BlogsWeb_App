import 'package:blog_with_ai_chatbot/AiChatBot/Home_Screen/AiHomeScreen.dart';
import 'package:blog_with_ai_chatbot/UserSide_screens/Auth_Screens/Login_Screen/Login_screen.dart';
import 'package:blog_with_ai_chatbot/UserSide_screens/Auth_Screens/SignUp_Screen/SignUp_Screen.dart';
import 'package:blog_with_ai_chatbot/UserSide_screens/Auth_Screens/forget_Screen/forget_screen.dart';
import 'package:blog_with_ai_chatbot/UserSide_screens/Main_Screen/Main_Screen.dart';
import 'package:blog_with_ai_chatbot/UserSide_screens/addBlog_screen/addBlog_screen.dart';
import 'package:blog_with_ai_chatbot/UserSide_screens/home_screen/home_screen.dart';
import 'package:blog_with_ai_chatbot/UserSide_screens/splash_screen/splash_Screen.dart';
import 'package:go_router/go_router.dart';
import '../UserSide_screens/myBlogs_screen/myBlogs_Screen.dart';

//define all all routes class
class GoRoutes {

//go routers func..
 static GoRouter routes() => GoRouter(
      routes: [
        //splash screen route
        GoRoute(path: '/',builder: (context,state)=> SplashScreen()
        ),
        //main screen route
        GoRoute(path: '/main',builder: (context,state)=> MainScreen()),
        GoRoute(path: '/login',builder: (context,state)=> LoginScreen(),
            // login routes
            routes: [
          GoRoute(path: '/forget',name: 'forget',builder: (context,state)=> ForgetScreen()),
        ]),
        GoRoute(path: '/signUp',builder: (context,state)=> SignupScreen()),
        //home screen route
        GoRoute(path: '/home',builder: (context,state)=> HomeScreen(),
            routes: [
              //home screen routes
              GoRoute(path: '/addBlog',name: 'addBlog',builder: (context,state)=> AddBlogScreen()),
              GoRoute(path: '/myBlog',name: 'myBlog',builder: (context,state)=> MyBlogsScreen()),
              GoRoute(path: '/aiChatBot',name: 'aiChatBot',builder: (context,state)=> AiHomeScreen()),
            ]
        ),
      ],
  );
}