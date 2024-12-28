import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_app/apllicationScreen/apply_card.dart';
import 'package:freelancer_app/assistantMethods/saved_methods.dart';
import '../global/global.dart';




class HistoryScreen extends StatefulWidget
{
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}



class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              color: Colors.indigo
          ),
        ),
        title: const Text(
          "Jobs History",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("contracts")
            .where("status", isEqualTo: "ended")
            .where("contractBy", isEqualTo: sharedPreferences!.getString("uid"))
            .orderBy("contractTime", descending: true)
            .snapshots(),
        builder: (c, AsyncSnapshot dataSnapShot)
        {
          if(dataSnapShot.hasData)
          {
            return ListView.builder(
              itemCount: dataSnapShot.data.docs.length,
              itemBuilder: (c, index)
              {
                return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("jobsItems")
                      .where("itemID", whereIn: BookmarkMethods().separateOrderItemIDs((dataSnapShot.data.docs[index].data() as Map<String, dynamic>)["productIDs"]))
                      .where("contractBy", whereIn: (dataSnapShot.data.docs[index].data() as Map<String, dynamic>)["uid"])
                      .orderBy("publishedDate", descending: true)
                      .get(),
                  builder: (c, AsyncSnapshot snapshot)
                  {
                    if(snapshot.hasData)
                    {
                      return ApplyCard(
                        itemCount: snapshot.data.docs.length,
                        data: snapshot.data.docs,
                        orderId: dataSnapShot.data.docs[index].id,
                        seperateQuantitiesList: BookmarkMethods().separateOrderItemsQuantities((dataSnapShot.data.docs[index].data() as Map<String, dynamic>)["productIDs"]),
                      );
                    }
                    else
                    {
                      return const Center(
                        child: Text(
                          "No data exists.",
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
          else
          {
            return const Center(
              child: Text(
                "No data exists.",
              ),
            );
          }
        },
      ),
    );
  }
}
