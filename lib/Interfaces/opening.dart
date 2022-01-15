import 'package:flutter/material.dart';
import 'package:iac_project/Widgets/tapped.dart';

import '../Widgets/tapped.dart';

class Opening extends StatelessWidget {
  const Opening({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          SizedBox(
            width: double.infinity,
            height: 560,
            child: Image(
              image: AssetImage("assets/Images/img1.png"),
            ),
          ),
          LoginButtonColored(
            name: "SIGN IN WITH FACEBOOK",
            icon: AssetImage("assets/icons/Facebook.png"),
            c: Color(0xff3B5998),
            role: '/signin',
          ),
          LoginButton(
              name: "SIGN IN WITH EMAIL",
              c: Color(0xffbd2005),
              role: '/signin'),
          TappedText(
              text: "Or Start By ",
              tapped: "Creating An Account",
              role: '/signup')
        ],
      ),
    );
  }
}
