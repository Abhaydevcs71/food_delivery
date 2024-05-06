import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fudoh/constants/app_colors.dart';
import 'package:fudoh/global/global_instance.dart';
import 'package:fudoh/model/item.dart';
import 'package:fudoh/model/menus.dart';
import 'package:fudoh/views/mainscreen/items/items_upload_screen.dart';
import 'package:fudoh/widgets/item_ui_design.dart';
import 'package:fudoh/widgets/my_appbar.dart';
import 'package:fudoh/widgets/my_drawer.dart';

class ItemsScreen extends StatelessWidget {
  final Menu? menuModel;
   const ItemsScreen({super.key, this.menuModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:  const MyDrawer(),
        appBar: MyAppBar(
          titleMsg: "${menuModel!.menuInfo}'s Items",
          showBackButton: true,
        ),
        floatingActionButton: 
        
        IconButton.filled(
          style: ButtonStyle(
            iconSize: const MaterialStatePropertyAll(35),
            backgroundColor: MaterialStatePropertyAll(kcPrimaryColor)
          ),
          color: kcSecondaryColor,
          iconSize: 25,
          onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  ItemsUploadScreen(menuModel: menuModel,),));
        }, icon: const Icon(Icons.add_rounded)),
        body: StreamBuilder<QuerySnapshot>(stream: itemViewModel.retrieveItems(menuModel!.menuId),
        builder: (context, snapshot) {
          return !snapshot.hasData ? const Center(child: Text("No Data Available"),
         
          )
           :
          ListView.builder(
            itemCount: snapshot.data!.docs.length,
            
            itemBuilder: (context, index) {
              
             // log.i(snapshot.data!.docs.length);
            Item itemModel = Item.fromJson(
              snapshot.data!.docs[index].data()! as Map<String , dynamic>
            );
            return Card(
              elevation: 6,
            //  color: kBlackColor,
              child: ItemUiDesign(
                itemModel: itemModel,
              ),
            );
          },);
        },
        ),
        );
  }
}
