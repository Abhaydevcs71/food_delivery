import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/constants/app_colors.dart';
import 'package:user_app/global/global_instance.dart';
import 'package:user_app/model/address.dart';
import 'package:user_app/provider/address_changer.dart';
import 'package:user_app/provider/total_amount.dart';
import 'package:user_app/views/mainscreen/place_order_screen.dart';

class AddressUiDesign extends StatefulWidget {
  final Address? model;
  final int? currentIndex;
  final int? value;
  final String? addressId;
  final double? totalAmount;
  final String? sellerUid;
  AddressUiDesign({super.key, this.model, this.currentIndex, this.value, this.addressId, this.totalAmount, this.sellerUid});

  @override
  State<AddressUiDesign> createState() => _AddressUiDesignState();
}

class _AddressUiDesignState extends State<AddressUiDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<AddressChanger>(context,listen: false).displayResult(widget.value);
      },
      child: Card(
        color: kBlackColor,
        elevation: 6,
        child: Column(
          children: [
            Row(
              children: [
                Radio(value: widget.value, groupValue: widget.currentIndex,activeColor: Colors.amber ,onChanged: (val){
                  Provider.of<AddressChanger>(context,listen: false).displayResult(val);
                }),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              Text("Name:",style: TextStyle(
                                color: kWhiteColor,fontWeight: FontWeight.bold
                              ),),
                              Text(widget.model!.name.toString(),
                              style: TextStyle(
                                color: kWhiteColor,
                              ),
                              )
                            ]
                          ),
                          TableRow(
                            children: [
                              Text("Phone Number:",style: TextStyle(
                                color: kWhiteColor,fontWeight: FontWeight.bold
                              ),),
                              Text(widget.model!.phoneNumber.toString(),
                              style: TextStyle(
                                color: kWhiteColor,
                              ),
                              )
                            ]
                          ),
                          TableRow(
                            children: [
                              Text("Flat Number:",style: TextStyle(
                                color: kWhiteColor,fontWeight: FontWeight.bold
                              ),),
                              Text(widget.model!.flatNumber.toString(),
                              style: TextStyle(
                                color: kWhiteColor,
                              ),
                              )
                            ]
                          ),
                          TableRow(
                            children: [
                              Text("City:",style: TextStyle(
                                color: kWhiteColor,fontWeight: FontWeight.bold
                              ),),
                              Text(widget.model!.city.toString(),
                              style: TextStyle(
                                color: kWhiteColor,
                              ),
                              )
                            ]
                          ),
                          TableRow(
                            children: [
                              Text("State:",style: TextStyle(
                                color: kWhiteColor,fontWeight: FontWeight.bold
                              ),),
                              Text(widget.model!.state.toString(),
                              style: TextStyle(
                                color: kWhiteColor,
                              ),
                              )
                            ]
                          ),
                          TableRow(
                            children: [
                              Text("Full Address:",style: TextStyle(
                                color: kWhiteColor,fontWeight: FontWeight.bold
                              ),),
                              Text(widget.model!.fullAddress.toString(),
                              style: TextStyle(
                                color: kWhiteColor,
                              ),
                              )
                            ]
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kBlackColor
              ),
              onPressed: () {
              addressViewModel.openGoogleMapWithGeoGraphicPosition(widget.model!.lat!, widget.model!.lng!);
            }, child: const Text("check on maps")),

            widget.value == Provider.of<AddressChanger>(context).count ?
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kWhiteColor
                ),
                onPressed: () {
                  log.i("Total amount : ${widget.totalAmount.toString()}");
                Navigator.push(context, MaterialPageRoute(builder: (context) => PlaceOrderScreen(
                  addressId: widget.addressId,
                  totalAmount: widget.totalAmount,
                  sellerUid: widget.sellerUid,
                ),));
              }, child: const Text("proceed")),
            )
            : Container()
          ],
        ),
      ),
    );
  }
}