

import 'package:flutter/material.dart';
import 'package:user_app/constants/app_colors.dart';
import 'package:user_app/model/item.dart';

class CartItemDesign extends StatefulWidget {
  final Item? itemModel;
  final int? quantityNumber;
  const CartItemDesign({super.key, this.itemModel, this.quantityNumber});

  @override
  State<CartItemDesign> createState() => _CartItemDesignState();
}

class _CartItemDesignState extends State<CartItemDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(padding: EdgeInsets.all(6.0),
      child: SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child:  Row(
          children: [
            Image.network(widget.itemModel!.itemImage!,width: 140,height: 120,),
            const SizedBox(width: 6,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.itemModel!.itemTitle!,
                style: TextStyle(
                  color: kBlackColor,
                  fontSize: 16,
                  
                ),
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Text("x",
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 19,
                    ),
                    ),

                    Text(widget.quantityNumber.toString(),
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 23,
                    ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("price",
                    style: TextStyle(
                      fontSize: 15,
                      color: kGreyColor
                    ),
                    ),
                    const SizedBox(width: 5,),
                    const Text("₹",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16.0,
                    ),
                    ),
                    
                    Text(widget.itemModel!.price!.toString(),
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 16.0,
                    ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
      ),
    );
  }
}