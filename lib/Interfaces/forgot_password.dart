import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Widgets/tapped.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  String? errorMessage;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  String? emailValidator(String? value) {
    RegExp email = RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]");
    if (value!.isEmpty) {
      return ("Email is required for reset");
    }
    if (!email.hasMatch(value)){
      return ("Invalid Email");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 35),
                  child: SizedBox(
                    width: 328,
                    height: 24,
                    child: Text(
                      "FORGOT PASSWORD",
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
                      "Enter your Email to request reset",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: "Inter",
                        color: Colors.blueGrey,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                Input(
                  field: '',
                  control: emailController,
                  valid: emailValidator,
                ),
                AuthLoginButton(
                    name: "SEND NOW",
                    c: const Color(0xffbd2005),
                    role: password),
                const TappedText(
                    text: "Having Problem ? ",
                    tapped: "Need Help?",
                    role: '/forgot_password')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> password() async {
    if (_formKey.currentState!.validate()) {
      try{
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text)
            .then((value) => Fluttertoast.showToast(
                msg: "We have sent you a reset link on your mail"));
      } on FirebaseAuthException catch(e) {
        Fluttertoast.showToast(msg: e.code);
      }
      Navigator.pushNamed(context, '/signin');
      }
}
}
