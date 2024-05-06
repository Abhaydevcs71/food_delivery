import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user_app/global/global_instance.dart';
import 'package:user_app/global/global_vars.dart';

class AddressViewModel {
  saveShipmentAddresstoDatabase(name, state, fullAddress, phoneNumber,
      flatNumber, city, lat, lng, BuildContext context) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("userAddress")
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set({
      "name": name,
      "phoneNumber": phoneNumber,
      "flatNumber": flatNumber,
      "city": city,
      "state": state,
      "fullAddress": fullAddress,
      "lat": lat,
      "lng": lng,
    }).then((value) {
      commonViewModel.showSnackBar("Address Saved", context);
    });
  }

  retrieveUserShipmentAddress() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("userAddress")
        .snapshots();
  }

  openGoogleMapWithGeoGraphicPosition(double latitude,double longitude)async{

    String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    if(await launchUrl(Uri.parse(googleMapUrl))){
      await launchUrl(Uri.parse(googleMapUrl));
    }else{
      throw "could not open google map";
    }
  }
}
