import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelancer_app/assistantMethods/saved_methods.dart';
import '../global/global.dart';
import '../jobScreen/home_screen.dart';
import '../models/jobs.dart';
import 'package:http/http.dart'as http;




class ApplyScreen extends StatefulWidget
{
  String? proposalID;
  double? totalAmount;
  String? employerUID;
  String? unit;
  String? employerName;
  jobs? model;


  ApplyScreen({ this.proposalID, this.totalAmount, this.employerUID, this.unit, required this.employerName, });

  @override
  State<ApplyScreen> createState() => _ApplyScreen();
}



class _ApplyScreen extends State<ApplyScreen>
{
  String contractId = DateTime.now().millisecondsSinceEpoch.toString();



  contractDetails()
  {
    saveContractDetailsForUser(
        {
          "proposalID": widget.proposalID,
          "amount":widget.totalAmount,
          "unit":widget.unit,
          "employerName":widget.employerName,
          "email": sharedPreferences!.getString("email"),
          "contractBy": sharedPreferences!.getString("uid"),
          "productIDs": sharedPreferences!.getStringList("userBookmark"),
          "paymentDetails": "Cash Transfer",
          "contractTime": contractId,
          "contractId": contractId,
          "employerUID":widget.employerUID,
          "isSuccess": true,
          "status": "normal",
        }).whenComplete(()
    {
      saveContractDetailsForEmployer(
          {
            "proposalID": widget.proposalID,
            "amount":widget.totalAmount,
            "unit":widget.unit,
            "employerName":widget.employerName,
            "contractBy": sharedPreferences!.getString("uid"),
            "email": sharedPreferences!.getString("email"),
            "productIDs": sharedPreferences!.getStringList("userBookmark"),
            "paymentDetails": "Cash Transfer",
            "contractTime": contractId,
            "contractId": contractId,
            "isSuccess": true,
            "employerUID":widget.employerUID,
            "status": "normal",
          }).whenComplete(()
      {
        BookmarkMethods().clearBookmark(context);


        
        //send push notification

        sendNotificationToSeller(
          widget.employerUID.toString(),
          contractId,
        );
        
        Fluttertoast.showToast(msg: "Congratulations, submission has been sent successfully.");

        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));

        contractId="";
      });
    });
  }

  saveContractDetailsForUser(Map<String, dynamic> orderDetailsMap) async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("contracts")
        .doc(contractId)
        .set(orderDetailsMap);
  }

  saveContractDetailsForEmployer(Map<String, dynamic> orderDetailsMap) async
  {
    await FirebaseFirestore.instance
        .collection("contracts")
        .doc(contractId)
        .set(orderDetailsMap);
  }

  sendNotificationToSeller(employerUID, contractID)async {
    String employerDeviceToken = "";

   await FirebaseFirestore.instance
        .collection("employers")
        .doc(employerUID)
        .get()
        .then((snapshot) {
      if (snapshot.data()!["employerDeviceToken"] != null) {
        employerDeviceToken = snapshot.data()!["employerDeviceToken"].toString();


      }
    });

    notificationFormat(
      employerDeviceToken,
      contractID,
      sharedPreferences!.getString("name"),
    );
  }

  notificationFormat(employerDeviceToken, contractID, userName) {
    Map<String, String> headerNotification = {
      'Content-Type': 'application/json',
      'Authorization': fcmServerToken,
    };

    Map bodyNotification = {
      'body':
      "Dear employer, New Contract (# $contractID) has contract Successfully from user $userName. \nPlease Check Now",
      'title': "New Contract",
    };

    Map dataMap = {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      "userContractId": contractID,
    };

    Map officialNotificationFormat = {
      'notification': bodyNotification,
      'data': dataMap,
      'priority': 'high',
      'to': employerDeviceToken,
    };

    http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: headerNotification,
      body: jsonEncode(officialNotificationFormat),
    );
  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.asset("images/contract.png"),

          const SizedBox(height: 12,),

          ElevatedButton(
              onPressed: ()
              {
                contractDetails();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff1651ea),
                fixedSize: const Size(290, 40),
              ),
              child: const Text(
                "submit"
              ),
          ),

          const SizedBox(height: 10.0,),

          ElevatedButton(
            onPressed: ()
            {
              Navigator.pop(context);
            //  Navigator.push(context, MaterialPageRoute(builder: (c)=>SavedScreen()));

            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              fixedSize: const Size(290, 40),
            ),
            child: const Text(
                "Cancel"
            ),
          ),

        ],
      ),
    );
  }
}
