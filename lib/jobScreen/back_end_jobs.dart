import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../global/global.dart';
import '../models/jobs.dart';
import 'jobs_ui_design.dart';


class back_end extends StatefulWidget
{
  @override
  State<back_end> createState() => _back_endState();
}



class _back_endState extends State<back_end>
{

  @override
  Widget build(BuildContext context)
  {
    return  Scaffold(

      backgroundColor: Colors.white,



      body:  Container(
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
        child: CustomScrollView(

          slivers: [

            //image slider
            SliverToBoxAdapter(

              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .13,
                  width: MediaQuery.of(context).size.width,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * .2,
                      aspectRatio: 16/9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: itemsImagesList.map((index)
                    {
                      return Builder(builder: (BuildContext c)
                      {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 1.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image.asset(
                              index,
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      });
                    }).toList(),
                  ),
                ),
              ),
            ),


            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("jobsItems")

                  .where("itemTitle", isEqualTo: "BackEnd")
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
                      jobs model = jobs.fromJson(
                          dataSnapshot.data.docs[index].data() as Map<String, dynamic>
                      );

                      return ItemsUiDesignWidget(
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


      ),
    );

  }
}
