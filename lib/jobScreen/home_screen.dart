import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancer_app/global/global.dart';
import 'package:freelancer_app/jobScreen/ui_ux_jobs.dart';
import 'package:freelancer_app/push_notifications/push_notifications_system.dart';
import 'package:freelancer_app/widgets/my_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../assistantMethods/saved_methods.dart';
import '../functions/functions.dart';
import '../readmore/readmore.dart';
import '../searchScreen/search_screen.dart';
import '../splashScreen/my_splash_screen.dart';
import 'all_jobs_screen.dart';
import 'back_end_jobs.dart';
import 'front_end_jobs.dart';
import 'graphics_design.dart';
import 'mobile_app_jobs.dart';


class HomeScreen extends StatefulWidget
{

  const HomeScreen( {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen>
{
  restrictBlockedUsersFromUsingUsersApp() async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .get().then((snapshot)
    {
      if(snapshot.data()!["status"] != "approved")
      {
        showReusableSnackBar(context, "you are blocked by admin.");
        showReusableSnackBar(context, "contact admin: ssswar@gmail.com");

        FirebaseAuth.instance.signOut();
        Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen()));
      }
      else
      {
        BookmarkMethods().clearBookmark(context);
      }
    });
  }



  getUserUserUnitFromDatabase()
  {
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((dataSnapShot)
    {
      previousUnit = dataSnapShot.data()!["unit"].toString();
    });
  }

  @override
  void initState()
  {
    super.initState();
PushNotificationsSystem pushNotificationsSystem=PushNotificationsSystem();
pushNotificationsSystem.whenNotificationReceived(context);
pushNotificationsSystem.generateDeviceRecognitionToken();

    restrictBlockedUsersFromUsingUsersApp();
    getUserUserUnitFromDatabase();
    BookmarkMethods().clearBookmark(context);
  }
  DateTime? _currentBackPressTime;
  List<Tab> tabs = [
    const Tab(child: Text("All")),
    const Tab(child: Text("Database")),
    const Tab(child: Text("Back-End")),
    const Tab(child: Text("Front-End")),
    const Tab(child: Text("Graphics-Design")),
    const Tab(child: Text("Mobile-App")),

  ];
Icon cusIcon=Icon((Icons.search));

Widget cusSearchBar=Text("Available Jobs");

  String sellerNameText = "";
  Future<QuerySnapshot>? storesDocumentsList;

  initializeSearchingStores(String textEnteredbyUser)
  {
    storesDocumentsList = FirebaseFirestore.instance
        .collection("jobsItems")
        .where("itemTitle", isGreaterThanOrEqualTo: textEnteredbyUser)
        .get();
  }
  @override
  Widget build(BuildContext context)
  {
    return DefaultTabController(
      length: 6,
      child: WillPopScope(
        onWillPop: () async {
          DateTime now = DateTime.now();

          if (_currentBackPressTime == null ||
              now.difference(_currentBackPressTime!) > const Duration(seconds: 2)) {
            _currentBackPressTime = now;

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Press back button again to exit'),
              ),
            );

            return false;
          }
          return true;
        },
          child: Scaffold(

        backgroundColor: Colors.white,
        drawer: const MyDrawer(),
        appBar: AppBar(

          elevation: 0.0,
          backgroundColor: Colors.indigo,

          centerTitle: true,
          actions:<Widget> [
            IconButton(
              onPressed: () {
                initializeSearchingStores(sellerNameText);
                setState(() {
                  if(cusIcon.icon==Icons.search){
                    cusIcon=const Icon(Icons.cancel);
                    cusSearchBar= TextField(
                      onChanged: (textEntered)
                      {
                        setState(() {
                          sellerNameText = textEntered;
                        });

                        initializeSearchingStores(sellerNameText);
                      },

                      textInputAction: TextInputAction.go,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search job here",hintStyle: TextStyle(color: Colors.grey),

                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),

                    );
                  }else{
                     cusIcon=const Icon((Icons.search));
                     cusSearchBar=const Text("Available Jobs");
                  }
                });
              },
              icon: cusIcon,
            ),
        PopupMenuButton(
            onSelected: (value) async{

            },
            itemBuilder: (BuildContext bc)  {
              return  [

                PopupMenuItem(
                  value: Navigator.push(context, MaterialPageRoute(builder: (context) =>  readmoreText())), child: const Text("Contact Us"),


                ),

              ];
            },


        ),


          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30),
            child: TabBar(
              physics: ClampingScrollPhysics(),
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              tabs: tabs,
              indicatorColor: Colors.black54,
            ),
          ),title:cusSearchBar,
        ),

        body:  Container(
          decoration: const BoxDecoration(
            color: Colors.black
          ),
          child: TabBarView(
            children: [
              all_jobs_screen(),
              database(),
              back_end(),
              front_end(),
              graphics(),
              mobile_app(),

            ],
          ),
        ),
          ),

      ),

    );

  }



dd() {
  String UserEmail = "ssswar367@gmail.com";


  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
  final Uri emailUri = Uri(
      scheme: 'mailto',
      path: UserEmail,
      query: encodeQueryParameters(<String, String>{
        'subject': 'From Skill Exchange System Admin',
        'body':
        'hello our user',

      })

  );
  launchUrl(emailUri);
}
}
