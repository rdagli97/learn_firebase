import 'package:chatting_app/components/custom_text.dart';
import 'package:chatting_app/consts/border_radius_values.dart';
import 'package:chatting_app/consts/colors.dart';
import 'package:chatting_app/consts/padding_values.dart';
import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final Function()? onPressed;
  const CustomTextBox({
    super.key,
    required this.sectionName,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PaddingValues.onlyLeftBottom15,
      margin: PaddingValues.withoutBottomAll20,
      decoration: BoxDecoration(
        color: AllColors.greyS200,
        borderRadius: BorderRadiusValues.circular8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // section name
              CustomText(
                text: sectionName,
                color: AllColors.greyS700,
              ),

              // edit button
              IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.settings,
                  color: AllColors.greyS700,
                ),
              ),
            ],
          ),

          // text
          CustomText(
            text: text,
            color: AllColors.black,
          ),
        ],
      ),
    );
  }
}
