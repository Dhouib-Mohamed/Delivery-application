import 'package:flutter/material.dart';
import '../Widgets/tapped.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController myController = TextEditingController();
  ForgotPassword({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: const [
            Padding(
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
            Padding(
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
            Input(field: ''),
            LoginButton(name: "SEND NOW", c: Color(0xffbd2005), role: '/otp'),
            TappedText(
                text: "Having Problem ? ",
                tapped: "Need Help?",
                role: '/forgot_password')
          ],
        ),
      ),
    );
  }
}
