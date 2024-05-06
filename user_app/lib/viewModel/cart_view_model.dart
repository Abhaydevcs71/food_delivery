import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/global/global_instance.dart';
import 'package:user_app/global/global_vars.dart';
import 'package:user_app/provider/cart_item_counter.dart';

class CartViewModel {
  seperateItemId() {
    List<String> seperateItemIdsList = [], defaultItemList = [];
    int i = 1;

    defaultItemList = sharedPreferences!.getStringList("userCart")!;

    for (i; i < defaultItemList.length; i++) {
      String item = defaultItemList[i].toString();
      var pos = item.lastIndexOf(":");

      String getItemId = (pos != 1) ? item.substring(0, pos) : item;

      log.i("This is ItemId now = $getItemId");

      seperateItemIdsList.add(getItemId);
    }

    log.i("This is Item List now=");
    log.i(seperateItemIdsList);
    return seperateItemIdsList;
  }

  addItemTocart(String? itemId, BuildContext context, int quantityNumber) {
    List<String>? tempList = sharedPreferences!.getStringList("userCart");

    tempList!.add("${itemId!}:$quantityNumber");

    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "userCart": tempList,
    }).then((value) {
      sharedPreferences!.setStringList("userCart", tempList);

      commonViewModel.showSnackBar("Item Added to cart.", context);

      Provider.of<CartItemCounter>(context, listen: false)
          .showCartListItemNumber();
    });
  }

  getCartItems() {
    return  FirebaseFirestore.instance
        .collection("items")
        .where("itemId", whereIn: seperateItemId())
        .orderBy("publishedDateTime", descending: true)
        .snapshots();
  }

  seperateItemQuantities(){

    List<int> seperateItemQuantityList = [];
    List<String> defaultItemList = [];
    int i = 1;

    defaultItemList = sharedPreferences!.getStringList("userCart")!;

    for(i;i<defaultItemList.length; i++){
      String item = defaultItemList[i].toString();

      List<String> listItemCharacters = item.split(":").toList();

      var quanNumber = int.parse(listItemCharacters[1].toString());

      seperateItemQuantityList.add(quanNumber);
    }

    return seperateItemQuantityList;
  }

  clearCartNow(BuildContext context) async{
    sharedPreferences!.setStringList("userCart",['garbageValue']);
    List<String>? emptyList = sharedPreferences!.getStringList("userCart");

   await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
      "userCart":emptyList,
    }).then((value) {
      sharedPreferences!.setStringList("userCart", emptyList!);
      Provider.of<CartItemCounter>(context,listen: false).showCartListItemNumber();
    });
  }
}
