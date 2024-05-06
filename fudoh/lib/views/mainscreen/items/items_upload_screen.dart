import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fudoh/constants/app_colors.dart';
import 'package:fudoh/global/global_instance.dart';
import 'package:fudoh/global/global_vars.dart';
import 'package:fudoh/model/menus.dart';
import 'package:fudoh/widgets/my_appbar.dart';

class ItemsUploadScreen extends StatefulWidget {
  Menu? menuModel;
  ItemsUploadScreen({super.key, this.menuModel});

  @override
  State<ItemsUploadScreen> createState() => _MenuUploadScreenState();
}

class _MenuUploadScreenState extends State<ItemsUploadScreen> {
  TextEditingController infoTextEditingController = TextEditingController();
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  TextEditingController priceTextEditingController = TextEditingController();

  defaultScreen() {
    return Scaffold(
      appBar: MyAppBar(
        titleMsg: "Add New Item",
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
                  "Add New Item",
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

  uploadItemFormScreen() {
    return Scaffold(
      appBar: MyAppBar(titleMsg: "Uploading New Item", showBackButton: true),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kBlackColor,
        onPressed: () {
          setState(() {
            imageFile = null;
            infoTextEditingController.clear();
            titleTextEditingController.clear();
            priceTextEditingController.clear();
            descriptionTextEditingController.clear();
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
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: kBlackColor,
            ),
            title: TextField(
              style: TextStyle(color: kBlackColor),
              maxLines: 1,
              controller: infoTextEditingController,
              decoration: InputDecoration(
                hintText: "Item info",
                hintStyle: TextStyle(color: kGreyColor),
                border: InputBorder.none,
              ),
            ),
          ),
          Divider(
            color: kGreyColor,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.title,
              color: kBlackColor,
            ),
            title: TextField(
              style: TextStyle(color: kBlackColor),
              maxLines: 1,
              controller: titleTextEditingController,
              decoration: InputDecoration(
                hintText: "Item title",
                hintStyle: TextStyle(color: kGreyColor),
                border: InputBorder.none,
              ),
            ),
          ),
          Divider(
            color: kGreyColor,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.description,
              color: kBlackColor,
            ),
            title: TextField(
              style: TextStyle(color: kBlackColor),
              maxLines: 1,
              controller: descriptionTextEditingController,
              decoration: InputDecoration(
                hintText: "Item description",
                hintStyle: TextStyle(color: kGreyColor),
                border: InputBorder.none,
              ),
            ),
          ),
          Divider(
            color: kGreyColor,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.price_change,
              color: kBlackColor,
            ),
            title: TextField(
              keyboardType: TextInputType.number,
              style: TextStyle(color: kBlackColor),
              maxLines: 1,
              controller: priceTextEditingController,
              decoration: InputDecoration(
                hintText: "Item price",
                hintStyle: TextStyle(color: kGreyColor),
                border: InputBorder.none,
              ),
            ),
          ),
          Divider(
            color: kGreyColor,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ElevatedButton(
                onPressed: () async {
                 await itemViewModel.validateItemUploadForm(
                    infoTextEditingController.text.trim(),
                    titleTextEditingController.text.trim(),
                    descriptionTextEditingController.text.trim(),
                    priceTextEditingController.text.trim(),
                    widget.menuModel!,
                    context,
                  );
                  setState(() {
                    imageFile = null;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kBlackColor,
                ),
                child: Text(
                  "Upload",
                  style: TextStyle(color: kWhiteColor),
                )),
          ),
          const SizedBox(
            height: 90,
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
    return imageFile == null ? defaultScreen() : uploadItemFormScreen();
  }
}
