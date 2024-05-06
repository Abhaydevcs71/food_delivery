import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_app/global/global_instance.dart';
import 'package:user_app/model/item.dart';
import 'package:user_app/model/menus.dart';
import 'package:user_app/views/splashscreen/splashscreen.dart';
import 'package:user_app/widgets/item_ui_design.dart';
import 'package:user_app/widgets/my_appbar.dart';
import 'package:user_app/widgets/my_drawer.dart';

class ItemsScreen extends StatelessWidget {
  String? value;
  final Menu? menuModel;
   ItemsScreen({super.key, this.menuModel,this.value});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: Text("${menuModel!.sellerName}'s Items"),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          if(value == "rp"){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashScreen(),));

          }else{
            Navigator.pop(context);
          }
        }, icon: const Icon(Icons.arrow_back)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: itemViewModel.retrieveItemsFromFirestore(
            menuModel!.sellerUid!, menuModel!.menuId!),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? const Center(
                  child: Text("No Data Available"),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    // log.i(snapshot.data!.docs.length);
                    Item itemModel = Item.fromJson(snapshot.data!.docs[index]
                        .data()! as Map<String, dynamic>);
                    return Card(
                      elevation: 6,
                      //  color: kBlackColor,
                      child: ItemUiDesign(
                        itemModel: itemModel,
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
