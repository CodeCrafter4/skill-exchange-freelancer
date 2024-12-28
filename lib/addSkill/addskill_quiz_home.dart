import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancer_app/quiz/quiz_page.dart';

import '../quiz/backend_quiz.dart';
import '../quiz/frontend_quiz.dart';
import '../quiz/graphics.dart';
import '../quiz/mobile_app_quiz.dart';
import 'addskill_backend_quiz.dart';
import 'addskill_frontend_quiz.dart';
import 'addskill_graphics.dart';
import 'addskill_quiz_page.dart';



class AddHome extends StatefulWidget {
  String? jobName;




  AddHome();



  @override
  _AddskillHomeState createState() => _AddskillHomeState();
}

class _AddskillHomeState extends State<AddHome> {
  String? jobName;




  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
    ]);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select your profession and take quiz",
          style: TextStyle(
            fontFamily: "Quando",
          ),
        ),
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: (){
              jobName="Database";

              Navigator.push(context, MaterialPageRoute(builder: (context) =>  addSkillQuizpage(
                  jobName.toString())));


            },
            child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 30.0,),
              child: Material(
                color: Colors.indigoAccent,
                elevation: 10.0,
                borderRadius: BorderRadius.circular(25.0),
                child: Container(

                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(100.0),

                            child: Container(
                              height: 150.0,
                              width: 150.0,

                              child: const ClipOval(
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "images/6.png",
                                  ),
                                ),
                              ),
                            ),

                        ),
                      ),
                      const Center(
                        child: Text(
                          "Database",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black54,
                            fontFamily: "Quando",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: const Text(
                             "A database is a collection of data that is organized so that it can be easily accessed, managed, and updated. Databases are used to store all sorts of data",
                            style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black54,
                            fontFamily: "Alike",
                          ),
                          maxLines: 5,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              jobName="Back-end";
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  backEndquiz(jobName.toString())));


            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 30.0,),
              child: Material(
                color: Colors.indigoAccent,
                elevation: 10.0,
                borderRadius: BorderRadius.circular(25.0),
                child: Container(

                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(100.0),

                            child: Container(
                              height: 150.0,
                              width: 150.0,

                              child: const ClipOval(
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "images/7.jpg",
                                  ),
                                ),
                              ),
                            ),

                        ),
                      ),
                      const Center(
                        child: Text(
                          "BackEnd",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black54,
                            fontFamily: "Quando",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: const Text(

                          "Backend development is the process of developing the server-side of a web application. This includes writing code that interacts with databases, storing and retrieving data",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black54,
                            fontFamily: "Alike",
                          ),
                          maxLines: 5,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              jobName="Front-end";
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  frontendQuiz(jobName.toString())));


            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 30.0,),
              child: Material(
                color: Colors.indigoAccent,
                elevation: 10.0,
                borderRadius: BorderRadius.circular(25.0),
                child: Container(

                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(100.0),

                            child: Container(
                              height: 150.0,
                              width: 150.0,

                              child: const ClipOval(
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "images/9.jpg",
                                  ),
                                ),
                              ),
                            ),

                        ),
                      ),
                      const Center(
                        child: Text(
                          "Front-end",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black54,
                            fontFamily: "Quando",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: const Text(
                          "Python is one of the most popular and fastest programming languages since half a decade. If you think you have learnt it, just test yourself!",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black54,
                            fontFamily: "Alike",
                          ),
                          maxLines: 5,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              jobName="Graphics";
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  graphicQuiz(jobName.toString())));
              },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 30.0,),
              child: Material(
                color: Colors.indigoAccent,
                elevation: 10.0,
                borderRadius: BorderRadius.circular(25.0),
                child: Container(

                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(100.0),

                            child: Container(
                              height: 150.0,
                              width: 150.0,

                              child: const ClipOval(
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "images/10.jpg",
                                  ),
                                ),
                              ),
                            ),

                        ),
                      ),
                      const Center(
                        child: Text(
                          "Graphics",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black54,
                            fontFamily: "Quando",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: const Text(
                          "Front-end development is the process of developing the user interface of a web application. This includes writing code that renders the user interface, ",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black54,
                            fontFamily: "Alike",
                          ),
                          maxLines: 5,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              jobName="Mobile_App";
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  mobileApp(jobName.toString())));


            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 30.0,),
              child: Material(
                color: Colors.indigoAccent,
                elevation: 10.0,
                borderRadius: BorderRadius.circular(25.0),
                child: Container(

                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(100.0),

                            child: Container(
                              height: 150.0,
                              width: 150.0,

                              child: const ClipOval(
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "images/go.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      const Center(
                        child: Text(
                          "Mobile_App,",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black54,
                            fontFamily: "Quando",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: const Text(
                          "A mobile app, also known as a mobile application, is a software application designed to run on a mobile device, such as a smartphone or tablet.",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black54,
                            fontFamily: "Alike",
                          ),
                          maxLines: 5,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}