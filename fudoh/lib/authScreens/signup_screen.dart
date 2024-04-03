import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignipScreenState();
}

class _SignipScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Text("SignUp",style: TextStyle(
            fontSize: 30,color: Colors.grey
          ),)
        ],
      ),
    );
  }
}