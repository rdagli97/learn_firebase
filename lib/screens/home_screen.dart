import 'package:chatting_app/components/chat_posts.dart';
import 'package:chatting_app/components/custom_text.dart';
import 'package:chatting_app/components/custom_textfield.dart';
import 'package:chatting_app/components/drawer.dart';
import 'package:chatting_app/consts/colors.dart';
import 'package:chatting_app/consts/padding_values.dart';
import 'package:chatting_app/consts/strings.dart';
import 'package:chatting_app/utils/navigate_skills.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  final _firebaseAuth = FirebaseAuth.instance;
  final _currentUser = FirebaseAuth.instance.currentUser!;
  final _firebaseFirestore = FirebaseFirestore.instance;

  void signOut() {
    _firebaseAuth.signOut();
  }

  // post messages
  void postMessage() {
    // only post if there is something in textfield
    if (textController.text.isNotEmpty) {
      _firebaseFirestore.collection("userPosts").add(
        {
          "email": _currentUser.email,
          "message": textController.text,
          "timeStamp": Timestamp.now(),
          "likes": [],
        },
      );
      textController.clear();
    }
  }

  // navigate to profile page
  void goToProfilePage(BuildContext context) {
    // pop drawer menu
    NavigateSkills().pop(context);

    // go to ProfileScreen
    NavigateSkills().pushTo(
      context,
      const ProfileScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(
        onProfileTap: () => goToProfilePage(context),
        onLogOutTap: signOut,
      ),
      appBar: AppBar(
        title: const CustomText(text: AllStrings.chattingApp),
      ),
      body: Column(
        children: [
          // chat posts
          Expanded(
            child: StreamBuilder(
              stream: _firebaseFirestore
                  .collection("userPosts")
                  .orderBy("timeStamp", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      // get the messages
                      final post = snapshot.data!.docs[index];
                      return ChatPosts(
                        userEmail: post["email"],
                        message: post["message"],
                        postId: post.id,
                        likes: List<String>.from(post["likes"] ?? []),
                      );
                    },
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
          ),
          // post messages
          Padding(
            padding: PaddingValues.all25,
            child: Row(
              children: [
                // message textfield
                Expanded(
                  child: CustomTextfield(
                    controller: textController,
                    hintText: "Write something to send",
                  ),
                ),
                // icon button
                IconButton(
                  onPressed: postMessage,
                  icon: const Icon(
                    Icons.arrow_circle_up_rounded,
                  ),
                ),
              ],
            ),
          ),
          CustomText(
            text: "Loggen in by : ${_currentUser.email!}",
            color: AllColors.black,
          ),
        ],
      ),
    );
  }
}
