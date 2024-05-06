import 'package:flutter/material.dart';
import 'package:user_app/global/global_vars.dart';

class CartItemCounter extends ChangeNotifier{

  int cartListItemCounter = sharedPreferences!.getStringList("userCart")!.length - 1;
  int get count => cartListItemCounter;

  showCartListItemNumber() async{
    cartListItemCounter = sharedPreferences!.getStringList("userCart")!.length -1;

    notifyListeners();
  }
}