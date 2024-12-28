import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelancer_app/quiz/quiz_home.dart';
import 'package:freelancer_app/splashScreen/my_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global/global.dart';
import '../widgets/loading_dialog.dart';





class Quiz_resultpage extends StatefulWidget {
  int? marks;
  String? jobtype;

  String name2;
  String email2;
  String password2;
  String phone2;
  String about2;
  String? image2;

  Quiz_resultpage(
      this. marks,
      this. jobtype,
      this.name2,
      this.email2,
      this.password2,
      this.phone2,
      this.about2,
      this.image2
      ) ;

  @override
  _Quiz_resultpageState createState() => _Quiz_resultpageState(marks!,jobtype);


  }

class _Quiz_resultpageState extends State<Quiz_resultpage> {

  bool isVisible=false;
  bool isVisible1=false;
  String reviewerID = DateTime.now().millisecondsSinceEpoch.toString();

  List<String> images = [
    "images/success.png",
    "images/good.png",
    "images/bad.png",
  ];

  String? message;
  String? image;
  String? mark;
  int? mark1;
  String? jobtype1;

  String? name3;
  String? email3;
  String? password3;
  String? phone3;
  String? about3;
  String? image3;

  @override
  void initState(){
    jobtype1=widget.jobtype;
    mark1=widget.marks;
    name3=widget.name2;
    email3=widget.email2;
    password3=widget.password2;
    phone3=widget.phone2;
    about3=widget.about2;
    image3=widget.image2;


    if(marks < 5){
      image = images[2];
      message = "You Should Try Hard..";
      mark =  "You Scored $marks marks out of 10.";
      isVisible1=true;
    }else if(marks < 7){
      image = images[1];
      message = "You Can Do Better..";
      mark =  "You Scored $marks marks out of 10.";
      isVisible=true;
    }else{
      image = images[0];
      message = "You Did Very Well..";
      mark =  "You Scored $marks.out of 15\n and you will be reviewer.";
      isVisible=true;




    }
    super.initState();
  }

  int marks;
  _Quiz_resultpageState(this.marks, String? jobtype);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Result",
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Material(
              elevation: 10.0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      child: Container(
                        width: 300.0,
                        height: 300.0,
                        child: ClipRect(
                          child: Image(
                            image: AssetImage(
                              image!,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 15.0,
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                message!,

                                style: const TextStyle(
                                  fontSize: 28.0,
                                  fontFamily: "Quando",
                                ),
                              ),

                            ),
                             Center(
                               child: Text(
                                mark!,

                                style: const TextStyle(
                                  fontSize: 28.0,
                                  fontFamily: "Quando",
                                ),
                            ),
                             ),
                          ],
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Visibility(
                      visible: isVisible1,
                      child: ElevatedButton(
                          onPressed: ()
                          {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => QuizHomePage(
                                  name3!,
                                  email3!,
                                  password3!,
                                  phone3!,
                                  about3!,
                                  image3!,
                              ),
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlue,
                            fixedSize: const Size(290, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            "Retake the quiz",style: TextStyle(fontSize: 18,),
                          )
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 10,),
                Visibility(
                  visible: isVisible,
                  child:  ElevatedButton(
                      onPressed: ()
                      {
                        showDialog(
                            context: context,
                            builder: (c)
                            {
                              return LoadingDialogWidget(
                                message: "Registering..",
                              );
                            }
                        );
                        saveInformationToDatabase();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        fixedSize: const Size(290, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Continue",style: TextStyle(fontSize: 18,),
                      )
                  ),
                ),
                const SizedBox(height: 15,),

                // Visibility(
                //   visible: isVisible,
                //   child:  ElevatedButton(
                //       onPressed: ()async
                //       {
                //         showDialog(
                //             context: context,
                //             builder: (c)
                //             {
                //               return LoadingDialogWidget(
                //                 message: "Making reviewer..,",
                //               );
                //             }
                //         );
                //
                //
                //         //  User?  currentUser;
                //         // await makeAReviewer(currentUser!);
                //
                //       },
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: Colors.indigo,
                //         fixedSize: const Size(290, 50),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(30),
                //         ),
                //       ),
                //       child: const Text(
                //         "Make me reviewer",style: TextStyle(fontSize: 18,),
                //       )
                //   ),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }





  saveInformationToDatabase() async
  {
    //authenticate the user first
    User? currentUser;

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email3!,
      password: password3!,
    ).then((auth)
    {
      currentUser = auth.user;
    }).catchError((errorMessage)
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occurred: \n $errorMessage");
    });

    if(currentUser != null)
    {
      //save info to database and save locally
      saveInfoToFirestoreAndLocally(currentUser!);
      saveInfoForEmployerToFirestoreAndLocally(currentUser!);
      if(marks > 7) {
        makeAReviewer(currentUser!);
      }
    }
  }

  saveInfoToFirestoreAndLocally(User currentUser) async
  {
    //save to firestore
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .set(
        {
          "uid": currentUser.uid,
          "email": currentUser.email,
          "name": name3,
          "photoUrl": image3,
          "skill":jobtype1,
          "score":mark1,
          "phone": phone3,
          "password": password3,
          "about": about3,
          "userBookmark": ["initialValue"],
          "status": "approved",
          "unit": 0.0,
        });

    //save locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email!);
    await sharedPreferences!.setString("name", name3!);
    await sharedPreferences!.setString("phone", phone3!);
    await sharedPreferences!.setString("password", password3!);
    await sharedPreferences!.setString("Skill", jobtype1!);
    await sharedPreferences!.setString("about", about3!);
    await sharedPreferences!.setString("photoUrl", image3!);
    await sharedPreferences!.setStringList("userBookmark", ["initialValue"]);


    Navigator.push(context, MaterialPageRoute(builder: (c)=>MySplashScreen ()));
  }
  saveInfoForEmployerToFirestoreAndLocally(User currentUser) async
  {
    //save to firestore
    FirebaseFirestore.instance
        .collection("employers")
        .doc(currentUser.uid)
        .set(
        {
          "uid": currentUser.uid,
          "email": currentUser.email,
          "name": name3,
          "photoUrl": image3,
          "skill":jobtype1,
          "score":mark1,
          "phone": phone3,
          "password": password3,
          "about": about3,
          "userBookmark": ["initialValue"],
          "status": "approved",
          "unit": 0.0,
        });

    //save locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email!);
    await sharedPreferences!.setString("name", name3!);
    await sharedPreferences!.setString("phone", phone3!);
    await sharedPreferences!.setString("password", password3!);
    await sharedPreferences!.setString("Skill", jobtype1!);
    await sharedPreferences!.setString("about", about3!);
    await sharedPreferences!.setString("photoUrl", image3!);
    await sharedPreferences!.setStringList("userBookmark", ["initialValue"]);


    Navigator.push(context, MaterialPageRoute(builder: (c)=>MySplashScreen ()));
  }

  makeAReviewer(User currentUser) async
  {

    FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .collection("reviewer")
        .doc(reviewerID)
        .set(
        {
          "uid": currentUser.uid,
          "email": email3,
          "name": name3,
          "score":mark1,
          "skill":jobtype1,
          "phone": phone3,
          "password": password3,
          "about": about3,

        });


    makeAReviewers(currentUser);

  }

  makeAReviewers(User currentUser) async
  {
    //save to firestore
    FirebaseFirestore.instance
        .collection("reviewer")
        .doc(currentUser.uid)
        .set(
        {
          "uid": currentUser.uid,
          "email": email3,
          "name": name3,
          "score":mark1,
          "skill":jobtype1,
          "phone": phone3,
          "password": password3,
          "about": about3,

        });




    Navigator.push(context, MaterialPageRoute(builder: (c)=> Quiz_resultpage(
      mark1! ,
      jobtype1!,
      name3! ,
      email3!,
      password3!,
      phone3!,
      about3!,
      image3!,


    )));
  }
}