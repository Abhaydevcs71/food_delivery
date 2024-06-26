import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riders_app/global/global_vars.dart';

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

  showSnackBar(String message,BuildContext context){
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  getRiderPreviousEarnings()async{

   await FirebaseFirestore.instance.collection("riders")
    .doc(sharedPreferences!.getString("uid"))
    .get().then((snap){
     previousRiderEarnings = ""; 
     previousRiderEarnings = snap.data()!["earnings"].toString();
    });

  }

  getSellerPreviousEarnings(String sellerId)async{

   await FirebaseFirestore.instance.collection("sellers")
    .doc(sellerId)
    .get().then((snap){
      previousSellerEarnings = ""; 
     previousSellerEarnings = snap.data()!["earnings"].toString();
     
    });
    
  }

  getOrderTotalAmount( String orderId) async{
    await FirebaseFirestore.instance.collection("orders")
    .doc(orderId)
    .get().then((snap){
      orderTotalAmount = ""; 
     orderTotalAmount = snap.data()!["totalAmount"].toString();
     
    });
  }

}