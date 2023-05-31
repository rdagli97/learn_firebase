import 'package:chatting_app/components/custom_text.dart';
import 'package:flutter/material.dart';

void displayMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: CustomText(text: message),
    ),
  );
}
