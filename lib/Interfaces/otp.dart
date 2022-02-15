import 'package:flutter/material.dart';

import '../Widgets/tapped.dart';

class OTP extends StatefulWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController codeController = TextEditingController();

  String? codeValidator(String? value) {
    RegExp regex = RegExp('^[0-9]');
    if (value!.isEmpty) {
      return ("Code is required for login");
    }
    if ((!regex.hasMatch(value)) || (value.length != 4)) {
      return ("Enter Valid Code( 4 Numbers Only)");
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
              padding: EdgeInsets.only(left: 35, top: 10, bottom: 80),
              child: SizedBox(
                width: 328,
                height: 24,
                child: Text(
                  "CONFIRM THE CODE WE SENT YOU",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Input(
              field: '',
              control: codeController,
              valid: codeValidator,
            ),
            const TappedText(
                c: Colors.blueGrey, text: "", tapped: "Resend", role: '/otp'),
            const LoginButton(
                name: "CONFIRM", c: Color(0xffbd2005), role: '/new_password'),
            const TappedText(
                text: "Having Problem ? ", tapped: "Need Help?", role: '/otp')
          ],
        ),
      ),
    );
  }

  void otp() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, '/new_password');
    }
  }
}
