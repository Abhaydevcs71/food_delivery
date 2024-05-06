import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fudoh/constants/app_colors.dart';
import 'package:fudoh/constants/app_strings.dart';
import 'package:fudoh/firebase_options.dart';
import 'package:fudoh/global/global_vars.dart';
import 'package:fudoh/views/splashscreen/splashscreen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
    sharedPreferences = await SharedPreferences.getInstance();
    await Permission.locationWhenInUse.isDenied.then((valueOfPermission) {
      if (valueOfPermission) {
        Permission.locationWhenInUse.request();
      }
    });
  }
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
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: kWhiteColor),
      home: const SplashScreen(),
    );
  }
}
