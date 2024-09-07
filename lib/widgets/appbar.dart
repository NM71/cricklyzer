import 'package:cricklyzer/widgets/user_profile_bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {

    User? user = FirebaseAuth.instance.currentUser;

    return AppBar(
      backgroundColor: Color(0xffffffff),
      elevation: 0,
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Cricklyzer-logo-2.png',
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 8),
          const Text(
            textAlign: TextAlign.center,
            'Cricklyzer',
            style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold,),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            child: CircleAvatar(
              radius: 15,
              backgroundImage: user?.photoURL != null
                  ? NetworkImage(user!.photoURL!)
                  : const AssetImage("assets/images/sample1.jpg") as ImageProvider<Object>?,
            ),
            onTap: (){
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return const UserProfileBottomSheet();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
