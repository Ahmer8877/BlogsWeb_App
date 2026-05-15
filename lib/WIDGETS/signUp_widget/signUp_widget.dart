import 'package:blog_with_ai_chatbot/data/Providers/auth_providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

//controllers
final name=TextEditingController();
final email=TextEditingController();
final password=TextEditingController();
//form key
final formKey=GlobalKey<FormState>();

// FORM widget

Widget form(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
    child: Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Create Account",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 30),

          // USERNAME
          inputField(
            controller: name,
            hint: "Username",
            icon: Icons.person_outline,
            msg: 'please enter name',
          ),

          const SizedBox(height: 20),

          // EMAIL
          inputField(
            controller: email,
            hint: "email@gmail.com",
            icon: Icons.email_outlined,
            msg: 'please enter email',
          ),

          const SizedBox(height: 20),

          // PASSWORD
          inputField(
            controller: password,
            hint: "Password",
            icon: Icons.lock_outline,
            isPassword: true,
            msg: 'please enter password',
          ),


          const SizedBox(height: 25),

          // SIGNUP BUTTON
          SizedBox(
            width: double.infinity,
            height: 55,
            child: Consumer<AuthProviders>(
              builder: (context,provider,child) {
                return provider.isLoading? Center(child: CircularProgressIndicator(),) :
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color(0xFFDDBEA9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    if(formKey.currentState!.validate()){
                      provider.signUpFunction(name.text.trim(), email.text.trim(), password.text.trim(),context);
                      name.clear();
                      email.clear();
                      password.clear();
                    }
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }
            ),
          ),

          const SizedBox(height: 20),

          const Center(child: Text("- or -")),

          const SizedBox(height: 20),

          // SOCIAL
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                  Provider.of<AuthProviders>(context).isLoading? Center(child: CircularProgressIndicator(),) :InkWell(
                    onTap: (){
                      Provider.of<AuthProviders>(context,listen: false).googleSignInFunction(context);
                    },
                      child: const Icon(Icons.g_mobiledata, size: 30)
                   )
            ],
          ),

          const SizedBox(height: 20),

          // LOGIN LINK
          Center(
            child: InkWell(
              onTap: (){
                context.go('/login');
              },
              child: RichText(
                text: const TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(color: Colors.black54),
                  children: [
                    TextSpan(
                      text: "Login",
                      style: TextStyle(color: Colors.orange),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// INPUT FIELD widget
Widget inputField({
  required String hint,
  required IconData icon,
  bool isPassword = false,
  required TextEditingController controller,
  required String msg
}) {
  return TextFormField(
    validator: (value){
      if(value==null || value.isEmpty){
        return msg;
      }
      return null;

    },
    controller:controller ,
    obscureText: isPassword,
    decoration: InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    ),
  );
}

// RIGHT IMAGE widget
Widget rightImage() {
  return Padding(
    padding: const EdgeInsets.all(40),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            color: const Color(0xFFDDBEA9),
            borderRadius: BorderRadius.circular(150),
          ),
        ),

        //casual asset image
        Image.asset(
          "assets/images/login.jpg",
          height: 300,
        ),
      ],
    ),
  );
}