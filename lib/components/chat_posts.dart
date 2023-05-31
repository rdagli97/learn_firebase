import 'package:chatting_app/components/custom_text.dart';
import 'package:chatting_app/components/liked_button.dart';
import 'package:chatting_app/consts/border_radius_values.dart';
import 'package:chatting_app/consts/colors.dart';
import 'package:chatting_app/consts/padding_values.dart';
import 'package:chatting_app/utils/add_space.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPosts extends StatefulWidget {
  final String userEmail;
  final String message;
  final String postId;
  final List<String> likes;
  const ChatPosts({
    super.key,
    required this.userEmail,
    required this.message,
    required this.likes,
    required this.postId,
  });

  @override
  State<ChatPosts> createState() => _ChatPostsState();
}

class _ChatPostsState extends State<ChatPosts> {
  // user reference
  final _currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    // if there is email in the firebase who liked then isLiked gonna be true
    isLiked = widget.likes.contains(_currentUser.email);
    super.initState();
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    // access the document in firebase
    DocumentReference postRef =
        FirebaseFirestore.instance.collection("userPosts").doc(widget.postId);
    if (isLiked) {
      // if the post is now liked , add the user's email to the 'likes' field
      postRef.update(
        {
          'likes': FieldValue.arrayUnion([_currentUser.email]),
        },
      );
    } else {
      // if the post is now unliked , remove the user's email from the 'likes' field
      postRef.update(
        {
          'likes': FieldValue.arrayRemove([_currentUser.email]),
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: PaddingValues.withoutBottomAll25,
      padding: PaddingValues.all25,
      decoration: BoxDecoration(
        color: AllColors.white,
        borderRadius: BorderRadiusValues.circular8,
      ),
      child: Row(
        children: [
          // profile pic
          Column(
            children: [
              // like button
              LikeButton(
                isLiked: isLiked,
                onTap: toggleLike,
              ),
              AddSpace().addVerticalSpace(5),
              // like count
              CustomText(
                text: widget.likes.length.toString(),
                color: AllColors.grey,
              ),
            ],
          ),
          AddSpace().addHorizontalSpace(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // user email and message
              CustomText(
                text: widget.userEmail,
                color: AllColors.greyS500,
              ),
              AddSpace().addVerticalSpace(10),
              CustomText(
                text: widget.message,
                color: AllColors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
