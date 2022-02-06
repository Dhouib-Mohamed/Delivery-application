import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iac_project/Widgets/tapped.dart';

import '../Widgets/tapped.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'feed.dart';

class Opening extends StatefulWidget {
  const Opening({Key? key}) : super(key: key);

  @override
  State<Opening> createState() => _Opening();
}

class _Opening extends State<Opening> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
            height: 560,
            child: Image(
              image: AssetImage("assets/Images/img1.png"),
            ),
          ),
          AuthLoginButtonColored(
            name: "SIGN IN WITH FACEBOOK",
            icon: const AssetImage("assets/icons/Facebook.png"),
            c: const Color(0xff3B5998),
            role: signInWithFacebook,
          ),
          const LoginButton(
              name: "SIGN IN WITH EMAIL",
              c: Color(0xffbd2005),
              role: '/signin'),
          const TappedText(
              text: "Or Start By ",
              tapped: "Creating An Account",
              role: '/signup')
        ],
      ),
    );
  }

  void signInWithFacebook() async {
    String? message = "Error";
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();

      // Create a credential from the access token
      final facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      Fluttertoast.showToast(msg: "Connected successfully :) ");

      Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) => const Feed()),
          (route) => false);
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-credential":
          message = "unknown Error have occurred";
          break;
        case "operation-not-allowed":
          message = "Not allowed";
          break;
        case "user-disabled":
          message = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          message = "Too many requests";
          break;
      }
      Fluttertoast.showToast(msg: message);
    }
  }
}
