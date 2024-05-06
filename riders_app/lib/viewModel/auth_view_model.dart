import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:riders_app/global/global_instance.dart';
import 'package:riders_app/global/global_vars.dart';
import 'package:riders_app/views/homescreen/homescreen.dart';

class AuthViewModel {
  validateSignUpForm(
      XFile? imageXFile,
      String password,
      String confirmPassword,
      String name,
      String email,
      String phone,
      String locationAddress,
      BuildContext context) async {
    if (imageXFile == null) {
      commonViewModel.showSnackBar("Please Select an Image", context);
      return;
    } else {
      if (password == confirmPassword) {
        if (name.isNotEmpty &&
            email.isNotEmpty &&
            password.isNotEmpty &&
            confirmPassword.isNotEmpty &&
            phone.isNotEmpty &&
            locationAddress.isNotEmpty) {
          User? currentFirebaseUser =
              await createUserInFirebaseAuth(email, password, context);

          commonViewModel.showSnackBar("Please wait", context);

          String downloadUrl = await uploadImageToStorage(imageXFile);

          await saveUserDataToFirestore(currentFirebaseUser!, downloadUrl, name,
              email, password, locationAddress, phone);

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));

          commonViewModel.showSnackBar("Account created succesfully", context);
        } else {
          commonViewModel.showSnackBar("please fill all fields", context);
          return;
        }
      } else {
        commonViewModel.showSnackBar("Password does not match", context);
        return;
      }
    }
  }

  createUserInFirebaseAuth(
      String email, String password, BuildContext context) async {
    User? currentFirebaseUser;

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((valueAuth) {
      currentFirebaseUser = valueAuth.user;
    }).catchError((errorMsg) {
      commonViewModel.showSnackBar(errorMsg, context);
    });

    if (currentFirebaseUser == null) {
      FirebaseAuth.instance.signOut();
      return;
    }
    return currentFirebaseUser;
  }

  uploadImageToStorage(XFile imageXFile) async {
    String downloadUrl = "";

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    fStorage.Reference storageRef = fStorage.FirebaseStorage.instance
        .ref()
        .child("riderImages")
        .child(fileName);
    fStorage.UploadTask uploadTask = storageRef.putFile(File(imageXFile.path));
    fStorage.TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => {});
    await taskSnapshot.ref.getDownloadURL().then((urlImage) {
      downloadUrl = urlImage;
    });
    return downloadUrl;
  }

  saveUserDataToFirestore(
      User currentFirebaseUser,
      String downloadUrl,
      String name,
      String email,
      String password,
      String locationAddress,
      String phone) async {
    FirebaseFirestore.instance
        .collection("riders")
        .doc(currentFirebaseUser.uid)
        .set({
      "uid": currentFirebaseUser.uid,
      "email": email,
      "name": name,
      "image": downloadUrl,
      "phone": phone,
      "address": locationAddress,
      "status": "approved",
      "earnings": 0.0,
      "latitude": position!.latitude,
      "lognitude": position!.longitude
    });
    
     await sharedPreferences!.setString("uid",currentFirebaseUser.uid);
     await sharedPreferences!.setString("email",email);
     await sharedPreferences!.setString("name",name);
     await sharedPreferences!.setString("imageUrl",downloadUrl);
  }

  validateSignInForm(
      String email, String password, BuildContext context) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      commonViewModel.showSnackBar("checking credentials...", context);

      User? currentFirebaseUser = await loginUser(email, password, context);

      await readDataFromFirestoreAndSetDataLocally(currentFirebaseUser!, context);

      Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));


    } 
    else 
    {
      commonViewModel.showSnackBar("Password and email required", context);
      return;
    }
  }

  loginUser(String email, String password, BuildContext context) async {
    User? currentFirebaseUser;

  await  FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((valueAuth) {
      currentFirebaseUser = valueAuth.user;
    }).catchError((errorMsg) {
      commonViewModel.showSnackBar(errorMsg, context);
    });

    if (currentFirebaseUser == null) {
      FirebaseAuth.instance.signOut();
      return;
    }

    return currentFirebaseUser;
  }

  readDataFromFirestoreAndSetDataLocally(User? currentFirebaseUser, BuildContext context) async {
    await FirebaseFirestore.instance
        .collection("riders")
        .doc(currentFirebaseUser!.uid)
        .get()
        .then((dataSnapshot) async {


          if(dataSnapshot.exists){

      if (dataSnapshot.data()!["status"] == "approved") {
        await sharedPreferences!.setString("uid", currentFirebaseUser.uid);
        await sharedPreferences!
            .setString("email", dataSnapshot.data()!["email"]);
        await sharedPreferences!
            .setString("name", dataSnapshot.data()!["name"]);
        await sharedPreferences!
            .setString("imageUrl", dataSnapshot.data()!["image"]);
      }else{
        commonViewModel.showSnackBar("You are blocked by the admin", context);
        FirebaseAuth.instance.signOut();
        return;
      }
      }else{
        commonViewModel.showSnackBar("This seller do not exist", context);
        FirebaseAuth.instance.signOut();
        return;
      }
    });
  }
}
