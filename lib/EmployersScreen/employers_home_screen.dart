import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:freelancer_app/EmployersScreen/employers_ui_design_widget.dart';
import 'package:freelancer_app/global/global.dart';
import 'package:freelancer_app/models/employers.dart';
import 'package:freelancer_app/widgets/my_drawer.dart';


class EmployersHomeScreen extends StatefulWidget
{
  @override
  State<EmployersHomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<EmployersHomeScreen>
{



  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.indigo,
        title: const Text(
          "All Employers",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,

          ),
        ),
        centerTitle: true,

      ),
      body: CustomScrollView(
        slivers: [

          //image slider


          //query
          //model
          //design widget

          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("employers")
                .snapshots(),
            builder: (context, AsyncSnapshot dataSnapshot)
            {
              if(dataSnapshot.hasData)
              {
                return SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  staggeredTileBuilder: (c)=> const StaggeredTile.fit(1),
                  itemBuilder: (context, index)
                  {
                    // Employers model = Employers.fromJson(
                    //     dataSnapshot.data.docs[index].data() as Map<String, dynamic>
                    Employers model = Employers.fromJson(
                        dataSnapshot.data.docs[index].data() as Map<String, dynamic>
                    );

                    return EmployerUIDesignWidget(
                      model: model,
                    );
                  },
                  itemCount: dataSnapshot.data.docs.length,
                );
              }
              else
              {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      "No Data exists.",
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
