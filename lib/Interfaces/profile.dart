import 'package:flutter/material.dart';
import 'package:iac_project/Widgets/parts.dart';
import '../Widgets/tapped.dart';
import '../globals.dart' as globals;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  
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
      body: Padding(
        padding: const EdgeInsets.only(top:50),
        child: SizedBox(
          height: MediaQuery.of(context).size.height*0.6,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:20,bottom: 15),
                  child: Row(
                    children: [
                      const Text(
                          "NAME : ",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Color(0xffbd2005),
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "${globals.user!.name[0].toUpperCase()}${globals.user!.name.substring(1)}",
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 21,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                    ],
                  ),
                ),
                  Padding(
                    padding: const EdgeInsets.only(left:20,bottom: 15),
                    child: Row(
                      children: [
                        const Text(
                          "EMAIL : ",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Color(0xffbd2005),
                            fontSize: 19,
                          ),
                        ),
                        Text(
                          globals.user!.email,
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:20,bottom:40),
                    child: Row(
                      children: [
                        const Text(
                          "PHONE NUMBER : ",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Color(0xffbd2005),
                            fontSize: 19,
                          ),
                        ),
                        Text(
                          globals.user!.phone!,
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ProfileButton(
                    name: "Change Password",width: MediaQuery.of(context).size.width, role: ()=>Navigator.pushNamed(context, "/forgot_password"), icon: const Icon(Icons.password,color: Colors.black,)),
                  ProfileButton(
                    name: "My Addresses   ",width: MediaQuery.of(context).size.width,role: ()=>Navigator.pushNamed(context, "/address"), icon: const Icon(Icons.location_on,color: Colors.black)),
                  ProfileButton(
                    name: "Settings       ",width: MediaQuery.of(context).size.width, role: ()=>Navigator.pushNamed(context, "/settings"), icon: const Icon(Icons.settings_sharp ,color: Colors.black)),
                  ProfileButton(
                    name: "Help & FAQ     ",width: MediaQuery.of(context).size.width, role: ()=>Navigator.pushNamed(context, "/help") , icon: const Icon(Icons.help_rounded,color: Colors.black)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
