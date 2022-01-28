import 'package:flutter/material.dart';
import '../Widgets/tapped.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  String? passwordValidator(String? value) {
    RegExp regex = RegExp('^[0-9]');
    if (value!.isEmpty) {
      return ("Code is required for login");
    }
    if ((!regex.hasMatch(value)) || (value.length != 4)) {
      return ("Enter Valid Code( 4 Numbers Only)");
    }
    return null;
  }

  ForgotPassword({Key? key}) : super(key: key);
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
              control: passwordController,
              valid: passwordValidator,
            ),
            const LoginButton(
                name: "SEND NOW", c: Color(0xffbd2005), role: '/otp'),
            const TappedText(
                text: "Having Problem ? ",
                tapped: "Need Help?",
                role: '/forgot_password')
          ],
        ),
      ),
    );
  }
}
