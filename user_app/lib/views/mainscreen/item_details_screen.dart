import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:user_app/constants/app_colors.dart';
import 'package:user_app/global/global_instance.dart';
import 'package:user_app/model/item.dart';
import 'package:user_app/widgets/cart_appbar.dart';

class ItemDetailScreen extends StatefulWidget {

  Item? itemModel;
   ItemDetailScreen({super.key,this.itemModel});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  TextEditingController controllerCounter = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CartAppBar(sellerUid: widget.itemModel!.sellerUid,title: widget.itemModel!.itemTitle,),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //Image part
            Image.network(widget.itemModel!.itemImage!,),

            //Increment and decrement button
            Padding(padding: const EdgeInsets.all(18.0),
            child: NumberInputPrefabbed.roundedButtons(controller: controllerCounter,
            incDecBgColor: kBlackColor,
            incIconColor: kWhiteColor,
            decIconColor: kWhiteColor,
            min: 1,
            max: 9,
            initialValue: 1,
            buttonArrangement: ButtonArrangement.incRightDecLeft,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),
            ),
            ),
            //title
            Padding(padding: const EdgeInsets.all(8.0),
            child: Text(widget.itemModel!.itemTitle.toString(),
            
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            ),
            ),
            //description
            Padding(padding: const EdgeInsets.all(8.0),
            child: Text(widget.itemModel!.description.toString(),
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
            ),
            ),

            //Price section
            Padding(padding: const EdgeInsets.all(8.0),
            child: Text("${widget.itemModel!.price.toString()} ₹ ",
            
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
            ),
            ),
            const SizedBox(height: 10,),

            Center(
              child: ElevatedButton(onPressed: () {
                int quantityNumber = int.parse(controllerCounter.text);

                List<String> seperateItemIdsList = cartViewModel.seperateItemId();

                //check Item exist in cart .

                seperateItemIdsList.contains(widget.itemModel!.itemId)
                ?
                commonViewModel.showSnackBar("Item Already in Cart", context)
                :
                //add to cart.

                cartViewModel.addItemTocart(widget.itemModel!.itemId,context,quantityNumber);
                //
              }, 
              style: ElevatedButton.styleFrom(
                backgroundColor: kcPrimaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 120),
              ),
              child: Text("Add to cart",
              style: TextStyle(
                color: kBlackColor,
                fontSize: 16,
              ),
              )),
            )
          ],
        ),
      ),
    );
  }
}