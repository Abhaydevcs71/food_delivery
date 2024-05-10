
import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String? menuId;
  String? menuName;
  String? itemId;
  String? sellerUid;
  String? sellerName;
  String? itemInfo;
  String? itemTitle;
  String? itemImage;
  String? description;
  int? price;
  Timestamp? publishedDateTime;
  String? status;
  bool? isRecommended;
  bool? isPopular;

  Item(
      {this.menuId,
      this.menuName,
      this.itemId,
      this.sellerUid,
      this.sellerName,
      this.itemInfo,
      this.itemTitle,
      this.itemImage,
      this.description,
      this.price,
      this.publishedDateTime,
      this.status,
      this.isRecommended,
      this.isPopular});

      Item.fromJson(Map<String ,dynamic >json){
        menuId=json["menuId"];
        menuName=json["menuName"];
        itemId=json["itemId"];
        sellerUid=json["sellerUid"];
        sellerName=json["sellerName"];
        itemInfo=json["itemInfo"];
        itemTitle=json["itemTitle"];
        itemImage=json["itemImage"];
        description=json["description"];
        price=json["price"];
        publishedDateTime=json["publishedDateTime"];
        status=json["status"];
        isRecommended=json["isRecommended"];
        isPopular=json["isPopular"];
      }
}
