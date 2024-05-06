import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fudoh/views/authScreens/auth_screen.dart';
import 'package:fudoh/constants/app_colors.dart';
import 'package:fudoh/constants/app_strings.dart';
import 'package:fudoh/views/mainscreen/homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  initTimer() {
    Timer(const Duration(seconds: 3), () async {
      if(FirebaseAuth.instance.currentUser == null){
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AuthScreen()));
      }else{
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
      
    });
  }

  @override
  void initState() {
    super.initState();

    initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset("assets/images/splash.webp"),
            ),
             Text(
              kAppName,
              style:
                  TextStyle(letterSpacing: 3, fontSize: 26, color: kcPrimaryColor),
            )
          ],
        ),
      ),
    );
  }
}
