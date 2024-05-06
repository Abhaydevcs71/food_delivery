import 'package:cloud_firestore/cloud_firestore.dart';

class HomeViewModel {
  readBannersFromFirestore() async {
    List bannerList = [];

    await FirebaseFirestore.instance
        .collection("banners")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((document) {
        bannerList.add(document["image"]);
      });
    });
    return bannerList;
  }

  readCategoriesFromFirestore() async {
    List categoryList = [];

    await FirebaseFirestore.instance
        .collection("category")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((document) {
        categoryList.add(document["name"]);
      });
    });
    return categoryList;
  }

  readRecommendedItemsFromFirestore() {
    return FirebaseFirestore.instance
        .collection("items")
        .where("isRecommended", isEqualTo: true)
        .snapshots();
  }


  readPopularItemsFromFirestore() {
    return FirebaseFirestore.instance
        .collection("items")
        .where("isPopular", isEqualTo: true)
        .snapshots();
  }
  readSellersFromFirestore() {
    return FirebaseFirestore.instance
        .collection("sellers")
        .snapshots();
  }
}
