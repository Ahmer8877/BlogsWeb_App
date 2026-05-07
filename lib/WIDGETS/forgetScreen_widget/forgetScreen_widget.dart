
// ================= LEFT FORM =================
import 'package:flutter/material.dart';

Widget forgetForm(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
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

        // EMAIL
        inputField(
          hint: "email@gmail.com",
          icon: Icons.email_outlined,
        ),

        const SizedBox(height: 25),

        // LOGIN BUTTON
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDDBEA9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "Reset Now",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    ),
  );
}

// ================= INPUT FIELD =================
Widget inputField({
  required String hint,
  required IconData icon,
  bool isPassword = false,
}) {
  return TextField(
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

// ================= RIGHT IMAGE =================
Widget rightImage() {
  return Padding(
    padding: const EdgeInsets.all(40),
    child: Stack(
      alignment: Alignment.center,
      children: [
        // BACKGROUND SHAPE
        Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            color: const Color(0xFFDDBEA9),
            borderRadius: BorderRadius.circular(150),
          ),
        ),

        // IMAGE (ASSET)
        Image.asset(
          "assets/images/login.jpg",
          height: 300,
          fit: BoxFit.cover,
        ),
      ],
    ),
  );
}