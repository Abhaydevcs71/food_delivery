import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_app/constants/app_colors.dart';
import 'package:user_app/model/item.dart';
import 'package:user_app/views/mainscreen/order_details_screen.dart';

class OrderCardUiDesign extends StatelessWidget {

  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final String? orderId;
  final List<String>? seperateQuantitiesList;

   const OrderCardUiDesign({super.key, this.itemCount, this.data, this.orderId, this.seperateQuantitiesList});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailsScreen(orderId: orderId,),));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        height: itemCount! * 125,
        child: ListView.builder(
          itemCount: itemCount,
          itemBuilder: (context, index) {
          Item model = Item.fromJson(data![index].data()! as Map<String, dynamic>);

          return placeOrderDesignWidget(model, context, seperateQuantitiesList![index]);
        },),
      ),
    );
  }
}


Widget placeOrderDesignWidget(Item model, BuildContext context,String quantitieNumber){

  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 120,
    child: Row(
      children: [
        Image.network(model.itemImage!,width: 120,),
        const SizedBox.shrink(),
         Expanded(child: Column(
          children: [
            const SizedBox(height: 20,),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(child: Text(
                  model.itemTitle!,
                  style: TextStyle(
                    color: kGreyColor,
                    fontSize: 16,
                  ),
                )),
                const SizedBox(width: 10,),
                const Text("₹ ",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue
                ),
                ),
                Text(model.price!.toString(),
                style: TextStyle(
                  color: kBlackColor,
                  fontSize: 18,
                ),
                )
              ],
            ),
            const SizedBox(height: 20,),

            Row(
              children: [
                Text("x ",
                style: TextStyle(
                  color: kBlackColor,
                  fontSize: 14,
                ),
                ),
                Expanded(child: Text(quantitieNumber,
                style: TextStyle(
                  color: kBlackColor,
                  fontSize: 30,
                ),
                ))
              ],
            )
          ],
        ))
      ],
    ),
  );
}