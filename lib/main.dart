import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_app/assistantMethods/proposal_changer.dart';
import 'package:freelancer_app/assistantMethods/saved_item_counter.dart';
import 'package:freelancer_app/assistantMethods/total_amount.dart';
import 'package:freelancer_app/global/global.dart';
import 'package:freelancer_app/splashScreen/my_splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences=await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(c)=> BookmarkItemCounter()),
        ChangeNotifierProvider(create:(c)=> TotalAmount()),
        ChangeNotifierProvider(create:(c)=> ProposalChanger()),
      ],
      child: MaterialApp(
        title: 'Freelancers App',
        theme: ThemeData(

          primarySwatch: Colors.indigo,
        ),
        debugShowCheckedModeBanner: false,
        home: MySplashScreen(),
      ),
    );
  }
}


