import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../addSkill/addskill_quiz_home.dart';
import '../global/global.dart';
import '../quiz/quiz_home.dart';
import '../widgets/button_widget.dart';
import 'changepassword.dart';
import 'editprofile.dart';



class profile extends StatefulWidget
{
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile>
{
  String totalSellerEarnings = "";
  String skills = "";
  String about = "";
  String name = "";
  String email = "";
  String img = "";
  String pass = "";

  readTotalEarnings() async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((snap)
    {
      setState(() {
        totalSellerEarnings = snap.data()!["unit"].toString();
      });
    });
  }
  readpass() async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((snap)
    {
      setState(() {
        pass = snap.data()!["password"].toString();
      });
    });
  }
  readImage() async
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
  readSkill() async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((snap)
    {
      setState(() {
        skills = snap.data()!["skill"].toString();
      });
    });
  }
  readAbout() async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((snap)
    {
      setState(() {
        about = snap.data()!["about"].toString();
      });
    });
  }
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
  readEmail() async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((snap)
    {
      setState(() {
        email = snap.data()!["email"].toString();
      });
    });
  }
  @override
  void initState()
  {
    super.initState();
    readSkill();
    readAbout();
    readName();
    readEmail();
    readTotalEarnings();
    readImage();
    readpass();
  }

  @override
  Widget build(BuildContext context)
  {

    return Scaffold(


      appBar:  AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Profile"),

        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(

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
                Text(
                  email,
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

          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                 children: [

              Center(child: buildUpgradeButton()),

                   const SizedBox(width: 25),
              Center(child: buildAddSkillButton()),
                   const SizedBox(width: 25),
                   Center(child: buildChangePasswordButton()),
        ]),
            ),
          ),

           builds(context),
           const SizedBox(height: 48),
          buildAbout(),
        ],
      ),
    );

  }



  Widget buildUpgradeButton() => ButtonWidget(

    text: 'Update\n profile',
    onClicked: () {
      Navigator.push(context, MaterialPageRoute(builder: (c)=> EditProfilePage(img,pass)));
    },
  );

  Widget buildChangePasswordButton() => ButtonWidget(

    text: 'update \nAccount',
    onClicked: () {
      Navigator.push(context, MaterialPageRoute(builder: (c)=> changeAccount(img,pass)));
    },
  );


  Widget buildAddSkillButton() => ButtonWidget(
    text: 'Add \nskill',
    onClicked: () {

      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddHome()));

    },
  );

  Widget buildAbout() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 48),
    child:  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text(
         about,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 16,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  Widget builds(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      buildButton(context, 'unit',totalSellerEarnings),
      buildDivider(),
      buildButton(context, 'skill',skills),

    ],
  );
  Widget buildDivider() => const SizedBox(
    height: 24,
    child: VerticalDivider(),
  );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(

        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () {

        },
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
