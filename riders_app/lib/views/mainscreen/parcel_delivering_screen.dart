import 'package:flutter/material.dart';
import 'package:riders_app/constants/app_colors.dart';
import 'package:riders_app/global/global_instance.dart';
import 'package:riders_app/global/global_vars.dart';

class ParcelDeliveringScreen extends StatefulWidget {
  String? purchaserId;
  String? sellerId;
  String? getOrderId;
  String? purchaseAddress;
  double? purchaserLat;
  double? purchaserLng;
  ParcelDeliveringScreen({
    super.key,
    this.purchaserId,
    this.sellerId,
    this.getOrderId,
    this.purchaseAddress,
    this.purchaserLat,
    this.purchaserLng,
  });

  @override
  State<ParcelDeliveringScreen> createState() => _ParcelDeliveringScreenState();
}

class _ParcelDeliveringScreenState extends State<ParcelDeliveringScreen> {
  getUpdatedInfo() async {
    await commonViewModel.getRiderPreviousEarnings();
    await commonViewModel.getSellerPreviousEarnings(widget.sellerId.toString());
    await commonViewModel.getOrderTotalAmount(widget.getOrderId.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUpdatedInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/confirm2.png"),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {

              // rider location to delivery point

              
              orderViewModel.launchMapFromSourceToDestination(
                position!.latitude,
                position!.longitude,
                widget.purchaserLat,
                widget.purchaserLng,
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
                  "Show Delivery Drop-off Location",
                  style: TextStyle(
                      color: kBlackColor, fontSize: 18, letterSpacing: 2),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: InkWell(
                onTap: () async {
                  String completeAddress =
                      await commonViewModel.getCurrentLocation();

                  //confirm order delivered
                  await orderViewModel.confirmParcelHasBeenDelivered(
                      widget.getOrderId,
                      widget.sellerId,
                      widget.purchaserId,
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
                      "Order has been deliverd - Confirm",
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
