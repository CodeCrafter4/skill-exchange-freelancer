import 'package:freelancer_app/assistantMethods/saved_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';



SharedPreferences? sharedPreferences;
final itemsImagesList =
[
  //"slider/0.pnj",
  //"slider/1.jpg",
  "slider/2.png",
  "slider/3.png",
  "slider/4.png",
  "slider/5.jpg",
  "slider/6.png",
  "slider/7.png",
  "slider/8.jpg",
  "slider/9.png",
  "slider/10.png",
  "slider/11.png",
  "slider/12.png",
  "slider/13.png",
];
BookmarkMethods userbookmarkmethods=BookmarkMethods();
BookmarkMethods userSavedmethods=BookmarkMethods();
double countStarsRating = 0.0;
String titleStarsRating = "";
String previousUnit="";
String fcmServerToken="key=AAAAdNddJP0:APA91bHaXZFfrgJcqNhNPvDiWlkVM3VXX4BW-EtHjLKojpiyCroc4amNzmSWELnGYg54vV9KXn33oroVLVyJDlOFVYqrG3-cAlv_ezCZtxIdeb_3J34MYNnPUACl9irzRdcD5QkPHMIr";
