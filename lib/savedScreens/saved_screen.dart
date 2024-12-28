import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_app/assistantMethods/saved_methods.dart';
import 'package:freelancer_app/jobScreen/home_screen.dart';
import 'package:freelancer_app/savedScreens/saved_item_design_widget.dart';
import 'package:freelancer_app/contractsProposalScreens/proposal_screen.dart';
import 'package:freelancer_app/models/jobs.dart';
import 'package:freelancer_app/widgets/appbar_bookmark_badge.dart';
import 'package:provider/provider.dart';
import '../assistantMethods/saved_item_counter.dart';
import '../assistantMethods/total_amount.dart';
import '../jobScreen/jobs_details_screen.dart';
import '../splashScreen/my_splash_screen.dart';

class SavedScreen extends StatefulWidget
{
  String? employerUID;
  String? employerName;
  double? totalAmount ;
  String? unit;

  SavedScreen({this.employerUID,this.totalAmount, this.unit, this.employerName});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}



class _SavedScreenState extends State<SavedScreen>
{
  List<int>? itemQuantityList;
  double? totalAmount ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    Provider.of<TotalAmount>(context, listen: false).showTotalAmountOfCartItems(0);
    itemQuantityList = BookmarkMethods().separateItemQuantitiesFromUserCartList();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: ()=>_onBackButton(context),
        child:  Scaffold(
      backgroundColor: Colors.white,
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                color: Color(0xff0648f3),
              ),
            ),
            title: const Text(
              "Apply ",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: true,
          ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          const SizedBox(height: 10,),



          ElevatedButton(
              onPressed: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (c)=>ProposalScreen(
                  employerUID:widget.employerUID.toString(),
                  totalAmount:totalAmount?.toDouble(),
                  unit:widget.unit.toString(),
                  employerName:widget.employerName.toString(),

                )));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff1651ea),
                fixedSize: const Size(350, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Continue",style: TextStyle(fontSize: 18,),
              )
          ),

        ],
      ),
      body: CustomScrollView(
        slivers: [

          // query
          // model
          // design

          StreamBuilder(

              stream: FirebaseFirestore.instance
                  .collection("jobsItems")
                  .where("itemID", whereIn: BookmarkMethods().separateItemIDsFromUserCartList())
                  .orderBy("publishedDate", descending: true)
                  .snapshots(),


              builder: (context, AsyncSnapshot dataSnapshot)
              {
                if (dataSnapshot.hasData) {
                  //display
                  return SliverList(

                    delegate: SliverChildBuilderDelegate((context, index) {
                      jobs model = jobs.fromJson(
                          dataSnapshot.data.docs[index].data() as Map<
                              String,
                              dynamic>
                      );
                      if (itemQuantityList!.isEmpty) {
                        // The iterable is empty.
                        return const Scaffold(

                        );
                      }
                      else if  (index == 0) {
                        totalAmount = 0;
                        totalAmount = totalAmount! + (double.parse(model.unit!) *
                            itemQuantityList![index]);
                      }
                      else //==1 or greater than 1
                          {
                        totalAmount = totalAmount! + (double.parse(model.unit!) *
                            itemQuantityList![index]);
                      }

                      //1                              == 1
                      if (dataSnapshot.data.docs.length - 1 == index) {
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          Provider.of<TotalAmount>(context, listen: false)
                              .showTotalAmountOfCartItems(totalAmount as double);
                        });
                      }


                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BookmarkItemDesignWidget(
                          model: model,
                          quantityNumber: itemQuantityList![index],
                        ),
                      );
                    },
                      childCount: dataSnapshot.data.docs.length,
                    ),
                  );
                }
                else {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        "No items exists",
                      ),
                    ),
                  );
                }
              }

          ),

        ],
      ),
    ),

    );
  }

  _onBackButton(BuildContext context) {
    BookmarkMethods().clearBookmark(context);
    Navigator.push(context, MaterialPageRoute(builder: (c)=>HomeScreen()));
  }
}
