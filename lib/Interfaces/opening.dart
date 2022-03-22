import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iac_project/Widgets/tapped.dart';
import '../Widgets/tapped.dart';
import '../models.dart';
class Opening extends StatefulWidget {
  const Opening({Key? key}) : super(key: key);

  @override
  State<Opening> createState() => _Opening();
}

class _Opening extends State<Opening> {

  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: const Image(
              image: AssetImage("assets/Images/welcome.webp"),
            ),
          ),
          ColoredButton(
            name: "SIGN IN WITH FACEBOOK",
            icon: const ImageIcon(AssetImage("assets/icons/Facebook.png"),color: Colors.white,),
            color: const Color(0xff3B5998),

            role: signInWithFacebook,
          ),
          ColoredButton(
              name: "SIGN IN WITH EMAIL",
              role: () {Navigator.pushNamed(context, '/signin');},),
          const TappedText(
              text: "Or Start By ",
              tapped: "Creating An Account",
              role: '/signup')
        ],
      ),
    );
  }
  void signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        UserModel user = UserModel(email: userData["email"], name: userData["name"],);
        user.phone = "";
        user.autoSigned = true;
        final facebookCredential = FacebookAuthProvider.credential(result.accessToken!.token);
        await
        _auth.signInWithCredential(facebookCredential).then((value) {Fluttertoast.showToast(msg: "Login Successful");
        Navigator.pushNamed(context, '/feed');});
        await FirebaseFirestore
            .instance
            .collection("users")
            .doc(_auth.currentUser?.uid)
            .set(user.toJson());
        Fluttertoast.showToast(msg: "Connected successfully :) ");

        Navigator.pushNamed(context, '/feed');
      }
      else {
        Fluttertoast.showToast(msg: "Try again");
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = e.code;
      }
      Fluttertoast.showToast(msg: errorMessage!);
    }
  }
}
