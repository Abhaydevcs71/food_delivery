import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fudoh/constants/app_colors.dart';
import 'package:fudoh/global/global_vars.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class CommonViewModel {

    getCurrentLocation() async {
    Position cPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

        position = cPosition;
    placemark =
        await placemarkFromCoordinates(cPosition.latitude, cPosition.longitude);

    Placemark placemarkVar = placemark![0];

    fullAddress =
        "${placemarkVar.subThoroughfare} ${placemarkVar.thoroughfare},${placemarkVar.subLocality} ${placemarkVar.locality}, ${placemarkVar.subAdministrativeArea} ${placemarkVar.administrativeArea}, ${placemarkVar.postalCode},${placemarkVar.country}";

        return fullAddress; 
  }

  updateLocationInDatabase() async {
    String address = await getCurrentLocation();

    await FirebaseFirestore.instance.collection("sellers").doc(FirebaseAuth.instance.currentUser!.uid).update({
      "address":address,
      "latitude":position!.latitude,
      "longitude":position!.longitude,
    });
  }

  showSnackBar(String message, BuildContext context){
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  

   pickImageFromGallery() async {
    imageFile = await imagePicker.pickImage(source: ImageSource.gallery);

  }

  captureImageWithCamara() async {
    imageFile = await imagePicker.pickImage(source: ImageSource.camera);

  }


  showDialogWithImageOption(BuildContext context){
    return showDialog(context: context, builder: (context){
      return SimpleDialog(
        title: Text("Choose Option",
        style: TextStyle(
          color: kBlackColor,
          fontWeight: FontWeight.bold,
        ),
        ),
        children: [
          SimpleDialogOption(
            onPressed: () async{
             await captureImageWithCamara();
             Navigator.pop(context,"Selected");
            },
            child: Text("Capture with Camera",
            style: TextStyle(color: kGreyColor),
            ),
          ),
          SimpleDialogOption(
            onPressed: () async{
            await  pickImageFromGallery();
              Navigator.pop(context,"Selected");
            },
            child: Text("Select Image From Gallery",
            style: TextStyle(color: kGreyColor),
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel",
            style: TextStyle(color: kGreyColor),
            ),
          )
        ],
      );
    });
  }
}