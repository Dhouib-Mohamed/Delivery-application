import 'package:flutter/material.dart';
import 'package:iac_project/Widgets/login_button_colored.dart';
import 'package:iac_project/Widgets/login_button_normal.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image(
                  image: AssetImage("assets/Images/img1.png"),
              ),
            ),
            LoginButtonColored(name: "Connect via Google", icon: Icons.ac_unit_rounded, c: Color(0xffdd4b39), role: Login),
            LoginButtonColored(name: "Connect via Facebook", icon: Icons.ac_unit_rounded, c: Color(0xff3B5998), role: Login),
            LoginButtonColored(name: "Connect via Apple", icon: Icons.kayaking, c: Color(0xff000000), role: Login),
            LoginButtonColored(name: "Connect via Email", icon: Icons.mail, c: Colors.blueGrey, role: Login),
            LoginButtonNormal(name: "Create an account", role: Login),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: SizedBox(
                width: 327,
                height: 45,
                child: Text(
                  "By signing up, you are agreeing to our Terms & Conditions",
                  style: TextStyle(
                    fontSize: 13
                  ),
                ),
              ),
            )
          ],
        ),
    );
  }
}
