

import 'package:admin_web_panel/global/global_vars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CategoryViewModel{


  //image upload to firebase storage

  uploadImageToStorage() async{

    imageDocId = DateTime.now().millisecondsSinceEpoch.toString() + fileName.toString();
    Reference bannersRef = FirebaseStorage.instance.ref().child("categoryImages").child(imageDocId);

    UploadTask uploadTask =bannersRef.putData(imageFile);

    TaskSnapshot
     taskSnapshot = await uploadTask.whenComplete(() {});

     String downloadUrl = await taskSnapshot.ref.getDownloadURL();

     return downloadUrl;
  }

  //save image to firesrtore

  saveCategoryInfoToFirestore() async{

    String downloadUrl = await uploadImageToStorage();
    await FirebaseFirestore.instance.collection("category").doc(imageDocId).set({
      "image" : downloadUrl,
      "name": categoryName,
    });
  }

  // get banner data from firestore

  readCategoryFromFirestore(){
    Stream<QuerySnapshot> bannerStreamQuerySnapshot = FirebaseFirestore.instance.collection("category").snapshots();

    return bannerStreamQuerySnapshot;
  }
}