import 'package:flutter/material.dart';
import 'package:fudoh/constants/app_colors.dart';
import 'package:fudoh/constants/app_strings.dart';
import 'package:fudoh/splashscreen/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppName,
      theme: ThemeData.light(
        
      ).copyWith(
        
          scaffoldBackgroundColor: kWhiteColor),
          
      home: const SplashScreen(),
    );
  }
}
