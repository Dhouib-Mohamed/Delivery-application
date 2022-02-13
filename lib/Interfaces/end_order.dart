import 'package:flutter/material.dart';

import '../Widgets/tapped.dart';

class EndOrder extends StatelessWidget {
  const EndOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.75,
            child: Column(

              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 78.0),
                  child: Image(
                    image: AssetImage("assets/Images/CheckCircle.png"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 18.0),
                  child: Image(
                    image: AssetImage("assets/Images/Text.png"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 80.0),
                  child: Image(
                    image: AssetImage("assets/Images/undraw_On_the_way_re_swjt 1.png"),
                  ),
                ),
              ],
            ),
          ),
          const LoginButton(
              name: "Return to Feed", c: Color(0xffbd2005), role: '/feed')
        ],
      ),
    );
  }

}