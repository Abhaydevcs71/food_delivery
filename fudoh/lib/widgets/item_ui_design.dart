import 'package:flutter/material.dart';
import 'package:fudoh/global/global_instance.dart';
import 'package:fudoh/model/item.dart';

class ItemUiDesign extends StatefulWidget {

  Item? itemModel;
   ItemUiDesign({super.key,this.itemModel});

  @override
  State<ItemUiDesign> createState() => _MenuUiDesignState();
}

class _MenuUiDesignState extends State<ItemUiDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
     //   Navigator.push(context, MaterialPageRoute(builder: (context) =>  ItemsScreen(itemModel: widget.itemModel,),));
      },
      child: Padding(padding: const EdgeInsets.all(5.0),
      child: SizedBox(
       // height: 252,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Image.network(
              widget.itemModel!.itemImage.toString(),
             // widget.itemModel!.itemImage.toString(),
              width: MediaQuery.of(context).size.width,
              height: 220,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 5,),
            Text(widget.itemModel!.itemTitle.toString(),
            style: const TextStyle(
               color: Colors.cyan,
               fontSize: 20,
               
            ),
            )
          ],
        ),
      ),
      ),
    );
  }
}