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
  late UserModel loggedInUser;
  Widget locationWidget() {
    bool a = false;
    AddressModel? address;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("addresses")
        .doc()
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        a = true;
        address = AddressModel.fromJson(documentSnapshot.data());
      }
    });
    if (a) {
      return TappedPosition(
          text: "Deliver To :  ", tapped: address!.location, role: '/address');
    } else {
      return const TappedPosition(
          text: "", tapped: "Add Location", role: '/address');
    }
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromJson(value.data());
      setState(() {});
    });
    super.initState();
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
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 100),
          child: const Input(field: 'Search ', control: null, valid: null,),
        ),
        title: locationWidget(),
        leading: IconButton(
          color: Colors.blueGrey,
          onPressed: () {
            _key.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
          ),
        ),
      ),
      body: ListView(),
      drawer: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0, right: 10),
              child: Text(
                loggedInUser.name[0].toUpperCase()+loggedInUser.name.substring(1),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only( right: 10 ,bottom: 40),
              child: Text(
                loggedInUser.email,
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const ProfileButton(
                name: "My Profile",
                role: "/profile",
                icon: Icons.account_circle_outlined),
            const ProfileButton(
                name: "My Adresses", role: "/adress", icon: Icons.location_on),
            const ProfileButton(
                name: "Settings", role: "/settings", icon: Icons.settings_sharp),
            const ProfileButton(
                name: "Help & FAQ", role: "/help", icon: Icons.help_rounded),
            Padding(
                padding: const EdgeInsets.only(top: 100, bottom: 13),
                child: TextButton(
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(const Size(200, 48)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xffbd2005)),
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
