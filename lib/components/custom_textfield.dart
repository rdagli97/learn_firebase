import 'package:chatting_app/consts/colors.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  final TextInputType? keyboardType;
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AllColors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AllColors.white,
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AllColors.hintTextColor,
        ),
        filled: true,
        fillColor: AllColors.postAndTFBackgroundColor,
      ),
    );
  }
}
