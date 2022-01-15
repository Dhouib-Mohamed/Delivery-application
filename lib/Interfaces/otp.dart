import 'package:flutter/material.dart';

import '../Widgets/tapped.dart';

class OTP extends StatelessWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: const [
            Padding(
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
            Input(field: ''),
            TappedText(
                c: Colors.blueGrey, text: "", tapped: "Resend", role: '/otp'),
            LoginButton(
                name: "CONFIRM", c: Color(0xffbd2005), role: '/new_password'),
            TappedText(
                text: "Having Problem ? ", tapped: "Need Help?", role: '/otp')
          ],
        ),
      ),
    );
  }
}
