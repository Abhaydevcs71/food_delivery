
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/constants/app_colors.dart';
import 'package:user_app/provider/cart_item_counter.dart';
import 'package:user_app/views/mainscreen/cart_screen.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  String? sellerUid;
  String? title;
  PreferredSizeWidget? bottom;
  CartAppBar(
      {super.key,
      this.sellerUid,
      this.title,
      this.bottom});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kcPrimaryColor,
      centerTitle: true,
      automaticallyImplyLeading: true,
      
      title: Text(
        title.toString(),
        style: const TextStyle(fontSize: 20, letterSpacing: 3),
      ),
      actions: [
        Stack(
          children: [
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(sellerUid : sellerUid),));
            }, icon: Icon(Icons.shopping_cart,color: kcSecondaryColor,)),

            Positioned(child: Stack(
              children: [
                Icon(Icons.brightness_1,
                size: 20,
                color: kcPrimaryColor,),
                Positioned(
                  top: 3,
                  right: 4,
                  child: Center(
                    child: Consumer<CartItemCounter>(
                      builder: (context, counter, child) {
                        return  Text(counter.count.toString(),
                    style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 12,
                    ),
                    );
                      },
                    ),
                  ))
              ],
            ))
          ],
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => bottom == null
      ? Size(57, AppBar().preferredSize.height)
      : Size(57, 80 + AppBar().preferredSize.height);
}
