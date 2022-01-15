import 'package:flutter/material.dart';
import '../Widgets/tapped.dart';

class SignIn extends StatelessWidget {
  final TextEditingController myController = TextEditingController();
  SignIn({Key? key}) : super(key: key);
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
                  "SIGN IN",
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
                  "Complete this step for best adjustment",
                  style: TextStyle(
                    fontFamily: "Inter",
                    color: Colors.blueGrey,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            Input(field: 'Email'),
            Input(field: 'Password'),
            TappedText(
                c: Colors.black,
                text: "",
                tapped: "Forgot Password ?",
                role: '/forgot_password'),
            LoginButton(name: "SIGN IN", c: Color(0xffbd2005), role: "/signin"),
            SizedBox(
              height: 70,
            ),
            LoginButtonColored(
              name: "SIGN IN WITH FACEBOOK",
              icon: AssetImage("assets/icons/Facebook.png"),
              c: Color(0xff3B5998),
              role: '/signin',
            ),
            TappedText(
                text: "Don't have An Account ? ",
                tapped: "Sign Up Here",
                role: '/signup')
          ],
        ),
      ),
    );
  }
}
