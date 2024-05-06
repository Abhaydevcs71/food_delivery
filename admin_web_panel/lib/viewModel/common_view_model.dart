

import 'package:admin_web_panel/global/global_vars.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CommonViewModel{

  showSnackBar(String message,BuildContext context){
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

    pickImage() async{
    FilePickerResult? resultFilePicker = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: 
      false,
    );
    if(resultFilePicker != null){
      imageFile = resultFilePicker.files.first.bytes;
      fileName = resultFilePicker.files.first.name;
    }
  }
}