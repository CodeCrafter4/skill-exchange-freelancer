import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../global/global.dart';
import '../models/proposal.dart';
import '../ratingScreen/rate_seller_screen.dart';
import '../splashScreen/my_splash_screen.dart';
import 'package:http/http.dart'as http;


class ProposalDesign extends StatelessWidget
{
  Proposal? model;
  String? contractStatus;
  String? contractId;
  String?  employerUID;
  String? unit;
  String? orderByUser;
  String? totalUnit;

  ProposalDesign({
    this.model,
    this.contractStatus,
    this.contractId,
    this.employerUID,
    this.unit,
    this.orderByUser,
    this.totalUnit,
  });
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
      "Dear employer,  Contract is done (# $contractID) has received Successfully by user $userName. \nPlease Check Now",
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
    return Column(
      children: [

        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Applications Proposal:',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
          ),
        ),

        const SizedBox(
          height: 6.0,
        ),



        const SizedBox(
          height: 20,
        ),

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            model!.UserProposal.toString(),
            textAlign: TextAlign.justify,
            style: const TextStyle(
                color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        GestureDetector(
          onTap: ()
          {
            if(contractStatus == "normal")
            {
              //update unit

              Navigator.push(context, MaterialPageRoute(builder: (context) => MySplashScreen()));

            }
            else if(contractStatus == "normal")
            {
              //implement contract Received feature

              FirebaseFirestore.instance
                  .collection("contracts")
                  .doc(contractId)
                  .update(
                  {
                    "status": "Assigned",
                  }).whenComplete(()
              {

                FirebaseFirestore.instance
                    .collection("users")
                    .doc(orderByUser)
                    .collection("contracts")
                    .doc(contractId)
                    .update(
                    {
                      "status": "Assigned",
                    });

                //send notification to seller

                Fluttertoast.showToast(msg: "contract started Successfully.");
                Navigator.push(context, MaterialPageRoute(builder: (context) => MySplashScreen()));
              });
            }

            else if(contractStatus == "Assigned")
            {
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(sharedPreferences!.getString("uid"))
                  .update(
                  {
                    "unit": (double.parse(previousUnit)) + (double.parse(unit!)),
                  });
              //implement contract Received feature

              FirebaseFirestore.instance
                  .collection("contracts")
                  .doc(contractId)
                  .update(
                  {
                    "status": "ended",
                  }).whenComplete(()
              {
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(orderByUser)
                    .collection("contracts")
                    .doc(contractId)
                    .update(
                    {
                      "status": "ended",
                    });

                //send notification to Employer
                sendNotificationToSeller(employerUID, contractId);

                Fluttertoast.showToast(msg: "Confirmed Successfully.");
                Navigator.push(context, MaterialPageRoute(builder: (context) => MySplashScreen()));
              });
            }
            else if(contractStatus == "ended")
            {

              //implement Rate this employer feature
              Navigator.push(context, MaterialPageRoute(builder: (context) => RateSellerScreen(
                  employerId:employerUID,
              )));

            }
            else
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MySplashScreen()));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Container(
              decoration: const BoxDecoration(
                 color: Colors.indigo,

              ),

              width: MediaQuery.of(context).size.width - 40,
              height: contractStatus == "ended" ? 60 : MediaQuery.of(context).size.height * .07,
              child: Center(
                child: Text(
                  contractStatus == "ended"
                      ? "Do you want to Rate this Employer?"
                      : contractStatus == "Assigned"
                      ? "when you done the job \n and send to employer?, \nClick to confirm."
                      : contractStatus == "normal"
                      ? "Not assigned by Employer, \nWait..."
                      : "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
