import 'package:flutter/material.dart';
import 'package:iac_project/Widgets/tapped.dart';

import '../Widgets/tapped.dart';

import 'feed.dart';

class Opening extends StatefulWidget {
  const Opening({Key? key}) : super(key: key);

  @override
  State<Opening> createState() => _Opening();
}

class _Opening extends State<Opening> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.65,
            child: const Image(
              image: AssetImage("assets/Images/img1.png"),
            ),
          ),
          AuthLoginButtonColored(
            name: "SIGN IN WITH FACEBOOK",
            icon: const AssetImage("assets/icons/Facebook.png"),
            c: const Color(0xff3B5998),
            role: signInWithFacebook,
          ),
          const LoginButton(
              name: "SIGN IN WITH EMAIL",
              c: Color(0xffbd2005),
              role: '/signin'),
          const TappedText(
              text: "Or Start By ",
              tapped: "Creating An Account",
              role: '/signup')
        ],
      ),
    );
  }

  void signInWithFacebook() {
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => Feed()),
        (route) => false);
  }
}
