import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user_app/constants/app_colors.dart';
import 'package:user_app/global/global_instance.dart';
import 'package:user_app/model/address.dart';
import 'package:user_app/widgets/shipment_address_ui_design.dart';
import 'package:user_app/widgets/status_banner.dart';

class OrderDetailsScreen extends StatefulWidget {

  String? orderId;
   OrderDetailsScreen({super.key,this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {

  String orderStatus = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: kGreyColor,
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
          future: orderViewModel.getSpecificOrder(widget.orderId.toString()), 
          builder: (context, snapshot) {
            Map? dataMap;

            if(snapshot.hasData){
              dataMap = snapshot.data!.data() as Map<String , dynamic>;

              orderStatus = dataMap["status"].toString();
            }

            return snapshot.hasData 
            ? Column(
              children: [
                const SizedBox(height: 30,),
                StatusBanner(
                  status: dataMap!["isSucess"],
                  orderStatus: orderStatus,
                ),

                const SizedBox(height: 10,),

                Padding(padding: const EdgeInsets.all(8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("₹ ${dataMap["totalAmount"]}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ),
                ),

                Padding(padding: const EdgeInsets.all(8),
                child: Text("Order at: ${DateFormat('dd MMMM,yyyy - hh:mm aa').format(
                  DateTime.fromMillisecondsSinceEpoch(int.parse(dataMap["orderTime"]))
                )}",
                style: TextStyle(fontSize: 16,color: kGreyColor),
                ),
                ),
                const Divider(thickness: 4,),

                orderStatus == "ended"
                ? Image.asset("assets/images/delivered.jpg")
                : Image.asset("assets/images/state.jpg"),

                const Divider(thickness: 4,),

                FutureBuilder<DocumentSnapshot>(
                  future: orderViewModel.getShipmentAddress(dataMap["addressId"]), 
                  builder: (context, snapshotAddress) {
                    return snapshotAddress.hasData 
                    ? ShipmentAddressUiDesign(model: Address.fromJson(
                      snapshotAddress.data!.data() as Map<String, dynamic>
                    ),)
                    : const CircularProgressIndicator();
                  },)

              ],
            )
            : const Center(child: CircularProgressIndicator(),);
          },),
      ),
    );
  }
}