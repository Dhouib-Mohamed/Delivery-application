import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iac_project/Interfaces/cart.dart';
import 'package:iac_project/Interfaces/end_order.dart';
import 'package:iac_project/Interfaces/feed.dart';
import 'package:iac_project/Interfaces/profile.dart';
import 'package:iac_project/Interfaces/saved.dart';
import 'package:iac_project/Interfaces/search.dart';
import 'package:iac_project/firebase_options.dart';
import 'package:splashscreen/splashscreen.dart';
import 'Interfaces/address.dart';
import 'Interfaces/forgot_password.dart';
import 'Interfaces/gps.dart';
import 'Interfaces/help.dart';
import 'Interfaces/map.dart';
import 'Interfaces/opening.dart';
import 'Interfaces/setting.dart';
import 'Interfaces/signin.dart';
import 'Interfaces/signup.dart';
import "globals.dart" as globals;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<String> initialisation;

  Future<String> init() async {
    await Firebase.initializeApp(
        name: 'app', options: DefaultFirebaseOptions.currentPlatform);
    late String i;
    if (FirebaseAuth.instance.currentUser != null) {
      await globals.getsign();
      if (globals.signedIn == true) {
          i = '/feed';
      } else {
          i = '/opening';
          await FirebaseAuth.instance.signOut();
          globals.user = null;
      }
    } else {
        i = '/opening';
    }
    return i;
  }

  @override
  void initState() {
    super.initState();
    initialisation = init();
  }

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
            title: "App",
            routes: {
              '/opening': (context) => const Opening(),
              '/signup': (context) => const SignUp(),
              '/signin': (context) => const SignIn(),
              '/forgot_password': (context) => const ForgotPassword(),
              '/gps': (context) => const GPS(),
              '/settings': (context) => const Setting(),
              '/address': (context) => Address(),
              '/help': (context) => const Help(),
              '/map': (context) => const Mapp(),
              '/end_order': (context) => const EndOrder(),
              '/cart': (context) => const Cart(),
              '/search': (context) => const Search(),
              '/saved': (context) => const Saved(),
              '/feed': (context) => const Feed(),
              '/profile': (context) => const Profile(),
            },

            home:
            SplashScreen(
                navigateAfterFuture: initialisation,
                imageBackground: const AssetImage("assets/Images/splash.webp"),
                loaderColor: Colors.white,
            ),
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
