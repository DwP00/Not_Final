import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:healthypet/screens/home_screen.dart';
import 'package:healthypet/screens/splash_screen.dart';
import 'package:healthypet/features/user_auth/presentation/pages/login_page.dart';
import 'package:healthypet/features/user_auth/presentation/pages/sign_up_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
          apiKey: "AIzaSyAGybIKvduYgqGEWIfw_KQh7YVOYC8KKuM",
          appId: "1:497054696849:android:d19194bd10056d34e1c630",
          messagingSenderId: "497054696849",
          projectId: "uass-firebase",
          // Your web Firebase config options
        ))
      : await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      routes: {
        '/': (context) => SplashScreen(
              child: LoginPage(),
            ),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
