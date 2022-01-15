import 'package:flutter/material.dart';
import 'package:iac_project/Widgets/Input.dart';
import 'package:iac_project/Widgets/SimplAppBar.dart';
import 'package:iac_project/Widgets/login_button_normal.dart';
import '../Widgets/login_button.dart';

class CreateAccount extends StatelessWidget {
  final TextEditingController myController = TextEditingController();
  CreateAccount({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold (
        appBar: SimplAppBar(text: "Create an account", context: context,),
      body:
      Column(
        children: const [
          Padding(
            padding: EdgeInsets.only(top: 30,left: 35,bottom: 20),
            child: SizedBox(
              width: 328,
              height: 24,
              child: Text(
                "Input your credentials",
                style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                ),
              ),
            ),
          ),
          Input(field: 'First Name'),
          Input(field: 'Last Name',),
          Input(field: 'Email',),
          Input(field: 'Phone Number',),
          Input(field: 'Password',),
          LoginButton(name: "Create an account", c: Colors.blueAccent, role: '/CreateAccount'),
          LoginButtonNormal(name: "Login instead", role: "/Login") ,


        ],

      ),
    );
  }

}