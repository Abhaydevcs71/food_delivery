import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:riders_app/global/global_instance.dart';
import 'package:riders_app/widgets/my_appbar.dart';
import 'package:riders_app/widgets/order_card_ui_design.dart';
class NotYetDeliveredScreen extends StatefulWidget {
  const NotYetDeliveredScreen({super.key});

  @override
  State<NotYetDeliveredScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NotYetDeliveredScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(titleMsg: "My Orders", showBackButton: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: orderViewModel.retieveNotYetDeliveredOrders(),
        builder: (context, snapshot) {
          return snapshot.hasData
          ? ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return  FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection("items")
                          .where("itemId", whereIn: orderViewModel.separateItemIDsForOrder((snapshot.data!.docs[index].data() as Map<String, dynamic>)["productId"]))
                          .where("orderBy", whereIn: (snapshot.data!.docs[index].data()! as Map<String, dynamic>)["uid"])
                          .orderBy("publishedDateTime", descending: true)
                          .get(),
                      builder: (c, snap)
                      {
                        return snap.hasData
                            ? Card(
                                child: OrderCardUiDesign(
                                  itemCount: snap.data!.docs.length,
                                  data: snap.data!.docs,
                                  orderId: snapshot.data!.docs[index].id,
                                  seperateQuantitiesList: orderViewModel.separateItemQuantitiesForOrder((snapshot.data!.docs[index].data() as Map<String, dynamic>)["productId"]),),
                              )
                            : const Center(child: CircularProgressIndicator());
                      },
                    );
            },)
            : const Center(child: Text("No Orders"),);
        },
      ),
    );
  }
}
