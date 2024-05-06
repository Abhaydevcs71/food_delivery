import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fudoh/global/global_instance.dart';
import 'package:fudoh/global/global_vars.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:fudoh/model/menus.dart';
import 'package:fudoh/views/mainscreen/homescreen.dart';

class ItemViewModel {
  validateItemUploadForm(
      String infoText,
      String titleText,
      String descriptionText,
      String priceText,
      Menu menuModel,
      BuildContext context) async {
    if (imageFile != null) {
      if (infoText.isNotEmpty &&
          titleText.isNotEmpty &&
          descriptionText.isNotEmpty &&
          priceText.isNotEmpty) {
        commonViewModel.showSnackBar("Please Wait...", context);

        String uniqueFileId = DateTime.now().millisecondsSinceEpoch.toString();

        String downloadUrl = await uploadImageToStorage(uniqueFileId);

        await saveItemInfoToDatabase(infoText, titleText,downloadUrl, descriptionText,
            priceText, uniqueFileId, menuModel, context);
      } else {
        commonViewModel.showSnackBar("Please Fill all fields", context);
      }
    } else {
      commonViewModel.showSnackBar("Please select image", context);
    }
  }

  uploadImageToStorage(uniqueFileId) async {
    fStorage.Reference reference =
        fStorage.FirebaseStorage.instance.ref().child("items");

    fStorage.UploadTask uploadTask =
        reference.child("$uniqueFileId").putFile(File(imageFile!.path));

    fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  saveItemInfoToDatabase(
    String infoText,
    String titleText,
    String downloadUrl,
    String descriptionText,
    String priceText,
    String uniqueFileId,
    Menu menuModel,
    BuildContext context,
  ) async {
    log.i("function called");

   int price = int.parse(priceText);

    final referenceSeller = FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(menuModel.menuId)
        .collection("items");

    final referenceMain = FirebaseFirestore.instance.collection("items");

    await referenceSeller.doc(uniqueFileId).set({
      "menuId": menuModel.menuId,
      "menuName": menuModel.menuTitle,
      "itemId": uniqueFileId,
      "sellerUid": sharedPreferences!.getString("uid"),
      "sellerName": sharedPreferences!.getString("name"),
      "itemInfo": infoText,
      "itemTitle": titleText,
      "itemImage": downloadUrl,
      "description": descriptionText,
      "price": price,
      "publishedDateTime": DateTime.now(),
      "status": "available",
    }).then((value) async {
      await referenceMain.doc(uniqueFileId).set({
        "menuId": menuModel.menuId,
        "menuName": menuModel.menuTitle,
        "itemId": uniqueFileId,
        "sellerUid": sharedPreferences!.getString("uid"),
        "sellerName": sharedPreferences!.getString("name"),
        "itemInfo": infoText,
        "itemTitle": titleText,
        "itemImage": downloadUrl,
        "description": descriptionText,
        "price": price,
        "publishedDateTime": DateTime.now(),
        "status": "available",
        "isRecommended": false,
        "isPopular": false,
      });
    });
    commonViewModel.showSnackBar("Upload Sucessfully", context);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
  }

  retrieveItems(menuId) {
    return FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(menuId)
        .collection("items")
        .orderBy("publishedDateTime", descending: true)
        .snapshots();
  }
}
