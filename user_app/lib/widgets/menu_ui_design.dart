import 'package:flutter/material.dart';
import 'package:user_app/model/menus.dart';
import 'package:user_app/views/mainscreen/items_screen.dart';


class MenuUiDesign extends StatefulWidget {

  Menu? menuModel;
   MenuUiDesign({super.key,this.menuModel});

  @override
  State<MenuUiDesign> createState() => _MenuUiDesignState();
}

class _MenuUiDesignState extends State<MenuUiDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  ItemsScreen(menuModel: widget.menuModel,),));
      },
      child: Padding(padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Image.network(
              
              widget.menuModel!.menuImage.toString(),
              width: MediaQuery.of(context).size.width,
              height: 220,
              fit: BoxFit.cover,
            ),
           Text(widget.menuModel!.menuInfo.toString(),
                style: const TextStyle(
                   color: Colors.cyan,
                   fontSize: 20,
                   
                ),
                ),
          ],
        ),
      ),
      ),
    );
  }
}