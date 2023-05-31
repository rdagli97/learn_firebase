import 'package:chatting_app/components/custom_text.dart';
import 'package:chatting_app/consts/border_radius_values.dart';
import 'package:chatting_app/consts/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: AllColors.black,
          borderRadius: BorderRadiusValues.circular8,
        ),
        child: Center(
          child: CustomText(
            text: text,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
