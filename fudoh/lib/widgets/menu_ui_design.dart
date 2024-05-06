import 'package:flutter/material.dart';
import 'package:fudoh/model/menus.dart';
import 'package:fudoh/views/mainscreen/items/items_screen.dart';

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
        height: 270,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Image.network(
              
              widget.menuModel!.menuImage.toString(),
              width: MediaQuery.of(context).size.width,
              height: 220,
              fit: BoxFit.cover,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.menuModel!.menuInfo.toString(),
                style: const TextStyle(
                   color: Colors.cyan,
                   fontSize: 20,
                   
                ),
                ),
                IconButton(onPressed: () {
                  
                }, icon: const Icon(Icons.delete,color: Colors.pinkAccent,))
              ],
            )
          ],
        ),
      ),
      ),
    );
  }
}