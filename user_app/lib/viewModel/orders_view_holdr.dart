
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_app/global/global_vars.dart';

class OrderViewHolder{

  String orderId = DateTime.now().microsecondsSinceEpoch.toString();

  saveOrderDetailsToDatabase(addresId,totalAmount,sellerUid){

    

    writeOrderDetailsForUser({
      "addressId":addresId,
      "totalAmount":totalAmount,
      "orderBy":sharedPreferences!.getString("uid"),
      "productId":sharedPreferences!.getStringList("userCart"),
      "paymentDetails":"Online Payment",
      "orderTime":orderId,
      "isSucess":true,
      "sellerUid":sellerUid,
      "riderUid":"",
      "status":"normal",
      "orderid":orderId,
    });

    writeOrderDetailsForSeller({
      "addressId":addresId,
      "totalAmount":totalAmount,
      "orderBy":sharedPreferences!.getString("uid"),
      "productId":sharedPreferences!.getStringList("userCart"),
      "paymentDetails":"Online Payment",
      "orderTime":orderId,
      "isSucess":true,
      "sellerUid":sellerUid,
      "riderUid":"",
      "status":"normal",
      "orderid":orderId,
    });
  }

  writeOrderDetailsForUser(Map<String,dynamic>dataMap) async {
  await  FirebaseFirestore.instance.collection("users")
    .doc(sharedPreferences!.getString("uid"))
    .collection("orders")
    .doc(orderId).set(dataMap);
  }

  writeOrderDetailsForSeller(Map<String,dynamic>dataMap) async {
   await FirebaseFirestore.instance.collection("orders")
    .doc(orderId).set(dataMap);
  }
}