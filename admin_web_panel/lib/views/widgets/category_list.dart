import 'package:admin_web_panel/global/global_ins.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: categoryViewModel.readCategoryFromFirestore(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> dataSnapshot) {
        if (dataSnapshot.hasError) {
          return const Text(
            "Error Occured",
            style: TextStyle(color: Colors.grey, fontSize: 24),
          );
        }
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return const Text(
            "Loading",
            style: TextStyle(color: Colors.grey, fontSize: 24),
          );
        }
        if (dataSnapshot.data!.docs.isEmpty) {
          return const Text(
            "No Category Available",
            style: TextStyle(color: Colors.grey, fontSize: 24),
          );
        }
        return Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              mainAxisSpacing: 8,
              crossAxisSpacing: 6,
            ),
            itemCount: dataSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var eachCategory = dataSnapshot.data!.docs[index];

              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(
                        eachCategory["image"],
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(eachCategory["name"]),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
