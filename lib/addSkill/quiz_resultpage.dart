import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_app/quiz/quiz_home.dart';
import 'package:freelancer_app/splashScreen/my_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global/global.dart';
import '../widgets/loading_dialog.dart';
import 'addskill_quiz_home.dart';





class addskill_quiz_resultpage extends StatefulWidget {
  int? marks;
  String? jobtype;



  addskill_quiz_resultpage(
      this. marks,
      this. jobtype,

      ) ;

  @override
  _addskill_quiz_resultpageState createState() => _addskill_quiz_resultpageState(marks!,jobtype);


  }

class _addskill_quiz_resultpageState extends State<addskill_quiz_resultpage> {

  bool isVisible=false;
  bool isVisible1=false;
  String skill1 = "";

  List<String> images = [
    "images/success.png",
    "images/good.png",
    "images/bad.png",
  ];

  String? message;
  String? image;
  String? mark;
  int? mark1;
  String? skill2;



  @override
  void initState(){
    skill2=widget.jobtype;
    mark1=widget.marks;
    readSkill();


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
      mark =  "You Scored $marks. you can be a reviewer\n Admin will communicate with you";
      isVisible=true;
    }
    super.initState();
  }

  int marks;
  _addskill_quiz_resultpageState(this.marks, String? jobtype);
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
                              builder: (context) => AddHome(),
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlue,
                            fixedSize: const Size(290, 40),
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
                                message: "Registering..,",
                              );
                            }
                        );

                        saveInfoToFirestoreAndLocally();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue,
                        fixedSize: const Size(290, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Continue",style: TextStyle(fontSize: 18,),
                      )
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
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
        skill1 = snap.data()!["skill"].toString();
      });
    });
  }

  saveInfoToFirestoreAndLocally() async
  {

    //save to firestore
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .update(
        {

          "skill":"${skill2!} , $skill1",
         // "quizResult":mark1,

        });

    //save locally
    sharedPreferences = await SharedPreferences.getInstance();

    // await sharedPreferences!.setString("Skill", skill1);



    Navigator.push(context, MaterialPageRoute(builder: (c)=>MySplashScreen ()));
  }
}