
import 'package:flutter/material.dart';
import 'package:riders_app/constants/app_colors.dart';
import 'package:riders_app/global/global_instance.dart';
import 'package:riders_app/model/address.dart';
import 'package:riders_app/views/homescreen/homescreen.dart';

class ShipmentAddressUiDesign extends StatelessWidget {
  Address? model;
  String? orderStatus;
  String? orderId;
  String? sellerId;
  String? orderByUser;
  ShipmentAddressUiDesign({
    super.key,
    this.model,
    this.orderStatus,
    this.orderId,
    this.sellerId,
    this.orderByUser,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            'shipping Details',
            style: TextStyle(color: kBlackColor, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              TableRow(children: [
                Text(
                  "Name :",
                  style: TextStyle(color: kBlackColor),
                ),
                Text(model!.name!),
              ]),
              TableRow(children: [
                Text(
                  "Phone Number:",
                  style: TextStyle(color: kBlackColor),
                ),
                Text(model!.phoneNumber.toString())
              ])
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            model!.fullAddress!,
            textAlign: TextAlign.justify,
          ),
        ),
        orderStatus == "ended"
            ? Container()
            : Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: InkWell(
                    onTap: () async{

                      //rider location
                      String completeAddress =
                        await  commonViewModel.getCurrentLocation();


                        //confirm to delivery
                      orderViewModel.confirmToDeliverParcel(
                        orderId,
                        sellerId,
                        orderByUser,
                        completeAddress,
                        context,
                        model!,
                      );

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const HomeScreen(),
                      //     ));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 50,
                      child: Center(
                        child: Text(
                          "Confirm - To deliver this parcel",
                          style: TextStyle(color: kBlackColor, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ));
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: Center(
                  child: Text(
                    "Go Back",
                    style: TextStyle(color: kBlackColor, fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
