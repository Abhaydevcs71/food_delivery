import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fudoh/constants/app_colors.dart';
import 'package:fudoh/global/global_instance.dart';
import 'package:fudoh/global/global_vars.dart';
import 'package:fudoh/model/menus.dart';
import 'package:fudoh/views/mainscreen/menus/menu_upload_screen.dart';
import 'package:fudoh/widgets/menu_ui_design.dart';
import 'package:fudoh/widgets/my_appbar.dart';
import 'package:fudoh/widgets/my_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MyDrawer(),
        appBar: MyAppBar(
          titleMsg: "${sharedPreferences!.getString("name")}'s Menu",
          showBackButton: false,
        ),
        floatingActionButton: 
        
        IconButton.filled(
          style: ButtonStyle(
            iconSize: const MaterialStatePropertyAll(35),
            backgroundColor: MaterialStatePropertyAll(kcPrimaryColor)
          ),
          color: kcSecondaryColor,
          iconSize: 25,
          onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuUploadScreen(),));
        }, icon: const Icon(Icons.add_rounded)),
        body: StreamBuilder<QuerySnapshot>(stream: menuViewModel.retriveMenus(),
        builder: (context, snapshot) {
          return !snapshot.hasData ? const Center(child: Text("No Data Available"),
         
          )
           :
          ListView.builder(
            itemCount: snapshot.data!.docs.length,
            
            itemBuilder: (context, index) {
             // log.i(snapshot.data!.docs.length);
            Menu menuModel = Menu.fromJson(
              snapshot.data!.docs[index].data()! as Map<String , dynamic>
            );
            return Card(
              elevation: 6,
              color: kBlackColor,
              child: MenuUiDesign(
                menuModel: menuModel,
              ),
            );
          },);
        },
        ),
        );
  }
}
