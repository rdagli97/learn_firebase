import 'package:chatting_app/components/custom_button.dart';
import 'package:chatting_app/components/custom_text.dart';
import 'package:chatting_app/components/custom_textfield.dart';
import 'package:chatting_app/consts/colors.dart';
import 'package:chatting_app/consts/padding_values.dart';
import 'package:chatting_app/consts/strings.dart';
import 'package:chatting_app/utils/add_space.dart';
import 'package:chatting_app/utils/display_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;
  const LoginScreen({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // textediting controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _firebaseAuth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // sign in user
  void signIn() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      try {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code.contains("invalid-email")) {
          displayMessage(context, "Email badly formatted");
        }
        if (e.code.contains("user-not-found")) {
          displayMessage(context, "There is no user with this e mail");
        }
        if (e.code.contains("wrong-password")) {
          displayMessage(context, "Wrong password");
        } else {
          displayMessage(context, "Sign in success");
        }
      }
    } else {
      displayMessage(context, "Fill the blanks");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: PaddingValues.symmetricH25,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // icon
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),
                  AddSpace().addVerticalSpace(50),
                  // you have been missed text
                  const CustomText(
                    text: AllStrings.youHaveBeenMissed,
                    color: AllColors.textColor,
                  ),
                  AddSpace().addVerticalSpace(25),
                  // e mail textfield
                  CustomTextfield(
                    controller: emailController,
                    hintText: AllStrings.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  AddSpace().addVerticalSpace(10),
                  // password textfield
                  CustomTextfield(
                    obscureText: true,
                    controller: passwordController,
                    hintText: AllStrings.password,
                  ),
                  AddSpace().addVerticalSpace(10),
                  // sign in button
                  CustomButton(
                    onTap: signIn,
                    text: AllStrings.signIn,
                  ),
                  AddSpace().addVerticalSpace(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // are u not a member?
                      const CustomText(
                        text: AllStrings.areUNotAMember,
                        color: AllColors.textColor,
                      ),
                      AddSpace().addHorizontalSpace(4),
                      // register now
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const CustomText(
                          text: AllStrings.registerNow,
                          color: AllColors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
