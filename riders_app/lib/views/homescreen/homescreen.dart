import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:riders_app/constants/app_colors.dart';
import 'package:riders_app/global/global_vars.dart';
import 'package:riders_app/views/mainscreen/earnings_screen.dart';
import 'package:riders_app/views/mainscreen/history_screen.dart';
import 'package:riders_app/views/mainscreen/in_progress_screen.dart';
import 'package:riders_app/views/mainscreen/new_order_screen.dart';
import 'package:riders_app/views/mainscreen/not_yet_delivered.dart';
import 'package:riders_app/views/splashscreen/splashscreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Welcome ${sharedPreferences!.getString("name")}",
          style: TextStyle(
            fontSize: 18,
            color: kcPrimaryColor,
            letterSpacing: 2,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 1),
        child: GridView.count(
          crossAxisCount: 2,
          children: const [
          // DashboardCard("In Progress", Icons.airport_shuttle, 0),
          // DashboardCard("New Orders", Icons.assignment, 1),
          // DashboardCard("Not Yet Delivered", Icons.location_history, 2),
          // DashboardCard("History", Icons.done_all, 3),
          // DashboardCard("Earnings", Icons.monetization_on, 4),
          // DashboardCard("Logout", Icons.logout, 5),
          DashboardCard(title: "In Progress", iconData: Icons.airport_shuttle, index: 0, onTap: InProgressScreen()),
          DashboardCard(title: "New Orders", iconData: Icons.assignment, index: 1, onTap: NewOrderScreen()),
          DashboardCard(title: "Not Yet Delivered", iconData: Icons.location_history, index: 2, onTap: NotYetDeliveredScreen()),
          DashboardCard(title: "History", iconData: Icons.done_all, index: 3, onTap: HistoryScreen()),
          DashboardCard(title: "Earnings", iconData: Icons.monetization_on, index: 4, onTap: EarningsScreen()),
          DashboardCard(title: "Logout", iconData: Icons.logout, index: 5, onTap: SplashScreen()),
          ],
        ),
      ),
    );   
  }


  //Card for dashboard Ui//
  
  
    //*******************************************//
}


class DashboardCard extends StatelessWidget {

  final String title;
  final IconData iconData;
  final int index;
  final Widget onTap;
  const DashboardCard({super.key, required this.title, required this.iconData, required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        margin: const EdgeInsets.all(8),
        child: Container(
          decoration: index == 0 || index == 3 || index == 4
              ? const BoxDecoration(
                  gradient: LinearGradient(
                  colors: [Colors.black, Colors.black87],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  tileMode: TileMode.clamp,
                ))
              : const BoxDecoration(
                  gradient: LinearGradient(
                  colors: [
                    Colors.black87,
                    Colors.black,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  tileMode: TileMode.clamp,
                )),
                child: InkWell(
                  onTap: () {
                    if(index == 5){
                      FirebaseAuth.instance.signOut();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => onTap,));
                    }else{
                    Navigator.push(context, MaterialPageRoute(builder: (context) => onTap,));
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    verticalDirection: VerticalDirection.down,
                    children: [
                      const SizedBox(height: 50,),
                      Center(
                        child: Icon(iconData,size: 40,color: kWhiteColor,),
                      ),
                      const SizedBox(height: 10,),
                      Center(
                        child: Text(title,style: TextStyle(fontSize: 16,
                        color: kWhiteColor,
                        ),),
                      )
                    ],
                  ),
                ),
        ),
      );
  }
}
