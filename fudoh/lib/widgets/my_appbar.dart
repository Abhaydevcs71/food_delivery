
import 'package:flutter/material.dart';
import 'package:fudoh/global/global_vars.dart';
import 'package:fudoh/views/mainscreen/homescreen.dart';

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
      centerTitle: true,
      automaticallyImplyLeading: showBackButton,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.deepOrange,
            Colors.purple,
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        )),
      ),
      leading: showBackButton == true
          ? IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                      
                    ));
                    imageFile = null;
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
