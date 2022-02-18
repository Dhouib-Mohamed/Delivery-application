import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iac_project/Widgets/tapped.dart';
import '../Widgets/tapped.dart';
import '../models.dart';
// TODO facebook
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
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.65,
            child: const Image(
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

  Future<void> signInWithFacebook() async {
    String? message = "Error";
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();
      Fluttertoast.showToast(msg: "Connected successfully :) ");

      // Create a credential from the access token
      final facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      User? user = FirebaseAuth.instance.currentUser;

      UserModel userModel =
          UserModel(email: userData["email"], name: userData["name"]);

      userModel.phone = "";
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .set(userModel.toJson());

      Fluttertoast.showToast(msg: "Connected successfully :) ");

      Navigator.pushNamed(context, '/feed');
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
        default:
          message = "Unknown Error";
      }
      Fluttertoast.showToast(msg: message);
    }
  }
}
