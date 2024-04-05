import 'package:flutter/material.dart';
import 'package:fudoh/constants/app_colors.dart';
import 'package:fudoh/widgets/custom_text_fields.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  GlobalKey<FormState> fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset("assets/images/seller.png",height: 270,),
            ),
          ),

          Form(
            key: fromKey,
            child: Column(children: [
              CustomTextField(
                textEditingController: emailController,
                iconData: Icons.email,
                hintString: "Email",
                isObscure: false,
                enabled: true,
              ),
              CustomTextField(
                textEditingController: passwordController,
                iconData: Icons.password,
                hintString: "password",
                isObscure: true,
                enabled: true,
                
              ),
              const SizedBox(height: 10,),
              ElevatedButton(onPressed: (){},
              style: ElevatedButton.styleFrom(
                backgroundColor: kcPrimaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 70,vertical: 20)
              ), child: const Text("Login",style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 19
              ),),
              )
          ],))
        ],
      ),
    );
  }
}