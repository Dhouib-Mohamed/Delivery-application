import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iac_project/Interfaces/otp.dart';
import 'package:iac_project/firebase_options.dart';
import 'Interfaces/adress.dart';
import 'Interfaces/forgot_password.dart';
import 'Interfaces/gps.dart';
import 'Interfaces/help.dart';
import 'Interfaces/new_password.dart';
import 'Interfaces/opening.dart';
import 'Interfaces/profile.dart';
import 'Interfaces/setting.dart';
import 'Interfaces/signin.dart';
import 'Interfaces/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'app', options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App",
      initialRoute: '/gps',
      routes: {
        '/opening': (context) => const Opening(),
        '/signup': (context) => const SignUp(),
        '/signin': (context) => const SignIn(),
        '/forgot_password': (context) => const ForgotPassword(),
        '/otp': (context) => OTP(),
        '/new_password': (context) => NewPassword(),
        '/gps': (context) => const GPS(),
        '/settings': (context) => Setting(),
        '/adress': (context) => const Adress(),
        '/help': (context) => Help(),
        '/profile': (context) => const Profile(),
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
