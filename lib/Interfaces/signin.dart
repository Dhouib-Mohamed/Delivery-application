import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../Widgets/tapped.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models.dart';
// TODO facebook

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

  final t = TappedBox(
    text: 'Stay Signed in',
  );
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    t,
                    const TappedText(
                        c: Colors.black,
                        text: "",
                        tapped: "Forgot Password ?",
                        role: '/forgot_password'),
                  ],
                ),
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
            .then((uid) =>
        {
          Fluttertoast.showToast(msg: "Login Successful"),
          Navigator.pushNamed(context, '/feed'),
        });
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({"autoSigned": t.val});
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
      if (e.code == 'account-exists-with-different-credential') {
        // The account already exists with a different credential
        String email = e.email!;
        AuthCredential pendingCredential = e.credential!;

        // Fetch a list of what sign-in methods exist for the conflicting user
        List<String> userSignInMethods = await _auth.fetchSignInMethodsForEmail(email);

        // If the user has several sign-in methods,
        // the first method in the list will be the "recommended" method to use.
        if (userSignInMethods.first == 'password') {
          // Prompt the user to enter their password
          String password = '...';

          // Sign the user in to their account with the password
          UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

          // Link the pending credential with the existing account
          await userCredential.user?.linkWithCredential(pendingCredential);
        }
      }
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
