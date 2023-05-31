import 'package:flutter/material.dart';

class NavigateSkills {
  void pushTo(BuildContext context, Widget widget) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  void pushReplacementTo(BuildContext context, Widget widget) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
