import 'package:flutter/material.dart';
import 'package:freelancer_app/authScreens/login_tab_page.dart';
import 'package:freelancer_app/authScreens/registration_tab_page.dart';

class AuthScreen extends StatefulWidget
{
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}



class _AuthScreenState extends State<AuthScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(

          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
               color: Colors.indigoAccent
            ),
          ),
          title: const Text(
            "Skill exchange",
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Signatra',
              color: Colors.white,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.brown,
            indicatorWeight: 3,
            tabs: [
              Tab(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                // icon: Icon(
                //   Icons.lock,
                //   color: Colors.white,
                // ),
              ),
              Tab(
                  child:  Text(
                    "Registration",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                // icon: Icon(
                //   Icons.person,
                //   color: Colors.white,
                // ),
              ),
            ],
          ),
        ),
        body: Container(
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
          child: TabBarView(
            children: [
              LoginTabPage(),
              RegistrationTabPage(),
            ],
          ),
        ),
      ),
    );
  }
}
