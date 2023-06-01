import 'package:chatting_app/components/custom_button.dart';
import 'package:chatting_app/components/custom_text.dart';
import 'package:chatting_app/components/custom_textfield.dart';
import 'package:chatting_app/consts/colors.dart';
import 'package:chatting_app/consts/padding_values.dart';
import 'package:chatting_app/consts/strings.dart';
import 'package:chatting_app/utils/add_space.dart';
import 'package:chatting_app/utils/display_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final Function()? onTap;
  const RegisterScreen({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // textediting controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassowrdController =
      TextEditingController();

  final _firebaseAuth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPassowrdController.dispose();
    super.dispose();
  }

  // sign up user
  void signUp() async {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPassowrdController.text.isNotEmpty) {
      if (passwordController.text != confirmPassowrdController.text) {
        displayMessage(context, "Passwords didn't match");
      } else {
        try {
          // create the user
          UserCredential userCredential =
              await _firebaseAuth.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

          // create new doc in cloud firestore called users
          FirebaseFirestore.instance
              .collection("users")
              .doc(userCredential.user!.email)
              .set(
            {
              "userName": emailController.text.split('@')[0],
              "bio": "empty bio",
            },
          );
        } on FirebaseAuthException catch (e) {
          if (e.code.contains("invalid-email")) {
            displayMessage(context, "The email adress is badly formatted");
          }
          if (e.code.contains("weak-password")) {
            displayMessage(context, "Password should be at least 6 characters");
          } else {
            if (e.code.isEmpty) {
              displayMessage(context, "Sign up success");
            } else {
              displayMessage(context, e.code);
            }
          }
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
                  // lets create an account for you
                  const CustomText(
                    text: AllStrings.letsCreateAccountForYou,
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
                  // confirm password textfield
                  CustomTextfield(
                    obscureText: true,
                    controller: confirmPassowrdController,
                    hintText: AllStrings.confirmPassowrd,
                  ),
                  AddSpace().addVerticalSpace(10),
                  // sign up button
                  CustomButton(
                    onTap: signUp,
                    text: AllStrings.signUp,
                  ),
                  AddSpace().addVerticalSpace(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // are u a member?
                      const CustomText(
                        text: AllStrings.areUAMember,
                        color: AllColors.textColor,
                      ),
                      AddSpace().addHorizontalSpace(4),
                      // Login now
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const CustomText(
                          text: AllStrings.logInNow,
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
