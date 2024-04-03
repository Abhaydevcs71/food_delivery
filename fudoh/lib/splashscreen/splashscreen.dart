import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fudoh/authScreens/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  initTimer() {
    Timer(const Duration(seconds: 3), () async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AuthScreen()));
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
            const Text(
              "FudOh",
              style:
                  TextStyle(letterSpacing: 3, fontSize: 26, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
