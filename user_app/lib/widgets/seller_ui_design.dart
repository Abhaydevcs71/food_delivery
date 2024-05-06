import 'package:flutter/material.dart';
import 'package:user_app/model/seller.dart';
import 'package:user_app/views/mainscreen/menu_screen.dart';

class SellerUiDesign extends StatefulWidget {

  Seller? sellerModel;
   SellerUiDesign({super.key,this.sellerModel});

  @override
  State<SellerUiDesign> createState() => _MenuUiDesignState();
}

class _MenuUiDesignState extends State<SellerUiDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  MenuScreen(sellerModel: widget.sellerModel,)));
      },
      child: Padding(padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Image.network(
              
              widget.sellerModel!.image.toString(),
              width: MediaQuery.of(context).size.width,
              height: 210,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 5,),
            Text(widget.sellerModel!.name.toString(),
            style: const TextStyle(
               color: Colors.cyan,
               fontSize: 20,
               
            ),
            ),
            Text(widget.sellerModel!.email.toString(),
            style: const TextStyle(
               color: Colors.cyan,
               fontSize: 12,
               
            ),
            )
          ],
        ),
      ),
      ),
    );
  }
}