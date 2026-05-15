import 'package:blog_with_ai_chatbot/UserSide_screens/Main_Screen/Main_Screen.dart';
import 'package:blog_with_ai_chatbot/data/model/Blog_mddel.dart';
import 'package:blog_with_ai_chatbot/data/model/user_model.dart';
import 'package:blog_with_ai_chatbot/utils/showMsg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';


//All auth providers class

class AuthProviders with ChangeNotifier{

  //firebase auth  initialize
FirebaseAuth auth=FirebaseAuth.instance;
//firebase Firestore  initialize
FirebaseFirestore db=FirebaseFirestore.instance;
  //firebase GoogleAuth  initialize
GoogleSignIn googleSignIn=GoogleSignIn.instance;
//loading vari..
bool isLoading=false;

//signUp function

void signUpFunction(String name,String email,String password,BuildContext context)async{

  try{
    isLoading=true;
    safeNotify();
    final result=await auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());

    //firestore database
    UserModel user=UserModel(result.user?.uid, name, email,password);
    await db.collection('BlogUsers').doc(result.user?.uid).set(user.toMap());

    //next screen permute
    if(context.mounted){
      WidgetsBinding.instance.addPostFrameCallback((_){
        context.go('/login');
      });

    }
    showSuccessMsg('Register Successful,login now');

  }on FirebaseAuthException catch(f){
    showFailureMsg(f.toString());
  }
  catch(e){
    showFailureMsg(e.toString());
  }finally{
    isLoading=false;
    safeNotify();
  }
}

//login function

void loginFunction(String email,String password,BuildContext context)async{

  try{
    isLoading=true;
    safeNotify();

    //firebase sign in
    await auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());

    //next screen permute
    if(context.mounted){
      WidgetsBinding.instance.addPostFrameCallback((_){
        context.go('/home');

      });    }
    showSuccessMsg('Login Successful');

  }on FirebaseAuthException catch(f){
    showFailureMsg(f.toString());
  }
  catch(e){
    showFailureMsg(e.toString());
  }finally{
    isLoading=false;
    safeNotify();
  }
}

//logOut function

Future<void> logOut(BuildContext context)async{

  //firebase logout
  await auth.signOut();

  //next screen permute
  if(context.mounted){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>MainScreen()), (value)=>false);
  }
}

//forget password function

  Future<void> forget(String email)async{

  try{
    isLoading=true;
    safeNotify();

    //firebase through reset password
    await auth.sendPasswordResetEmail(email: email.trim());

    showSuccessMsg('Check your email Now');

  }on FirebaseAuthException catch(f){
    showFailureMsg(f.toString());
  }catch(e){
    showFailureMsg(e.toString());
  }finally{
    isLoading=false;
    safeNotify();
  }
  }

//Add blog Func..

  Future<void> addBlog({
    required String title,
    required String description,
    required String author,
    required BuildContext context,
  }) async {

  //If Empty
    if (title.trim().isEmpty || description.trim().isEmpty || author.trim().isEmpty) {
      showFailureMsg("Title, Author and Description required");
      return;
    }

    //for current user
    final user = auth.currentUser;

    if (user == null) {
      showFailureMsg("User not logged in");
      return;
    }

    //get date time
    final now = DateTime.now();
    //get id with millisecondsSinceEpoch
    final id = now.millisecondsSinceEpoch.toString();

    try {
      isLoading = true;
      safeNotify();

      //add blog Model
      final blog = BlogModel(
        id,
        user.uid,
        title.trim(),
        description.trim(),
        'pending',
        now,
        author.trim()
      );

      //firestore database
      await db.collection('Blogs').doc(id).set(blog.toMap());

      //  Success message
      showSuccessMsg("Saved To MyBlog => Wait to Admin Confirmation");

      //  Screen close
      if (context.mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_){
          Navigator.pop(context);

        });
      }

    } on FirebaseException catch (e) {
      showFailureMsg(e.message ?? "Database error");

    } catch (e) {
      showFailureMsg("Something went wrong");

    } finally {
      isLoading = false;
      safeNotify();
    }
  }

  //google sign In function

  Future<void> googleSignInFunction(BuildContext context) async {


    try {

      isLoading = true;
      safeNotify();

      // WEB
      if (kIsWeb) {

        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        await auth.signInWithPopup(googleProvider);

      }

      // ANDROID / IOS
      else {

        final GoogleSignInAccount googleUser =
        await googleSignIn.authenticate();

        final GoogleSignInAuthentication googleAuth =
            googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );

        await auth.signInWithCredential(credential);
      }

      // SUCCESS

      if (context.mounted) {
        context.go('/home');
      }

      showSuccessMsg("Google Sign In Successful");

    }

    // FIREBASE ERROR

    on FirebaseAuthException catch (e) {

      showFailureMsg(
        e.message ?? "Authentication Failed",
      );
    }

    // OTHER ERROR

    catch (e) {

      showFailureMsg(e.toString());
    }

    //  FINALLY

    finally {

      isLoading = false;
      safeNotify();
    }
  }

  //safe notifier func

  void safeNotify() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}