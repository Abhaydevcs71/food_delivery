import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_app/constants/app_strings.dart';
import 'package:user_app/global/global_instance.dart';
import 'package:user_app/model/item.dart';
import 'package:user_app/model/seller.dart';
import 'package:user_app/widgets/my_appbar.dart';
import 'package:user_app/widgets/my_drawer.dart';
import 'package:user_app/widgets/recommended_popular_item_ui_design.dart';
import 'package:user_app/widgets/seller_ui_design.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List bannerImagesList =[];
  List categoryList = [];

  updateUi() async{
    bannerImagesList =await homeViewModel.readBannersFromFirestore();
    categoryList = await homeViewModel.readCategoriesFromFirestore();

    setState(() {
      bannerImagesList;
      categoryList;
    });

    cartViewModel.clearCartNow(context);
  }

  @override
  void initState() {
    
    super.initState();
    updateUi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: MyAppBar(titleMsg: kAppName, showBackButton: false),
      body:  SingleChildScrollView(
        child: Column(
          children: [

            // Banners
            Padding(padding: const EdgeInsets.only(top: 6,left: 10,right: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .3,
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * .3,
                  aspectRatio: 16/9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: bannerImagesList.map((index){
                  return Builder(builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 1.0),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Padding(padding: const EdgeInsets.all(3.0),
                      child: Image.network(index,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                      ),
                      ),
                    );
                  });
                } ).toList()
              ),
            ),
            ),
            

            const SizedBox(height: 8,),

            //categories

            const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Categories",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
                ),
              ),
            ),

            SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: 
                  categoryList.map((index){
                    return Padding(padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ChoiceChip(
                      showCheckmark: false,
                      label: Text(index,style: const TextStyle(
                      fontSize: 15,
                    ),), selected: categoryList.contains(index),
                    onSelected: (c) {
                    commonViewModel.showSnackBar("$index selected", context);
                    },
                    ),
                    );
                  }).toList(),
                
              ),
            ),
            
            const SizedBox(height: 8,),

            //recommended

            const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Recommended",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
                ),
              ),
            ),
            SizedBox(
              height: 264,
              child: StreamBuilder<QuerySnapshot>(
                stream: homeViewModel.readRecommendedItemsFromFirestore(),
                builder: (context, snapshot) {
                  return !snapshot.hasData 
                  ? const Center(child: Text("No Recommended items found"),)
                  : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                    Item itemModel = Item.fromJson(
                      snapshot.data!.docs[index].data() as Map<String , dynamic>
                    );
                    return Card(
                      elevation: 6,
                      child: RecomPopUiDesign(itemModel: itemModel,),
                    );
                  },);
                },
              ),
            ),

            const SizedBox(height: 8,),

            //popular

            const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Popular",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
                ),
              ),
            ),

            SizedBox(
              height: 264,
              child: StreamBuilder<QuerySnapshot>(
                stream: homeViewModel.readRecommendedItemsFromFirestore(),
                builder: (context, snapshot) {
                  return !snapshot.hasData 
                  ? const Center(child: Text("No Popular items found"),)
                  : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                    Item itemModel = Item.fromJson(
                      snapshot.data!.docs[index].data() as Map<String , dynamic>
                    );
                    return Card(
                      elevation: 6,
                      child: RecomPopUiDesign(itemModel: itemModel,),
                    );
                  },);
                },
              ),
            ),


            const SizedBox(height: 8,),


            //sellers - cafe/restaurant

            const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Cafe & Restaurant",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
                ),
              ),
            ),

            SizedBox(
              height: 284,
              child: StreamBuilder<QuerySnapshot>(
                stream: homeViewModel.readSellersFromFirestore(),
                builder: (context, snapshot) {
                  return !snapshot.hasData 
                  ? const Center(child: Text("No Seller found"),)
                  : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                    Seller sellerModel = Seller.fromJson(
                      snapshot.data!.docs[index].data() as Map<String , dynamic>
                    );
                    return Card(
                      elevation: 6,
                      child: SellerUiDesign(sellerModel: sellerModel,)
                    );
                  },);
                },
              ),
            ),


            const SizedBox(height: 8,),
          ],
        ),
      ),
    );
  }
}