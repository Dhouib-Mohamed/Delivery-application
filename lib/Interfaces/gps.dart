import 'package:flutter/material.dart';

import '../Widgets/tapped.dart';

class GPS extends StatelessWidget {
  const GPS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.75,
            child: const Image(
              image: AssetImage("assets/Images/location.webp"),
            ),
          ),
          const LoginButton(
              name: "ADD LOCATION", c: Color(0xffbd2005), role: '/map'),
          const TappedText(text: "", tapped: "Skip for now", role: '/feed')
        ],
      ),
    );
  }
}
