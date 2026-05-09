import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/Providers/auth_providers/auth_providers.dart';

class ForgetForm extends StatefulWidget {
  const ForgetForm( {super.key});

  @override
  State<ForgetForm> createState() => _ForgetFormState();
}

class _ForgetFormState extends State<ForgetForm> {

  final TextEditingController emailController =
  TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 40,
      ),

      child: Form(
        key: formKey,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Forget Password!!",

              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 30),

            TextFormField(
              controller: emailController,

              validator: (value) {

                if(value == null || value.isEmpty){
                  return "Please enter email";
                }

                return null;
              },

              decoration: InputDecoration(
                hintText: "email@gmail.com",

                prefixIcon: const Icon(
                  Icons.email_outlined,
                ),

                filled: true,
                fillColor: Colors.white,

                contentPadding:
                const EdgeInsets.symmetric(
                  vertical: 18,
                ),

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(30),

                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: Consumer<AuthProviders>(
                builder: (context, provider, child) {

                  if(provider.isLoading){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFFDDBEA9),

                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(30),
                      ),
                    ),

                    onPressed: () async {

                      if(formKey.currentState!.validate()){

                        await provider.forget(
                          emailController.text.trim(),
                        );

                        emailController.clear();
                      }
                    },

                    child: const Text(
                      "Reset Now",

                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class RightImage extends StatelessWidget {
  const RightImage({super.key});

  @override
  Widget build(BuildContext context) {

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

              borderRadius:
              BorderRadius.circular(150),
            ),
          ),

          Image.asset(
            "assets/images/login.jpg",
            height: 300,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}