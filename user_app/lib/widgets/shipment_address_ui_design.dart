import 'package:flutter/material.dart';
import 'package:user_app/constants/app_colors.dart';
import 'package:user_app/model/address.dart';
import 'package:user_app/views/mainscreen/homescreen.dart';

class ShipmentAddressUiDesign extends StatelessWidget {

  Address? model;
   ShipmentAddressUiDesign({super.key,this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.all(10),
        child: Text('shipping Details',
        style: TextStyle(color: kBlackColor,
        fontWeight: FontWeight.bold
        ),
        ),
        ),

        const SizedBox(height: 6,),

        Container(
          padding:  const EdgeInsets.symmetric(horizontal: 90,vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              TableRow(
                children: 
                [
                  Text("Name :",style: TextStyle(color: kBlackColor),),
                  Text(model!.name!),

                ]
              ),
              TableRow(
                children: [
                  Text("Phone Number:",
                  style: TextStyle(color: kBlackColor),),
                 
                  Text(model!.phoneNumber.toString()) 
                ]
              )
            ],
          ),
        ),

        const SizedBox(height: 20,),

        Padding(padding: const EdgeInsets.all(10),
        child: Text(model!.fullAddress!,
        textAlign: TextAlign.justify,
        ),
        ),

        Padding(padding: const EdgeInsets.all(10),
        child: Center(
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              child: Center(
                child: Text("Go Back",
                style: TextStyle(
                  color: kBlackColor,fontSize: 15
                ),
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