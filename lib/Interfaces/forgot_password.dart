import 'package:flutter/material.dart';
import '../Widgets/tapped.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  String? errorMessage;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordEmailController = TextEditingController();
  String? passwordEmailValidator(String? value) {
    RegExp regex0 = RegExp('^[0-9]');
    RegExp regex1 = RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]");
    if (value!.isEmpty) {
      return ("Code is required for login");
    }
    if ((!regex0.hasMatch(value) && !regex1.hasMatch(value)) ||
        (regex0.hasMatch(value) && value.length != 8)) {
      return ("Enter Valid Code( 4 Numbers Only)");
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
                      "Enter your Email or phone number to request reset",
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
                  control: passwordEmailController,
                  valid: passwordEmailValidator,
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

  void password() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, '/otp');
    }
  }
}
