import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Widgets/tapped.dart';
import '../models.dart';
import 'feed.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  String? nameValidator(String? value) {
    RegExp regex = RegExp(r'^.{3,}$');
    if (value!.isEmpty) {
      return ("First Name cannot be Empty");
    }
    if (!regex.hasMatch(value)) {
      return ("Enter Valid name(Min. 3 Character)");
    }
    return null;
  }

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

  String? phoneValidator(String? value) {
    RegExp regex = RegExp('^[0-9]');
    if (value!.isEmpty) {
      return ("Phone Number is required for login");
    }
    if ((!regex.hasMatch(value)) || (value.length != 8)) {
      return ("Enter Valid Phone Number( 8 Numbers Only)");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 35),
              child: SizedBox(
                width: 328,
                height: 24,
                child: Text(
                  "SIGN UP",
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
              field: 'Name',
              control: nameController,
              valid: nameValidator,
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
            Input(
              field: 'Phone Number',
              control: phoneController,
              valid: phoneValidator,
            ),
            AuthLoginButton(
                name: "SIGN UP", c: const Color(0xffbd2005), role: signUp),
            const TappedText(
                text: "Already have An Account ? ",
                tapped: "Sign In Here",
                role: '/signin')
          ],
        ),
      ),
    );
  }

  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
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
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = nameController.text;
    userModel.phone = phoneController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toJson());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const Feed()),
        (route) => false);
  }
}
