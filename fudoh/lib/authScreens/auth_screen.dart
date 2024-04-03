import 'package:flutter/material.dart';
import 'package:fudoh/authScreens/signin_screen.dart';
import 'package:fudoh/authScreens/signup_screen.dart';

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
            title: const Text(
              "FudOh",
              style: TextStyle(fontSize: 26, color: Colors.deepPurpleAccent),
            ),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.login_outlined,
                    color: Colors.blueGrey,
                  ),
                  text: "Sign In",
                ),
                Tab(
                  icon: Icon(
                    Icons.person,
                    color: Colors.blueGrey,
                  ),
                  text: "Signup",
                )
              ],
              indicatorColor: Colors.black,
              indicatorWeight: 5,
            ),
          ),
          body: Container(
            color: Colors.black,
            child: const TabBarView(children: [
              SigninScreen(),
              SignupScreen(),
            ]),
          ),
        ));
  }
}
