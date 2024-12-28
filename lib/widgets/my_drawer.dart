import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_app/global/global.dart';
import 'package:freelancer_app/jobScreen/home_screen.dart';
import 'package:freelancer_app/splashScreen/my_splash_screen.dart';
import '../AssigneContrat/assigned_contract.dart';
import '../EmployersScreen/employers_home_screen.dart';
import '../apllicationScreen/apply_screen.dart';
import '../history/history_screen.dart';
import '../main.dart';
import '../profile/profile.dart';
import '../readmore/readmore.dart';
import '../searchScreen/search_screen.dart';


class MyDrawer extends StatefulWidget
{
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}



class _MyDrawerState extends State<MyDrawer>
{
  String name = "";
  String img = "";
  readName() async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((snap)
    {
      setState(() {
        name = snap.data()!["name"].toString();
      });
    });
  }
  readImg() async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((snap)
    {
      setState(() {
        img = snap.data()!["photoUrl"].toString();
      });
    });
  }
  void initState()
  {
    super.initState();

    readName();
    readImg();

  }
  @override
  Widget build(BuildContext context)
  {


    return Drawer(
      backgroundColor: Colors.indigo,
      child: ListView(
        children: [
          
          //header
          Container(
            color: Colors.indigo,
            padding: const EdgeInsets.only(top: 26, bottom: 12),
            child: Column(
              children: [
                //user profile image
                SizedBox(
                  height: 130,
                  width: 130,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      img,
                    ),
                  ),
                ),

                const SizedBox(height: 12,),

                //user name
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12,),

              ],
            ),
          ),

          //body
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              children: [

                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                //home
                ListTile(
                  leading: const Icon(Icons.home, color: Color(0xff1651ea),),
                  title: const Text(
                    "My jobs",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));

                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.person, color: Color(0xff1651ea),),
                  title: const Text(
                    "My profile",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  profile()));

                  },
                ),


                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.picture_in_picture_alt_rounded, color: Color(0xff1651ea)),
                  title: const Text(
                    "Employers",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EmployersHomeScreen()));

                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),


                //my orders
                ListTile(
                  leading: const Icon(Icons.keyboard_double_arrow_up_sharp, color: Color(0xff1651ea)),
                  title: const Text(
                    "My Apply",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ApplyScreen()));

                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),


                //not yet received orders
                ListTile(
                  leading: const Icon(Icons.pending_actions, color: Color(0xff1651ea),),
                  title: const Text(
                    "My Contract",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  AssignedContractsParcelsScreen()));

                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),

                //history
                ListTile(
                  leading: const Icon(Icons.access_time, color: Color(0xff1651ea),),
                  title: const Text(
                    "History",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  HistoryScreen()));

                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.search, color: Color(0xff1651ea),),
                  title: const Text(
                    "search",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  SearchScreen()));

                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.branding_watermark_outlined, color: Color(0xff1651ea),),
                  title: const Text(
                    "Terms and conditions",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  readmoreText()));

                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),



                //logout
                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Colors.indigo,),
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {

                      showDialog(
                          context: context,
                          builder: (context)
                          {
                            return SimpleDialog(
                              title: const Text(
                                "Are you sure you want to sign out?",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              children: [
                                SimpleDialogOption(
                                  onPressed: ()
                                  {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen()));
                                  },
                                  child: const Text(
                                    "sign out",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15
                                    ),
                                  ),
                                ),

                                SimpleDialogOption(
                                  onPressed: ()
                                  {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 15
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                      );




                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),
                const SizedBox(height: 370,),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
