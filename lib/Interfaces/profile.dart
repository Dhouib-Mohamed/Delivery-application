import 'package:flutter/material.dart';
import 'package:iac_project/Widgets/parts.dart';
import 'package:iac_project/models.dart';

import '../Widgets/tapped.dart';
// TODO all

class Profile extends StatefulWidget {
  final UserModel user;
  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffbd2005),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
      ),
      bottomNavigationBar: const BotBar(i: 4),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
                "NAME : ${widget.user.name[0].toUpperCase()}${widget.user.name.substring(1)}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "EMAIL : "+widget.user.email,
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "PHONE NUMBER : "+widget.user.phone!,
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            const ProfileButton(
                name: "My Addresses", role: "/address", icon: Icons.location_on),
            const ProfileButton(
                name: "Settings", role: "/settings", icon: Icons.settings_sharp),
            const ProfileButton(
                name: "Help & FAQ", role: "/help", icon: Icons.help_rounded),
          ],
        ),
      ),
    );
  }
}
