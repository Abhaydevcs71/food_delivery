import 'package:admin_web_panel/views/mainScreen/banner_screen.dart';
import 'package:admin_web_panel/views/mainScreen/category_screen.dart';
import 'package:admin_web_panel/views/widgets/my_appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(titleMsg: "Admin Web Panel", showBackButton: false),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //upload banner and category
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // upload banner button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const BannerScreen(),));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 117,vertical: 30),
                    backgroundColor: Colors.deepOrange
                  ),
                  icon: const Icon(Icons.screen_share_outlined,color: Colors.white,),
                  label: Text("upload Banner".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 3
                  ),
                  ),
                ),
                //upload category button

                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoryScreen(),));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 110,vertical: 30),
                    backgroundColor: Colors.purple
                  ),
                  icon: const Icon(Icons.category_outlined,color: Colors.white,),
                  label: Text("upload Category".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 3
                  ),
                  ),
                ),
              ],
            ),

            // user activate and block account

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // upload banner button
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 45,vertical: 30),
                    backgroundColor: Colors.green
                  ),
                  icon: const Icon(Icons.check_circle_outline,color: Colors.white,),
                  label: Text("All verified users accounts".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 3
                  ),
                  ),
                ),
                //upload category button

                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 110,vertical: 30),
                    backgroundColor: Colors.deepOrange
                  ),
                  icon: const Icon(Icons.block_flipped,color: Colors.white,),
                  label: Text("All Blocked Users Accounts".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 3
                  ),
                  ),
                ),
              ],
            ),

            // sellers activate and block account

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // All verified sellers
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 30),
                    backgroundColor: Colors.purple
                  ),
                  icon: const Icon(Icons.check_circle_outline,color: Colors.white,),
                  label: Text("All verified sellers Accounts".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 3
                  ),
                  ),
                ),
                //All blocked sellers 

                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 30),
                    backgroundColor: Colors.green
                  ),
                  icon: const Icon(Icons.block_flipped,color: Colors.white,),
                  label: Text("All Blocked sellers Accounts".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 3
                  ),
                  ),
                ),
              ],
            ),
            // rides activate and block account

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // All verified sellers
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 30),
                    backgroundColor: Colors.deepOrange
                  ),
                  icon: const Icon(Icons.check_circle_outline,color: Colors.white,),
                  label: Text("All verified riders Accounts".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 3
                  ),
                  ),
                ),
                //All blocked sellers 

                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 30),
                    backgroundColor: Colors.purple
                  ),
                  icon: const Icon(Icons.block_flipped,color: Colors.white,),
                  label: Text("All Blocked riders Accounts".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 3
                  ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
