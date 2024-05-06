import 'package:flutter/material.dart';
import 'package:fudoh/views/authScreens/signin_screen.dart';
import 'package:fudoh/views/authScreens/signup_screen.dart';
import 'package:fudoh/constants/app_colors.dart';
import 'package:fudoh/constants/app_strings.dart';
import 'package:image_picker/image_picker.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title:  Text(
              kAppName,
              style: TextStyle(fontSize: 26, color: kcPrimaryColor),
            ),
            centerTitle: true,
            bottom:  TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.login_outlined,
                    color: kcPrimaryColor,
                  ),
                  text: "Sign In",
                ),
                Tab(
                  icon: Icon(
                    Icons.person,
                    color: kcPrimaryColor,
                  ),
                  text: "Signup",
                )
              ],
              indicatorColor: kcPrimaryColor,
              indicatorWeight: 5,
            ),
          ),
          body: Container(
            color: kWhiteColor,
            child: const TabBarView(children: [
              SigninScreen(),
              SignupScreen(),
            ]),
          ),
        ));
  }
}
