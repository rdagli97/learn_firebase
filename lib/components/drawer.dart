import 'package:chatting_app/components/my_list_tile.dart';
import 'package:chatting_app/consts/colors.dart';
import 'package:chatting_app/consts/strings.dart';
import 'package:chatting_app/utils/add_space.dart';
import 'package:chatting_app/utils/navigate_skills.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final Function()? onProfileTap;
  final Function()? onLogOutTap;
  const MyDrawer({
    super.key,
    required this.onLogOutTap,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AllColors.greyS900,
      child: Column(
        children: [
          // header
          const DrawerHeader(
            child: Icon(
              Icons.person,
              color: AllColors.white,
              size: 64,
            ),
          ),
          // home list tile
          MyListTile(
            icon: Icons.home,
            text: AllStrings.home,
            onTap: () => NavigateSkills().pop(context),
          ),
          // profile list tile
          MyListTile(
            icon: Icons.person,
            text: AllStrings.profile,
            onTap: onProfileTap,
          ),
          const Spacer(),
          // logout list tile
          MyListTile(
            icon: Icons.logout,
            text: AllStrings.logOut,
            onTap: onLogOutTap,
          ),
          AddSpace().addVerticalSpace(25),
        ],
      ),
    );
  }
}
