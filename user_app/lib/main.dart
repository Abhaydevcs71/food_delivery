import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/constants/app_colors.dart';
import 'package:user_app/constants/app_strings.dart';
import 'package:user_app/firebase_options.dart';
import 'package:user_app/global/global_vars.dart';
import 'package:user_app/provider/address_changer.dart';
import 'package:user_app/provider/cart_item_counter.dart';
import 'package:user_app/provider/total_amount.dart';
import 'package:user_app/views/splashscreen/splashscreen.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartItemCounter(),),
       ChangeNotifierProvider(create: (context) => TotalAmount(),),
       ChangeNotifierProvider(create: (context) => AddressChanger(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: kAppName,
        theme: ThemeData.light().copyWith(scaffoldBackgroundColor: kWhiteColor),
        home: const SplashScreen(),
      ),
    );
  }
}
