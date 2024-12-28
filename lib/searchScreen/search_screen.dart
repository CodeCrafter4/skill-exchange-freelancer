import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../EmployersScreen/employers_ui_design_widget.dart';
import '../models/employers.dart';



class SearchScreen extends StatefulWidget
{

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}




class _SearchScreenState extends State<SearchScreen>
{
  String sellerNameText = "";
  Future<QuerySnapshot>? storesDocumentsList;

  initializeSearchingStores(String textEnteredbyUser)
  {
    storesDocumentsList = FirebaseFirestore.instance
        .collection("jobsItems")
        .where("itemTitle", isGreaterThanOrEqualTo: textEnteredbyUser)
        .get();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              color: Colors.indigo
          ),
        ),
        automaticallyImplyLeading: true,
        title: TextField(
          onChanged: (textEntered)
          {
            setState(() {
              sellerNameText = textEntered;
            });

            initializeSearchingStores(sellerNameText);
          },
          decoration: InputDecoration(
            hintText: "Search job here...",
            hintStyle: const TextStyle(color: Colors.white54),
            suffixIcon: IconButton(
              onPressed: ()
              {
                initializeSearchingStores(sellerNameText);
              },
              icon: const Icon(Icons.search),
              color: Colors.white,
            ),
          ),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder(
        future: storesDocumentsList,
        builder: (context, AsyncSnapshot snapshot)
        {
          if(snapshot.hasData)
          {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index)
              {
                Employers model = Employers.fromJson(
                  snapshot.data.docs[index].data() as Map<String, dynamic>
                );

                return EmployerUIDesignWidget(
                  model: model,
                );
              },
            );
          }
          else
          {
            return const Center(
              child: Text(
                "No record found."
              ),
            );
          }
        },
      ),
    );
  }
}
