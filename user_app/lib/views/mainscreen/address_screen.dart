

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/constants/app_colors.dart';
import 'package:user_app/global/global_instance.dart';
import 'package:user_app/model/address.dart';
import 'package:user_app/provider/address_changer.dart';
import 'package:user_app/views/mainscreen/save_address_screen.dart';
import 'package:user_app/widgets/addres_ui_design.dart';

class AddressScreen extends StatefulWidget {

  double? totalAmount;
  String? sellerUid;
   AddressScreen({super.key,this.totalAmount,this.sellerUid});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Select Address"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      floatingActionButton: FloatingActionButton.extended
      
      (onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SaveAddressScreen(),));
      }, label: const Text("Add new Address"),
      backgroundColor: kBlackColor,
      icon: Icon(Icons.add_location,color: kWhiteColor,),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(padding: const EdgeInsets.all(8),
            child: Text("Select Address",
            style: TextStyle(
              color: kBlackColor,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
            ),
            ),
          ),
          Consumer<AddressChanger>(builder: (context, address,c){
            return Flexible(child: StreamBuilder<QuerySnapshot>(stream: addressViewModel.retrieveUserShipmentAddress(), 
            builder: (context, snapshot) {
              return !snapshot.hasData 
              ? Center(child: Text("No Address",style: TextStyle(color: kWhiteColor),),)
               : snapshot.data!.docs.isEmpty ? const Center(child: Text("Please Add new address"),) 
               : ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return AddressUiDesign(
                    currentIndex: address.count,
                    value: index,
                    addressId: snapshot.data!.docs[index].id,
                    totalAmount: widget.totalAmount,
                    sellerUid: widget.sellerUid,
                    model: Address.fromJson(snapshot.data!.docs[index].data()! as Map<String , dynamic>),
                  );
                },);
            },));
          },),
        ],
      ),
    );
  }
}