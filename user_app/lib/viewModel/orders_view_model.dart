import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_app/global/global_vars.dart';

class OrderViewModel {
  String orderId = DateTime.now().microsecondsSinceEpoch.toString();

  saveOrderDetailsToDatabase(addresId, totalAmount, sellerUid, orderId) {
    writeOrderDetailsForUser({
      "addressId": addresId,
      "totalAmount": totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productId": sharedPreferences!.getStringList("userCart"),
      "paymentDetails": "Online Payment",
      "orderTime": orderId,
      "isSucess": true,
      "sellerUid": sellerUid,
      "riderUid": "",
      "status": "normal",
      "orderid": orderId,
    });

    writeOrderDetailsForSeller({
      "addressId": addresId,
      "totalAmount": totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productId": sharedPreferences!.getStringList("userCart"),
      "paymentDetails": "Online Payment",
      "orderTime": orderId,
      "isSucess": true,
      "sellerUid": sellerUid,
      "riderUid": "",
      "status": "normal",
      "orderid": orderId,
    });
  }

  writeOrderDetailsForUser(Map<String, dynamic> dataMap) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("orders")
        .doc(dataMap["orderId"])
        .set(dataMap);
  }

  writeOrderDetailsForSeller(Map<String, dynamic> dataMap) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(dataMap["orderId"])
        .set(dataMap);
  }

  retieveOrders() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("orders")
        .where("status", isEqualTo: "normal")
        .orderBy("orderTime", descending: true)
        .snapshots();
  }

  separateItemIDsForOrder(orderIDs) {
    List<String> separateItemIDsList = [], defaultItemList = [];
    int i = 0;

    defaultItemList = List<String>.from(orderIDs);

    for (i; i < defaultItemList.length; i++) {
      //56557657:7
      String item = defaultItemList[i].toString();
      var pos = item.lastIndexOf(":");

      //56557657
      String getItemId = (pos != -1) ? item.substring(0, pos) : item;

      separateItemIDsList.add(getItemId);
    }

    return separateItemIDsList;
  }

  separateItemQuantitiesForOrder(orderIDs) {
    List<String> separateItemQuantityList = [];
    List<String> defaultItemList = [];
    int i = 1;

    defaultItemList = List<String>.from(orderIDs);

    for (i; i < defaultItemList.length; i++) {
      //56557657:7
      String item = defaultItemList[i].toString();

      //0=:
      //1=7
      //:7
      List<String> listItemCharacters = item.split(":").toList();

      //7
      var quanNumber = int.parse(listItemCharacters[1].toString());

      separateItemQuantityList.add(quanNumber.toString());
    }

    return separateItemQuantityList;
  }

  getSpecificOrder(String orderId) {
    return  FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("orders")
        .doc(orderId)
        .get();
  }

  getShipmentAddress(String addresId) {
    return  FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("userAddress")
        .doc(addresId)
        .get();
  }
}
