import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/constants/app_colors.dart';
import 'package:user_app/global/global_instance.dart';
import 'package:user_app/model/menus.dart';
import 'package:user_app/model/seller.dart';
import 'package:user_app/provider/cart_item_counter.dart';
import 'package:user_app/views/mainscreen/cart_screen.dart';
import 'package:user_app/views/mainscreen/homescreen.dart';
import 'package:user_app/widgets/menu_ui_design.dart';

class MenuScreen extends StatelessWidget {
  Seller? sellerModel;
   MenuScreen({super.key,this.sellerModel,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kcPrimaryColor,
          leading: IconButton(onPressed: () {

            //clear cart //

            //
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
          }, icon: const Icon(Icons.arrow_back)),
          title: Text("${sellerModel!.name}'s Menu"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
        Stack(
          children: [
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(sellerUid : sellerModel!.uid),));
            }, icon: Icon(Icons.shopping_cart,color: kcSecondaryColor,)),

            Positioned(child: Stack(
              children: [
                Icon(Icons.brightness_1,
                size: 20,
                color: kcPrimaryColor,),
                Positioned(
                  top: 3,
                  right: 4,
                  child: Center(
                    child: Consumer<CartItemCounter>(
                      builder: (context, counter, child) {
                        return  Text(counter.count.toString(),
                    style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 12,
                    ),
                    );
                      },
                    ),
                  ))
              ],
            ))
          ],
        )
      ],
        ),
       
        body: StreamBuilder<QuerySnapshot>(stream: menuViewModel.retrieveMenuFromFirestore(sellerModel!.uid!),
        builder: (context, snapshot) {
          return !snapshot.hasData ? const Center(child: Text("No Data Available"),
         
          )
           :
          ListView.builder(
            itemCount: snapshot.data!.docs.length,
            
            itemBuilder: (context, index) {
             // log.i(snapshot.data!.docs.length);
            Menu menuModel = Menu.fromJson(
              snapshot.data!.docs[index].data()! as Map<String , dynamic>
            );
            return Card(
              elevation: 6,
              color: kBlackColor,
              child: MenuUiDesign(
                menuModel: menuModel,
              ),
            );
          },);
        },
        ),
        );
  }
}
