import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_app/constants/app_colors.dart';
import 'package:user_app/global/global_instance.dart';
import 'package:user_app/global/global_vars.dart';
import 'package:user_app/views/mainscreen/homescreen.dart';
import 'package:user_app/views/mainscreen/my_orders_screen.dart';
import 'package:user_app/views/splashscreen/splashscreen.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kcPrimaryColor,
      child: ListView(
        children: [

          //header

          Container(
            padding: const EdgeInsets.only(top: 25,bottom: 10),
            child: Column(
              children: [

                //image
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(81)),
                  elevation: 8,
                  child: SizedBox(
                    height: 158,
                    width: 158,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(sharedPreferences!.getString("imageUrl").toString()),
                    ),
                  ),
                ),
                const SizedBox(height: 12,),
                Text(sharedPreferences!.getString("name").toString(),style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),)
              ],
            ),
          ),
          SizedBox(height: 12,),

          //body

          Container(
            child: Column(
              children: [
                Divider(
                  height: 10,
                  color: kGreyColor,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(Icons.home,color: kWhiteColor,),
                  title: Text("Home",
                  style: TextStyle(color: kWhiteColor),
                  
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
                  },
                ),

                //
                Divider(
                  height: 10,
                  color: kGreyColor,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(Icons.reorder,color: kWhiteColor,),
                  title: Text("My orders",
                  style: TextStyle(color: kWhiteColor),
                  
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyOrdersScreen(),));
                  },
                ),

                //
                Divider(
                  height: 10,
                  color: kGreyColor,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(Icons.access_time,color: kWhiteColor,),
                  title: Text("History",
                  style: TextStyle(color: kWhiteColor),
                  
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
                  },
                ),
                //

                Divider(
                  height: 10,
                  color: kGreyColor,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(Icons.search,color: kWhiteColor,),
                  title: Text("Search Hotels",
                  style: TextStyle(color: kWhiteColor),
                  
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
                  },
                ),
                //

                Divider(
                  height: 10,
                  color: kGreyColor,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(Icons.share_location_outlined,color: kWhiteColor,),
                  title: Text("Add My Address",
                  style: TextStyle(color: kWhiteColor),
                  
                  ),
                  onTap: () {
                    commonViewModel.updateLocationInDatabase();
                    commonViewModel.showSnackBar("Add Address", context);
                  },
                ),

                //

                Divider(
                  height: 10,
                  color: kGreyColor,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app_outlined,color: kWhiteColor,),
                  title: Text("Sign Out",
                  style: TextStyle(color: kWhiteColor),
                  
                  ),
                  onTap: () {

                    FirebaseAuth.instance.signOut();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashScreen(),));
                  },
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}