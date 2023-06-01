import 'package:chatting_app/components/custom_text.dart';
import 'package:chatting_app/consts/colors.dart';
import 'package:chatting_app/consts/padding_values.dart';
import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function()? onTap;
  const MyListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingValues.onlyLeft10,
      child: ListTile(
        leading: Icon(
          icon,
          color: AllColors.white,
        ),
        onTap: onTap,
        title: CustomText(
          text: text,
        ),
      ),
    );
  }
}
