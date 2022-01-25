import 'package:flutter/material.dart';

import '../Widgets/tapped.dart';

class NewPassword extends StatelessWidget {
  const NewPassword({Key? key}) : super(key: key);

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
                  "CREATE NEW PASSWORD",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Input(field: ''),
            LoginButton(name: "CONFIRM", c: Color(0xffbd2005), role: '/feed'),
          ],
        ),
      ),
    );
  }
}
