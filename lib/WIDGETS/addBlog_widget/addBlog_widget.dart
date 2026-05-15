import 'package:flutter/material.dart';

//  reusable inputFieldForAddBlog wdget

Widget inputFieldForAddBlog({
  required TextEditingController controller,
  required String hint,
}) {
  return Card(
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white10,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}