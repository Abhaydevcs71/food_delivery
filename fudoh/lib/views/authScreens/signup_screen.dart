import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fudoh/constants/app_colors.dart';
import 'package:fudoh/global/global_instance.dart';
import 'package:fudoh/global/global_vars.dart';
import 'package:fudoh/viewModel/common_view_model.dart';
import 'package:fudoh/widgets/custom_text_fields.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignipScreenState();
}

class _SignipScreenState extends State<SignupScreen> {
  

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController locationTextEditingController = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InkResponse(
            onTap: () async{
             await commonViewModel.pickImageFromGallery();

             setState(() {
               imageFile;
             });
            },
            child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.20,
                backgroundImage:
                    imageFile == null ? null : FileImage(File(imageFile!.path)),
                child: imageFile == null
                    ? Icon(
                        Icons.add_photo_alternate,
                        size: MediaQuery.of(context).size.width * 0.20,
                        color: kGreyColor,
                      )
                    : null),
          ),
          Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    textEditingController: nameTextEditingController,
                    iconData: Icons.edit,
                    hintString: "Name",
                    isObscure: false,
                    enabled: true,
                  ),
                  CustomTextField(
                    textEditingController: phoneTextEditingController,
                    iconData: Icons.phone,
                    hintString: "phone",
                    isObscure: false,
                    enabled: true,
                  ),
                  CustomTextField(
                    textEditingController: emailTextEditingController,
                    iconData: Icons.email,
                    hintString: "Email",
                    isObscure: false,
                    enabled: true,
                  ),
                  CustomTextField(
                    textEditingController: passwordTextEditingController,
                    iconData: Icons.password,
                    hintString: "password",
                    isObscure: true,
                    enabled: true,
                  ),
                  CustomTextField(
                    textEditingController: confirmPasswordTextEditingController,
                    iconData: Icons.password,
                    hintString: "Confirm password",
                    isObscure: true,
                    enabled: true,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        String address =
                            await commonViewModel.getCurrentLocation();
                        setState(() {
                          locationTextEditingController.text = address;
                        });
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.my_location),
                          Text("Get  Current Location")
                        ],
                      )),
                  CustomTextField(
                    textEditingController: locationTextEditingController,
                    iconData: Icons.my_location_sharp,
                    hintString: "Address",
                    isObscure: false,
                    enabled: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async{
                    await  authViewModel.validateSignUpForm(
                        imageFile,
                        passwordTextEditingController.text.trim(),
                        confirmPasswordTextEditingController.text.trim(),
                        nameTextEditingController.text.trim(),
                        emailTextEditingController.text.trim(),
                        phoneTextEditingController.text.trim(),
                        fullAddress,
                        context,
                      );
                      setState(() {
                        imageFile =null;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kcPrimaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 20)),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
