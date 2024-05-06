import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fudoh/global/global_instance.dart';
import 'package:fudoh/global/global_vars.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:fudoh/views/mainscreen/homescreen.dart';

class MenuViewModel {
 

  getCategories() async {
    await FirebaseFirestore.instance
        .collection("category")
        .get()
        .then((QuerySnapshot dataSnapshot) {
      dataSnapshot.docs.forEach((doc) {
        categoryList.add(doc["name"]);
      });
    });
  }

  validateMenuUploadForm(
      String infoText, String titleText, BuildContext context) async {
    if (imageFile != null) {
      if (infoText.isNotEmpty && titleText.isNotEmpty) {
        commonViewModel.showSnackBar("Please Wait...", context);

         String uniqueFileId = DateTime.now().millisecondsSinceEpoch.toString();

        String downloadUrl = await uploadImageToStorage(uniqueFileId);

        await saveMenuInfoToDatabase(infoText, titleText, downloadUrl,uniqueFileId, context);
      } else {
        commonViewModel.showSnackBar("Please Fill all fields", context);
      }
    } else {
      commonViewModel.showSnackBar("Please select image", context);
    }
  }

  uploadImageToStorage(uniqueFileId) async {
    fStorage.Reference reference =
        fStorage.FirebaseStorage.instance.ref().child("menus");

    fStorage.UploadTask uploadTask =
        reference.child("$uniqueFileId.jpg").putFile(File(imageFile!.path));

    fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  saveMenuInfoToDatabase(String infoText, String titleText, String downloadUrl,uniqueFileId,
      BuildContext context) async {

         String uniqueFileId = DateTime.now().millisecondsSinceEpoch.toString();

    final reference = FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus");

    await reference.doc(uniqueFileId).set({
      "menuId": uniqueFileId,
      "sellerUid": sharedPreferences!.getString("uid"),
      "sellerName": sharedPreferences!.getString("name"),
      "menuInfo": infoText,
      "menuImage": downloadUrl,
      "publishedDateTime": DateTime.now(),
      "status": "available",
    });
    commonViewModel.showSnackBar("Upload Sucessfully", context);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
  }

  retriveMenus(){
   try{ return  FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .orderBy("publishedDateTime", descending: true)
        .snapshots();
   }catch(e){
    log.e(e);
   }
  }
}
