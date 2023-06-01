import 'package:chatting_app/components/custom_text.dart';
import 'package:chatting_app/components/custom_text_box.dart';
import 'package:chatting_app/components/edit_textfield.dart';
import 'package:chatting_app/consts/colors.dart';
import 'package:chatting_app/consts/padding_values.dart';
import 'package:chatting_app/consts/strings.dart';
import 'package:chatting_app/utils/add_space.dart';
import 'package:chatting_app/utils/navigate_skills.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // current user ref
  final _currentUser = FirebaseAuth.instance.currentUser!;
  // all users ref
  final usersCollection = FirebaseFirestore.instance.collection("users");

  // edit field
  Future<void> editFiled(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AllColors.greyS900,
          title: CustomText(
            text: "Edit $field",
          ),
          content: EditTextfield(
            hintText: "Enter New $field",
            onChanged: (value) {
              newValue = value;
            },
          ),
          actions: [
            // cancel button
            TextButton(
              onPressed: () => NavigateSkills().pop(context),
              child: const CustomText(
                text: 'Cancel',
              ),
            ),
            // save button
            TextButton(
              onPressed: () => Navigator.of(context).pop(newValue),
              child: const CustomText(
                text: 'Save',
              ),
            ),
          ],
        );
      },
    );

    // update in firestore with newValue
    if (newValue.trim().isNotEmpty) {
      await usersCollection.doc(_currentUser.email).update(
        {
          field: newValue,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: AllStrings.profilePage,
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(_currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          // get user data
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: [
                AddSpace().addVerticalSpace(50),
                // profile pic
                const Icon(
                  Icons.person,
                  size: 72,
                ),
                AddSpace().addVerticalSpace(10),
                // user email
                CustomText(
                  text: _currentUser.email!,
                  textAlign: TextAlign.center,
                  color: AllColors.greyS700,
                ),
                AddSpace().addVerticalSpace(50),
                // user details
                Padding(
                  padding: PaddingValues.onlyLeft25,
                  child: CustomText(
                    text: AllStrings.profileDetails,
                    color: AllColors.greyS600,
                  ),
                ),
                // username
                CustomTextBox(
                  sectionName: 'User name',
                  text: userData["userName"],
                  onPressed: () => editFiled('userName'),
                ),
                // bio
                CustomTextBox(
                  sectionName: 'Bio',
                  text: userData["bio"],
                  onPressed: () => editFiled('bio'),
                ),
                AddSpace().addVerticalSpace(20),
                // user posts
                Padding(
                  padding: PaddingValues.onlyLeft25,
                  child: CustomText(
                    text: AllStrings.myPosts,
                    color: AllColors.greyS600,
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: CustomText(text: "Error : ${snapshot.error}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
