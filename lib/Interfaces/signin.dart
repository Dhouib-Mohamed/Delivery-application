import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../Widgets/tapped.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models.dart';
import 'feed.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;
  String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return ("Please Enter Your Email");
    }
    // reg expression for email validation
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
      return ("Please Enter a valid email");
    }
    return null;
  }

  String? passwordValidator(String? value) {
    RegExp regex = RegExp(r'^.{6,}$');
    if (value!.isEmpty) {
      return ("Password is required for login");
    }
    if (!regex.hasMatch(value)) {
      return ("Enter Valid Password(Min. 6 Character)");
    }
    return null;
  }

  // string for displaying the error Message
  String? errorMessage;
  _SignIn() : super();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 35),
                  child: SizedBox(
                    width: 328,
                    height: 24,
                    child: Text(
                      "SIGN IN",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 35, top: 10, bottom: 80),
                  child: SizedBox(
                    width: 328,
                    height: 24,
                    child: Text(
                      "Complete this step for best adjustment",
                      style: TextStyle(
                        fontFamily: "Inter",
                        color: Colors.blueGrey,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                Input(
                  field: 'Email',
                  control: emailController,
                  valid: emailValidator,
                ),
                Input(
                  field: 'Password',
                  control: passwordController,
                  valid: passwordValidator,
                ),
                const TappedText(
                    c: Colors.black,
                    text: "",
                    tapped: "Forgot Password ?",
                    role: '/forgot_password'),
                AuthLoginButton(
                    name: "SIGN IN", c: const Color(0xffbd2005), role: signIn),
                const SizedBox(
                  height: 70,
                ),
                AuthLoginButtonColored(
                  name: "SIGN IN WITH FACEBOOK",
                  icon: const AssetImage("assets/icons/Facebook.png"),
                  c: const Color(0xff3B5998),
                  role: signInWithFacebook,
                ),
                const TappedText(
                    text: "Don't have An Account ? ",
                    tapped: "Sign Up Here",
                    role: '/signup')
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Feed())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
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
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
      }
    }
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
      User? user = FirebaseAuth.instance.currentUser;

      UserModel userModel =
          UserModel(email: userData["email"], name: userData["name"]);

      userModel.phone = null;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .set(userModel.toJson());

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
