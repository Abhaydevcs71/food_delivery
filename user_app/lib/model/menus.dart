import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  String? menuId;
  String? sellerUid;
  String? sellerName;
  String? menuTitle;
  String? menuInfo;
  String? menuImage;
  Timestamp? publishedDateTime;
  String? status;

  Menu({
    this.menuId,
    this.sellerUid,
    this.sellerName,
    this.menuTitle,
    this.menuInfo,
    this.menuImage,
    this.publishedDateTime,
    this.status,
  });

  Menu.fromJson(Map<String , dynamic>json){
    menuId = json["menuId"];
    sellerUid=json["sellerUid"];
    sellerName= json["sellerName"];
    menuTitle= json["menuTitle"];
    menuInfo= json["menuInfo"];
    menuImage=json["menuImage"];
    publishedDateTime=json["publishedDateTime"];
    status=json["status"];
  }
}
