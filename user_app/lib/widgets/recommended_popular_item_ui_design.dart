import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_app/global/global_instance.dart';
import 'package:user_app/model/item.dart';
import 'package:user_app/model/menus.dart';
import 'package:user_app/views/mainscreen/item_details_screen.dart';
import 'package:user_app/views/mainscreen/items_screen.dart';

class RecomPopUiDesign extends StatefulWidget {
  Item? itemModel;
  RecomPopUiDesign({super.key, this.itemModel});

  @override
  State<RecomPopUiDesign> createState() => _MenuUiDesignState();
}

class _MenuUiDesignState extends State<RecomPopUiDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        cartViewModel.clearCartNow(context);

        Menu menuModel = Menu();

        await FirebaseFirestore.instance
            .collection("sellers")
            .doc(widget.itemModel!.sellerUid)
            .collection("menus")
            .doc(widget.itemModel!.menuId)
            .get()
            .then((snapshot) {
          menuModel.menuId = snapshot.data()!["menuId"];
          menuModel.sellerUid = snapshot.data()!["sellerUid"];
          menuModel.sellerName = snapshot.data()!["sellerName"];
          menuModel.menuTitle = snapshot.data()!["menuTitle"];
          menuModel.menuInfo = snapshot.data()!["menuInfo"];
          menuModel.menuImage = snapshot.data()!["menuImage"];
          menuModel.publishedDateTime = snapshot.data()!["publishedDateTime"];
          menuModel.status = snapshot.data()!["status"];

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ItemsScreen(
                        menuModel: menuModel,
                        value: "rp",
                      )));
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Image.network(
                widget.itemModel!.itemImage.toString(),
                width: MediaQuery.of(context).size.width,
                height: 210,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.itemModel!.itemTitle.toString(),
                style: const TextStyle(
                  color: Colors.cyan,
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
