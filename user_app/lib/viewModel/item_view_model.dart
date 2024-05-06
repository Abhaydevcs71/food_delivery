import 'package:cloud_firestore/cloud_firestore.dart';

class ItemViewModel {
  retrieveItemsFromFirestore(String sellerUid, String menuId) {
    return FirebaseFirestore.instance
        .collection("sellers")
        .doc(sellerUid)
        .collection("menus")
        .doc(menuId)
        .collection("items")
        .orderBy("publishedDateTime", descending: true)
        .snapshots();
  }
}
