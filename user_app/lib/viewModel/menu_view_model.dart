import 'package:cloud_firestore/cloud_firestore.dart';

class MenuViewModel {
  retrieveMenuFromFirestore(String sellerUid) {
    return FirebaseFirestore.instance
        .collection("sellers")
        .doc(sellerUid)
        .collection("menus")
        .orderBy("publishedDateTime", descending: true)
        .snapshots();
  }
}
