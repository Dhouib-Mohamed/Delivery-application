import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iac_project/Widgets/tapped.dart';
import '../models.dart';
import 'signin.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _Feed();
}

class _Feed extends State<Feed> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? loggedInUser;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromJson(value.data());
      setState(() {});
    });
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignIn()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: const Color(0xffbd2005),
        leading: IconButton(
          onPressed: () {
            _key.currentState!.openDrawer();
          },
          icon: const Icon(Icons.menu_sharp),
          color: const Color(0x00eeeeee),
        ),
      ),
      body: ListView(),
      drawer: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 8.0),
        child: ListView(
          children: [
            Text(
              loggedInUser!.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              loggedInUser!.email,
              style: const TextStyle(
                color: Color(0x008e8e93),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const ProfileButton(
                name: "My Profile",
                role: "/profile",
                icon: Icons.account_circle_outlined),
            const ProfileButton(
                name: "My Adresses", role: "/adress", icon: Icons.location_on),
            const ProfileButton(
                name: "Settings",
                role: "/settings",
                icon: Icons.settings_sharp),
            const ProfileButton(
                name: "Help & FAQ", role: "/help", icon: Icons.help_rounded),
            Padding(
                padding: const EdgeInsets.only(top: 100, left: 32, bottom: 13),
                child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xffbd2005)),
                        fixedSize:
                            MaterialStateProperty.all(const Size(200, 48)),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ))),
                    onPressed: () {
                      logout(context);
                      Navigator.pushNamed(context, '/opening');
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.power_settings_new,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          Text(
                            "Log Out",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )
                        ])))
          ],
        ),
      ),
    );
  }
}
