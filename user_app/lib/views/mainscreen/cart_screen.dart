import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:user_app/constants/app_colors.dart';
import 'package:user_app/global/global_instance.dart';
import 'package:user_app/model/item.dart';
import 'package:user_app/provider/cart_item_counter.dart';
import 'package:user_app/provider/total_amount.dart';
import 'package:user_app/views/mainscreen/address_screen.dart';
import 'package:user_app/views/mainscreen/homescreen.dart';
import 'package:user_app/widgets/cart_item_design.dart';

class CartScreen extends StatefulWidget {

  String? sellerUid;
   CartScreen({super.key,this.sellerUid});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  List<int>? seperateItemQuantityList;
  double totalAmount = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalAmount = 0;

    seperateItemQuantityList = cartViewModel.seperateItemQuantities();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          cartViewModel.clearCartNow(context);
           Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        }, icon: const Icon(Icons.clear_all)),
        title: const Text("My Cart",
        style: TextStyle(
          fontSize: 24,
        ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(width: 10,),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(onPressed: () {
              cartViewModel.clearCartNow(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen())); 
              commonViewModel.showSnackBar("Cart Cleared", context);
            },
            heroTag: "btn1",
             label: const Text("Clear Cart",style: TextStyle(fontSize: 16),),
             backgroundColor: kBlackColor,
             icon: const Icon(Icons.clear_all),
             ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => AddressScreen(
              totalAmount: totalAmount,
             sellerUid: widget.sellerUid,
             ),));
            },
            heroTag: "btn2",
             label: const Text("CheckOut",style: TextStyle(fontSize: 16),),
             backgroundColor: kBlackColor,
             icon: const Icon(Icons.clear_all),
             ),
          ),
        ],
      ),
      body: Column(
        children: [
          Consumer2<TotalAmount,CartItemCounter>(builder: (context, amountProvider,cartProvider,c){

            return Padding(padding: const EdgeInsets.all(12),
            child: Center(
              child: cartProvider.count == 0
              ? Container()
              : Text(
                "Total Amount: ${amountProvider.totalAmount.toString()}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,color: kBlackColor,
                ),
              )
              ,
            ),
            );
          }),
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: cartViewModel.getCartItems(),
              builder: (context, snapshot) {
                return !snapshot.hasData 
                ? const Center(child: Text("No items found"),)
                : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Item itemModel = Item.fromJson(snapshot.data!.docs[index].data() as Map<String , dynamic>);
                    if(index == 0){
                      totalAmount =0;
                      totalAmount = totalAmount + (itemModel.price! * seperateItemQuantityList![index]);
                    }else{
                      totalAmount = totalAmount + (itemModel.price! * seperateItemQuantityList![index] );
                    }

                    if(snapshot.data!.docs.length - 1 == index){
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
                        Provider.of<TotalAmount>(context, listen: false).displayTotalAmount(totalAmount.toDouble());
                      });
                    }
                    return Padding(padding: EdgeInsets.only(left: 8.0,right: 8,top: 3),
                    child: Card(
                      elevation: 6,
                      child: CartItemDesign(
                        itemModel: itemModel,
                        quantityNumber: seperateItemQuantityList![index],
                      ),
                    ),
                    );
                  },);
                  
              },
            ),
          ),
        ],
      ),
    );
  }
}