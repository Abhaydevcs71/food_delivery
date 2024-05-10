import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:riders_app/constants/app_colors.dart';
import 'package:riders_app/global/global_instance.dart';
import 'package:riders_app/global/global_vars.dart';

class ParcelPickingScreen extends StatefulWidget {
  String? purchaseId;
  String? sellerId;
  String? getOrderId;
  String? purchaseAddress;
  double? purchaserLat;
  double? purchaserLng;

  ParcelPickingScreen({
    super.key,
    this.purchaseId,
    this.sellerId,
    this.getOrderId,
    this.purchaseAddress,
    this.purchaserLat,
    this.purchaserLng,
  });

  @override
  State<ParcelPickingScreen> createState() => _ParcelPickingScreenState();
}

class _ParcelPickingScreenState extends State<ParcelPickingScreen> {
  double? sellerLat, sellerLng;

  getSellerData() async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(widget.sellerId)
        .get()
        .then((snapshot) {
      sellerLat = snapshot.data()!["latitude"];
      sellerLng = snapshot.data()!["longitude"];
    });
  }

  @override
  void initState() {
    super.initState();
    getSellerData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/confirm1.png",
            width: 350,
          ),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {

              //rider location to seller location
              
              orderViewModel.launchMapFromSourceToDestination(
                position!.latitude,
                position!.longitude,
                sellerLat,
                sellerLng,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/restaurant.png",
                  width: 50,
                ),
                const SizedBox(
                  width: 7,
                ),
                Text(
                  "Show Cafe / Restaurant Location",
                  style: TextStyle(
                      color: kBlackColor, fontSize: 18, letterSpacing: 2),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: InkWell(
                onTap: () async {
                  String completeAddress =
                      await commonViewModel.getCurrentLocation();

                  orderViewModel.confirmParcelHasBeenPicked(
                      widget.getOrderId,
                      widget.sellerId,
                      widget.purchaseId,
                      widget.purchaseAddress,
                      widget.purchaserLat,
                      widget.purchaserLng,
                      completeAddress,
                      context);
                },
                child: Container(
                  color: kWhiteColor,
                  width: MediaQuery.of(context).size.width - 90,
                  height: 50,
                  child: const Center(
                    child: Text(
                      "Order has been Picked - Confirmed",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
