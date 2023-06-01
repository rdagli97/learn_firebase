import 'package:chatting_app/consts/colors.dart';
import 'package:flutter/material.dart';

class EditTextfield extends StatelessWidget {
  final String hintText;
  final Function(String)? onChanged;
  const EditTextfield({
    super.key,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      style: const TextStyle(color: AllColors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AllColors.grey,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
