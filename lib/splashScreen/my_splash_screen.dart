import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_app/authScreens/auth_screen.dart';
import 'package:freelancer_app/jobScreen/home_screen.dart';



class MySplashScreen extends StatefulWidget
{
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}



class _MySplashScreenState extends State<MySplashScreen>
{

  splashScreenTimer()
  {
    Timer(const Duration(seconds: 1), () async
    {
      //user is already logged-in
      if(FirebaseAuth.instance.currentUser != null)
      {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const HomeScreen()),
        (Route route) => false,    );
          }
      else //user is NOT already logged-in
          {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => AuthScreen()),
              (Route route) => false,    );      }
    });
  }

  @override
  void initState() //called automatically when user comes here to this splash screen
  {
    super.initState();

    splashScreenTimer();
  }

  @override
  Widget build(BuildContext context)
  {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors:
              [
                Colors.white,
                Colors.white,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            )
        ),
        child: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(

                    "images/go.png"
                ),

              ),

              const SizedBox(height: 10,),

              const Text(
                "Welcome to",

                style: TextStyle(
                  fontSize: 30,
                  letterSpacing: 1,
                  //fontFamily: 'Signatra',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),

              ),
              const SizedBox(height: 10,),

              const Text(
                "Skill Exchange",

                style: TextStyle(
                  fontSize: 50,
                  letterSpacing: 5,
                  fontFamily: 'Signatra',
                  backgroundColor: Colors.blue,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),

              ),

              const SizedBox(height: 10,),

              const Text(
                "Connect, exchange,grow - skill Exchange,",

                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 1,
                  //fontFamily: 'Signatra',
                  color: Colors.black54,
                  //fontWeight: FontWeight.bold,
                ),

              ),
              const SizedBox(height: 10,),

              const Text(
                "where skills meet opportunity.",

                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 1,
                  //fontFamily: 'Signatra',
                  color: Colors.black54,
                  //fontWeight: FontWeight.bold,
                ),

              ),
              const SizedBox(height: 340,),

              const Text(
                "Freelancers App",

                style: TextStyle(
                  fontSize: 22,
                  letterSpacing: 1,
                  //fontFamily: 'Signatra',
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),

              ),
            ],
          ),

        ),
      ),
    );
  }
}
