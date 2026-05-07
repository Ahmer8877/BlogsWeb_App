import 'package:blog_with_ai_chatbot/UserSide_screens/home_screen/home_screen.dart';
import 'package:blog_with_ai_chatbot/data/model/Blog_mddel.dart';
import 'package:blog_with_ai_chatbot/data/model/user_model.dart';
import 'package:blog_with_ai_chatbot/main.dart';
import 'package:blog_with_ai_chatbot/utils/showMsg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthProviders with ChangeNotifier{

FirebaseAuth auth=FirebaseAuth.instance;
FirebaseFirestore db=FirebaseFirestore.instance;
bool isLoading=false;

//signUp function

void signUpFunction(String name,String email,String password,BuildContext context)async{

  try{
    isLoading=true;
    notifyListeners();
    final result=await auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
    UserModel user=UserModel(result.user?.uid, name, email);

    await db.collection('BlogUsers').doc(result.user?.uid).set(user.toMap());
    if(context.mounted){
      context.go('/login');
    }
    showSuccessMsg('Register Successful,login now');

  }on FirebaseAuthException catch(f){
    showFailureMsg(f.toString());
  }
  catch(e){
    showFailureMsg(e.toString());
  }finally{
    isLoading=false;
    notifyListeners();
  }
}

//login function

void loginFunction(String email,String password,BuildContext context)async{

  try{
    isLoading=true;
    notifyListeners();
    await auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());

    if(context.mounted){
      context.go('/home');
    }
    showSuccessMsg('Login Successful');

  }on FirebaseAuthException catch(f){
    showFailureMsg(f.toString());
  }
  catch(e){
    showFailureMsg(e.toString());
  }finally{
    isLoading=false;
    notifyListeners();
  }
}

//logOut function

Future<void> logOut()async{

  await auth.signOut();
  Navigator.pushAndRemoveUntil(scaffoldMessengerKey.currentContext!,
      MaterialPageRoute(builder: (_)=>HomeScreen()), (value)=>false
  );
}

//add blog provider

  Future<void> addBlog({
    required String title,
    required String description,
    required BuildContext context,
  }) async {

    if (title.trim().isEmpty || description.trim().isEmpty) {
      showFailureMsg("Title and Description required");
      return;
    }

    final user = auth.currentUser;

    if (user == null) {
      showFailureMsg("User not logged in");
      return;
    }

    final now = DateTime.now();
    final id = now.millisecondsSinceEpoch.toString();

    try {
      isLoading = true;
      notifyListeners();

      final blog = BlogModel(
        id,
        user.uid,
        title.trim(),
        description.trim(),
        'approved',
        now,
      );

      await db.collection('Blogs').doc(id).set(blog.toMap());

      // ✅ Success message
      showSuccessMsg("Blog Published Successfully");

      // ✅ Screen close
      if (context.mounted) {
        Navigator.pop(context);
      }

    } on FirebaseException catch (e) {
      showFailureMsg(e.message ?? "Database error");

    } catch (e) {
      showFailureMsg("Something went wrong");

    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}