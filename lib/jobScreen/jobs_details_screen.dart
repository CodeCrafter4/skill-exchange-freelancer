
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelancer_app/models/jobs.dart';
import 'package:freelancer_app/widgets/appbar_bookmark_badge.dart';
import 'package:intl/intl.dart';
import '../assistantMethods/saved_methods.dart';
import '../savedScreens/saved_screen.dart';

class ItemsDetailsScreen extends StatefulWidget
{
  jobs? model;

  String? employerUID;
  double? totalAmount;

  ItemsDetailsScreen({this.model,});

  @override
  State<ItemsDetailsScreen> createState() => _ItemsDetailsScreenState();

}



class _ItemsDetailsScreenState extends State<ItemsDetailsScreen>
{
  int counterLimit = 1;
  bool isLoading = false;
  var format = DateFormat('dd MMMM, yyyy - hh:mm aa');
  String? unit="";

  @override
  Widget build(BuildContext context)
  {
    unit= widget.model!.unit;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithBookmarkBadge(
        employerUID: widget.model!.employerUID.toString(),
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.only(left: 40,right: 10),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ElevatedButton(

                onPressed: ()
                async {

                  int itemCounter = counterLimit;

                  List<String> itemsIDsList = BookmarkMethods().separateItemIDsFromUserCartList();

                  //1. check if item exist already in cart
                  if(itemsIDsList.contains(widget.model!.itemID))
                  {
                   Fluttertoast.showToast(msg: "Applied....");
                  }
                  else
                  {
                    //2. add item in bookmark
                    BookmarkMethods().addItemToCart(
                      widget.model!.itemID.toString(),
                      itemCounter,
                      context,
                    );
                  }

                  setState(() {
                  isLoading = true;
                });
              await Future.delayed(const Duration(seconds: 3));
                    setState(() {
                      isLoading = false;

                  });

                    Navigator.push(context, MaterialPageRoute(builder: (c)=>SavedScreen ( employerUID: widget.model?.employerUID.toString(), unit:widget.model!.unit.toString(), employerName:widget.model!.employerName.toString())));

                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  fixedSize: const Size(300, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: isLoading? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('loading...',style: TextStyle(fontSize: 18),),
                    SizedBox(width: 10,),

                    CircularProgressIndicator(color: Colors.white,strokeWidth: 2,),


                  ],
                ) : const Text(
                  "Apply Now",style: TextStyle(fontSize: 18,),
                )
            ),
          ),


        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.all(8.3),

              child: Align(
                alignment: Alignment.center,
                child: Image.network(
                  widget.model!.thumbnailUrl.toString(),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Text(
                "Job Title: ${widget.model!.itemTitle}" ,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.lightBlue,
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(13),
              child: Text(
                "Requirements:-\n\n ${widget.model!.longDescription}",
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "${widget.model!.unit} unit",
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.lightBlue,
                ),
              ),
            ),


            const Padding(
              padding: EdgeInsets.only(left: 8.0, right: 320.0),
              child: Divider(
                height: 1,
                thickness: 2,
                color: Colors.lightBlue,
              ),
            ),

            const SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
              child: Text(
                "Job posted by: ${widget.model!.employerName}",
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                  fontSize: 12,
                ),
              ),
            ),



            const SizedBox(height: 5,),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
              child: Text(
                "Employer Email: ${widget.model!.employerEmail}",
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(height: 5,),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
              child: Text(
                "Posted Date: ${format.format(widget.model!.publishedDate?.toUtc() as DateTime)}",
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                  fontSize: 12,
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
              child: Text(
                "Due Date: ${format.format(widget.model!.dueDate?.toUtc() as DateTime)}",
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0, right: 320.0),
              child: Divider(
                height: 1,
                thickness: 2,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 100,),
          ],
        ),
      ),
    );
  }

}
