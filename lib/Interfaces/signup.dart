import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Widgets/tapped.dart';

class SignUp extends StatelessWidget {
  final TextEditingController myController = TextEditingController();
  SignUp({Key? key}) : super(key: key);
  Input i1 =const Input(field: 'Email');
  Input i2 =const Input(field: 'Password');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 35),
              child: SizedBox(
                width: 328,
                height: 24,
                child: Text(
                  "SIGN UP",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const Padding(
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
            const Input(field: 'Name'),
            i1,
            i2,
            const Input(field: 'Phone Number'),
            AuthLoginButton(name: "SIGN UP", c: const Color(0xffbd2005), role: signUp(context)),
            const TappedText(
                text: "Already have An Account ? ",
                tapped: "Sign In Here",
                role: '/signin')
          ],
        ),
      ),
    );
  }
  Future<void> signUp(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: i1.field,
          password: i2.field
      );
      Navigator.pushNamed(context, '/signin');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

}
}
