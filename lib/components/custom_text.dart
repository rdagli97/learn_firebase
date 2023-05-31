// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chatting_app/consts/colors.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextAlign? textAlign;
  const CustomText({
    super.key,
    required this.text,
    this.color = AllColors.white,
    this.fontStyle,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
