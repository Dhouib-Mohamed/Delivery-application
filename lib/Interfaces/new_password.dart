import 'package:flutter/material.dart';

import '../Widgets/tapped.dart';

class NewPassword extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
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

  NewPassword({Key? key}) : super(key: key);

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
                  "CREATE NEW PASSWORD",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
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
                name: "CONFIRM", c: Color(0xffbd2005), role: '/feed'),
          ],
        ),
      ),
    );
  }
}
