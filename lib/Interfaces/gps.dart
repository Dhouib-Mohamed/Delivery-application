import 'package:flutter/material.dart';

import '../Widgets/tapped.dart';

class GPS extends StatelessWidget {
  const GPS({Key? key}) : super(key: key);

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
          LoginButton(
              name: "ADD LOCATION", c: Color(0xffbd2005), role: '/signin'),
          TappedText(text: "", tapped: "Skip for now", role: '/opening')
        ],
      ),
    );
  }
}
