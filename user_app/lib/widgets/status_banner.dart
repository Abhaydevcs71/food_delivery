import 'package:flutter/material.dart';
import 'package:user_app/constants/app_colors.dart';
import 'package:user_app/views/mainscreen/homescreen.dart';

class StatusBanner extends StatelessWidget {
  bool? status;
  String? orderStatus;

   StatusBanner({super.key,this.status,this.orderStatus});

  @override
  Widget build(BuildContext context) {

    String? message;
    IconData? iconData;

    status! ? iconData = Icons.done : iconData=Icons.cancel;
    status! ? message = "Successful" : message = "Unsuccessful";
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 10,),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
            },
            child:  Icon(Icons.arrow_back,
            color: kBlackColor,
            ),
          ),

          const SizedBox(width: 20,),

          Text(
            orderStatus == "ended" ? "Parcel delivered $message" : "Order Placed $message",
            style: TextStyle(
              color: kcPrimaryColor
            ),
          ),

          const SizedBox(width: 5,),

          CircleAvatar(
            radius: 8,
            backgroundColor: Colors.green,
            child: Center(
              child: Icon(iconData,
              color: Colors.white,
              size: 14,
              ),
            ),
          )

        ],
      ),
    );
  }
}