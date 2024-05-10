import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riders_app/global/global_instance.dart';
import 'package:riders_app/global/global_vars.dart';
import 'package:riders_app/views/mainscreen/earnings_screen.dart';
import 'package:riders_app/views/mainscreen/history_screen.dart';
import 'package:riders_app/views/mainscreen/in_progress_screen.dart';
import 'package:riders_app/views/mainscreen/new_order_screen.dart';
import 'package:riders_app/views/mainscreen/not_yet_delivered.dart';
import 'package:riders_app/views/splashscreen/splashscreen.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen>
{
  Card dashboardItem(String title, IconData iconData, int index)
  {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: index == 0 || index == 3 || index == 4
            ? const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.black],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  tileMode: TileMode.clamp,
                )
              )
            : const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black54, Colors.black54],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  tileMode: TileMode.clamp,
                )
              ),
        child: InkWell(
          onTap: ()
          {
            if(index == 0)
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const NewOrderScreen()));
            }
            if(index == 1)
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const InProgressScreen()));
            }
            if(index == 2)
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const NotYetDeliveredScreen()));
            }
            if(index == 3)
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const HistoryScreen()));
            }
            if(index == 4)
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const EarningsScreen()));
            }
            if(index == 5)
            {
              FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const SplashScreen()));
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [

              const SizedBox(height: 50.0),

              Center(
                child: Icon(
                  iconData,
                  size: 40,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 10.0),

              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  getUpdatedInfo() async
  {
    await commonViewModel.getRiderPreviousEarnings();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUpdatedInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Welcome  ${sharedPreferences!.getString("name")}",
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 1),
        child: GridView.count(
          crossAxisCount: 2,
          children: [

            dashboardItem("New Available Orders", Icons.assignment, 0),
            dashboardItem("Parcels in Progress", Icons.airport_shuttle, 1),
            dashboardItem("Not Yet Delivered", Icons.location_history, 2),
            dashboardItem("History", Icons.done_all, 3),
            dashboardItem("Total Earnings", Icons.monetization_on, 4),
            dashboardItem("Logout", Icons.logout, 5),
            
          ],
        ),
      ),
    );
  }
}
