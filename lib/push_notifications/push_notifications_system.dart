import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import '../functions/functions.dart';
import '../global/global.dart';


class PushNotificationsSystem
{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //notifications arrived/received
  Future whenNotificationReceived(BuildContext context) async
  {
    //1. Terminated
    //When the app is completely closed and opened directly from the push notification
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? remoteMessage)
    {
      if(remoteMessage != null)
      {
        //open app and show notification data
        showNotificationWhenOpenApp(
          remoteMessage.data["userContractId"],
          context,
        );
      }
    });

    //2. Foreground
    //When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage)
    {
      if(remoteMessage != null)
      {
        //directly show notification data
        showNotificationWhenOpenApp(
          remoteMessage.data["userContractId"],
          context,
        );
      }
    });

    //3. Background
    //When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage)
    {
      if(remoteMessage != null)
      {
        //open the app - show notification data
        showNotificationWhenOpenApp(
          remoteMessage.data["userContractId"],
          context,
        );
      }
    });
  }

  //device recognition token
  Future generateDeviceRecognitionToken() async
  {
    String? registrationDeviceToken = await messaging.getToken();

    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .update(
        {
          "userDeviceToken": registrationDeviceToken,
        });

    messaging.subscribeToTopic("allEmployers");
    messaging.subscribeToTopic("allUsers");
  }
  showNotificationWhenOpenApp(userOrderId, context)
  {
    showReusableSnackBar(
      context,
      "your contract (# $userOrderId) has been Assigned successfully by the employer.",
    );
  }
}