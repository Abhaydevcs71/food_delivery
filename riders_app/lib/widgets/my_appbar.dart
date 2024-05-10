
import 'package:flutter/material.dart';
import 'package:riders_app/constants/app_colors.dart';
import 'package:riders_app/views/homescreen/homescreen.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  String titleMsg;
  bool showBackButton;
  PreferredSizeWidget? bottom;
  MyAppBar(
      {super.key,
      required this.titleMsg,
      required this.showBackButton,
      this.bottom});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kcPrimaryColor,
      centerTitle: true,
      automaticallyImplyLeading: showBackButton,
      
      leading: showBackButton == true
          ? IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              },
              icon: const Icon(
                Icons.arrow_back,
              ))
          : showBackButton == false ?  IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
              )): Container(),
      title: Text(
        titleMsg,
        style: const TextStyle(fontSize: 20, letterSpacing: 3),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => bottom == null
      ? Size(57, AppBar().preferredSize.height)
      : Size(57, 80 + AppBar().preferredSize.height);
}
