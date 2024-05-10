import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:riders_app/global/global_instance.dart';
import 'package:riders_app/global/global_vars.dart';
import 'package:riders_app/model/address.dart';
import 'package:riders_app/views/homescreen/homescreen.dart';
import 'package:riders_app/views/mainscreen/parcel_delivering_screen.dart';
import 'package:riders_app/views/mainscreen/parcel_picking_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderViewModel {
  String orderId = DateTime.now().microsecondsSinceEpoch.toString();

  saveOrderDetailsToDatabase(addresId, totalAmount, sellerUid, orderId) {
    writeOrderDetailsForUser({
      "addressId": addresId,
      "totalAmount": totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productId": sharedPreferences!.getStringList("userCart"),
      "paymentDetails": "Online Payment",
      "orderTime": orderId,
      "isSucess": true,
      "sellerUid": sellerUid,
      "riderUid": "",
      "status": "normal",
      "orderid": orderId,
    });

    writeOrderDetailsForSeller({
      "addressId": addresId,
      "totalAmount": totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productId": sharedPreferences!.getStringList("userCart"),
      "paymentDetails": "Online Payment",
      "orderTime": orderId,
      "isSucess": true,
      "sellerUid": sellerUid,
      "riderUid": "",
      "status": "normal",
      "orderid": orderId,
    });
  }

  writeOrderDetailsForUser(Map<String, dynamic> dataMap) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("orders")
        .doc(dataMap["orderId"])
        .set(dataMap);
  }

  writeOrderDetailsForSeller(Map<String, dynamic> dataMap) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(dataMap["orderId"])
        .set(dataMap);
  }

  retieveNewOrders() {
    return FirebaseFirestore.instance
        .collection("orders")
        .where("status", isEqualTo: "normal")
        .orderBy("orderTime", descending: true)
        .snapshots();
  }

  retievePickedOrders() {
    return FirebaseFirestore.instance
        .collection("orders")
        .where("riderUid",isEqualTo: sharedPreferences!.getString("uid"))
        .where("status", isEqualTo: "picking")
        .orderBy("orderTime", descending: true)
        .snapshots();
  }

  retieveNotYetDeliveredOrders() {
    return FirebaseFirestore.instance
        .collection("orders")
        .where("riderUid",isEqualTo: sharedPreferences!.getString("uid"))
        .where("status", isEqualTo: "delivering")
        .orderBy("orderTime", descending: true)
        .snapshots();
  }


  retieveHistoryOrders() {
    return FirebaseFirestore.instance
        .collection("orders")
        .where("riderUid",isEqualTo: sharedPreferences!.getString("uid"))
        .where("status", isEqualTo: "ended")
        .orderBy("orderTime", descending: true)
        .snapshots();
  }




  separateItemIDsForOrder(orderIDs) {
    List<String> separateItemIDsList = [], defaultItemList = [];
    int i = 0;

    defaultItemList = List<String>.from(orderIDs);

    for (i; i < defaultItemList.length; i++) {
      //56557657:7
      String item = defaultItemList[i].toString();
      var pos = item.lastIndexOf(":");

      //56557657
      String getItemId = (pos != -1) ? item.substring(0, pos) : item;

      separateItemIDsList.add(getItemId);
    }

    return separateItemIDsList;
  }

  separateItemQuantitiesForOrder(orderIDs) {
    List<String> separateItemQuantityList = [];
    List<String> defaultItemList = [];
    int i = 1;

    defaultItemList = List<String>.from(orderIDs);

    for (i; i < defaultItemList.length; i++) {
      //56557657:7
      String item = defaultItemList[i].toString();

      //0=:
      //1=7
      //:7
      List<String> listItemCharacters = item.split(":").toList();

      //7
      var quanNumber = int.parse(listItemCharacters[1].toString());

      separateItemQuantityList.add(quanNumber.toString());
    }

    return separateItemQuantityList;
  }

  getSpecificOrder(String orderId) {
    return FirebaseFirestore.instance.collection("orders").doc(orderId).get();
  }

  getShipmentAddress(String addresId, String orderByUserId) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(orderByUserId)
        .collection("userAddress")
        .doc(addresId)
        .get();
  }

  confirmToDeliverParcel(
      orderId, sellerId, orderByUser, completeAddress, context, Address model) {
    FirebaseFirestore.instance.collection("orders").doc(orderId).update({
      "riderUid": sharedPreferences!.getString("uid"),
      "riderName": sharedPreferences!.getString("name"),
      "status": "picking",
      "lat": position!.latitude,
      "lng": position!.longitude,
      "address": completeAddress,
    }).then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ParcelPickingScreen(
              purchaseId: orderByUser,
              purchaseAddress: model.fullAddress,
              purchaserLat: model.lat,
              purchaserLng: model.lng,
              sellerId: sellerId,
              getOrderId: orderId,
            ),
          ));
    });
  }

  confirmParcelHasBeenPicked(getOrderId, sellerId, purchaserId, purchaseAddress,
      purchaserLat, purchaserLng, completeAddress, context) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(getOrderId)
        .update({
      "status": "delivering",
      "adddress": completeAddress,
      "lat": position!.latitude,
      "lng": position!.longitude,
    });

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParcelDeliveringScreen(
            purchaserId: purchaserId,
            purchaseAddress: purchaseAddress,
            purchaserLat: purchaserLng,
            purchaserLng: purchaserLng,
            sellerId: sellerId,
            getOrderId: getOrderId,
          ),
        ));
  }

  confirmParcelHasBeenDelivered(
    getOrderId,
    sellerId,
    purchaserId,
    purchaserAddress,
    purchaserLat,
    purchaserLng,
    completeAddress,
    context
  ) async{

    String totalEarningOfRider = ((double.parse(previousRiderEarnings)) + (double.parse(amountChargedPerDelivery))).toString();
    String totalEarningOfSeller = ((double.parse(previousSellerEarnings)) + (double.parse(orderTotalAmount))).toString();

    await FirebaseFirestore.instance
        .collection("orders")
        .doc(getOrderId)
        .update(
        {
          "status": "ended",
          "address": completeAddress,
          "lat": position!.latitude,
          "lng": position!.longitude,
          "deliveryAmount": amountChargedPerDelivery,
        }).then((value) async
    {
      await FirebaseFirestore.instance
          .collection("riders")
          .doc(sharedPreferences!.getString("uid"))
          .update(
          {
            "earnings": totalEarningOfRider,
          }).then((value) async
      {
        await FirebaseFirestore.instance
            .collection("sellers")
            .doc(sellerId).update(
            {
              "earnings": totalEarningOfSeller,
            }).then((value) async
        {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(purchaserId)
              .collection("orders")
              .doc(getOrderId).update(
              {
                "status": "ended",
                "riderUid": sharedPreferences!.getString("uid"),
              });
        });
      });
    });
    commonViewModel.showSnackBar("Order Delivered successfully", context);
     Navigator.push(context, MaterialPageRoute(builder: (context) =>  const HomeScreen(),));
  }

  launchMapFromSourceToDestination(sourceLat, sourceLng,destinationLat,destinationLng) async {
    String mapOptions = [
      'saddr=$sourceLat,$sourceLng',
      'daddr=$destinationLat,$destinationLng',
      'dir_action=navigate'
    ].join('&');

    final googleMapUrl = 'https://www.google.com/maps?$mapOptions';

    if(await launchUrl(Uri.parse(googleMapUrl))){
      await launchUrl(Uri.parse(googleMapUrl));
    }else{
      throw "could not open in google maps";
    }
  }
}
