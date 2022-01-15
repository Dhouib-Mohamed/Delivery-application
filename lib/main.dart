import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iac_project/Interfaces/otp.dart';
import 'package:provider/provider.dart';
import 'Interfaces/forgot_password.dart';
import 'Interfaces/new_passwod.dart';
import 'Interfaces/opening.dart';
import 'Interfaces/signin.dart';
import 'Interfaces/signup.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App",
      initialRoute: '/opening',
      routes: {
        '/opening': (context) => const Opening(),
        '/signup': (context) => SignUp(),
        '/signin': (context) => SignIn(),
        '/forgot_password': (context) => ForgotPassword(),
        '/otp': (context) => const OTP(),
        '/new_password': (context) => const NewPassword(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
      ),
    );
  }
}
