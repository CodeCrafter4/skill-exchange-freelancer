import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancer_app/quiz/quiz_page.dart';

import 'backend_quiz.dart';
import 'frontend_quiz.dart';
import 'graphics.dart';
import 'mobile_app_quiz.dart';

class QuizHomePage extends StatefulWidget {
  String? jobName;

  String name;
  String email;
  String password;
  String phone;
  String about;
  String image;


  QuizHomePage(this.name,this.email,this.password,this.phone,this.about,this.image, );



  @override
  _QuizHomePageState createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  String? jobName;

  String? name1;
  String? email1;
  String? password1;
  String? phone1;
  String? about1;
  String? image1;


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

              name1=widget.name;
              email1=widget.email;
              password1=widget.password;
              phone1=widget.phone;
              about1=widget.about;
              image1=widget.image;

              Navigator.push(context, MaterialPageRoute(builder: (context) =>  Quiz_page(
                  jobName.toString(),

                  name1.toString(),
                  email1.toString(),
                  password1.toString(),
                  phone1.toString(),
                  about1.toString(),
                  image1.toString()

              )));


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
              jobName="BackEnd";
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  backend_quiz(jobName.toString())));


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
              jobName="FrontEnd";
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  frontEnd_quiz(jobName.toString())));


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
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  graphicsQuiz(jobName.toString())));
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