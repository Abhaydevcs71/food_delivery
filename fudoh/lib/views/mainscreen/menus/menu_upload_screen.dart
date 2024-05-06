import 'dart:io';


import 'package:flutter/material.dart';
import 'package:fudoh/constants/app_colors.dart';
import 'package:fudoh/global/global_instance.dart';
import 'package:fudoh/global/global_vars.dart';
import 'package:fudoh/widgets/my_appbar.dart';

class MenuUploadScreen extends StatefulWidget {
  const MenuUploadScreen({super.key});

  @override
  State<MenuUploadScreen> createState() => _MenuUploadScreenState();
}

class _MenuUploadScreenState extends State<MenuUploadScreen> {

  TextEditingController infoTextEditingController = TextEditingController();
  String menuTitleCategoryName = "";
  


  defaultScreen() {
    return Scaffold(
      appBar: MyAppBar(
        titleMsg: "Add New Menu",
        showBackButton: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shop_two,
              color: kBlackColor,
              size: 200,
            ),
            ElevatedButton(
                onPressed: () async {
                  String response =
                      await commonViewModel.showDialogWithImageOption(context);

                  if (response == "Selected") {
                    setState(() {
                      imageFile;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: kBlackColor),
                child: Text(
                  "Add New Menu",
                  style: TextStyle(
                    fontSize: 16,
                    color: kWhiteColor,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  uploadMenuFormScreen() {
    return Scaffold(
      appBar: MyAppBar(titleMsg: "Uploading New Menu", showBackButton: true),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kBlackColor,
        onPressed: () {
          setState(() {
            imageFile = null;
            menuTitleCategoryName = "";
            infoTextEditingController.clear();
          });
        },
        child: Icon(
          Icons.close,
          color: kWhiteColor,
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: FileImage(File(imageFile!.path)),
                    fit: BoxFit.cover,
                  )),
                ),
              ),
            ),
          ),
          Divider(
            color: kGreyColor,
            thickness: 1,
          ),
          const SizedBox(height: 10,),

          ListTile(
            leading: Icon(Icons.perm_device_information,color: kBlackColor,),
            title: TextField(
              style: TextStyle(color: kBlackColor),
              maxLines: 1,
              controller: infoTextEditingController,
              decoration: InputDecoration(
                hintText: "menu info",
                hintStyle: TextStyle(color: kGreyColor),
                border: InputBorder.none,
              ),
            ),
          ),
          Divider(
            color: kGreyColor,
            thickness: 1,
          ),

          Padding(padding: const EdgeInsets.all(26.0),
          child: DropdownButtonFormField(
            hint: Text("Select Category",style: TextStyle(
              color: kBlackColor
            ),),
            items: categoryList.map<DropdownMenuItem<String>>((categoryName) {
              return DropdownMenuItem(
                value: categoryName,
                child: Text(categoryName));
            }).toList(), 
            
            onChanged: (value){
              setState(() {
                menuTitleCategoryName = value.toString();
              });
              commonViewModel.showSnackBar(menuTitleCategoryName, context);
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ElevatedButton(onPressed: () async{
            await  menuViewModel.validateMenuUploadForm(
                infoTextEditingController.text,
                menuTitleCategoryName,
                context
              );
              setState(() {
                imageFile = null;
              });
            }, 
            style: ElevatedButton.styleFrom(
              backgroundColor: kBlackColor,
            ),
            child: Text("Upload",style: TextStyle(color: kWhiteColor),)),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
   
    super.initState();
    menuViewModel.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return  imageFile == null ? defaultScreen() : uploadMenuFormScreen();
  }
}
