

import 'package:admin_web_panel/global/global_vars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class BannerViewModel{

  //image upload to firebase storage

  uploadImageToStorage() async{

    imageDocId = DateTime.now().millisecondsSinceEpoch.toString() + fileName.toString();
    Reference bannersRef = FirebaseStorage.instance.ref().child("bannerImages").child(imageDocId);

    UploadTask uploadTask =bannersRef.putData(imageFile);

    TaskSnapshot
     taskSnapshot = await uploadTask.whenComplete(() {});

     String downloadUrl = await taskSnapshot.ref.getDownloadURL();

     return downloadUrl;
  }

  //save image to firesrtore

  saveBannerInfoImageInfoToFirestore() async{

    String downloadUrl = await uploadImageToStorage();
    await FirebaseFirestore.instance.collection("banners").doc(imageDocId).set({
      "image" : downloadUrl,
    });
  }

  // get banner data from firestore

  readBannerFromFirestore(){
    Stream<QuerySnapshot> bannerStreamQuerySnapshot = FirebaseFirestore.instance.collection("banners").snapshots();

    return bannerStreamQuerySnapshot;
  }
}