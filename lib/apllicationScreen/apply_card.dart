import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_app/models/jobs.dart';
import 'package:intl/intl.dart';
import 'apply_details_screen.dart';


class ApplyCard extends StatefulWidget
{
  int? itemCount;
  List<DocumentSnapshot>? data;
  String? orderId;
  List<String>? seperateQuantitiesList;

  ApplyCard({
    this.itemCount,
    this.data,
    this.orderId,
    this.seperateQuantitiesList,
  });

  @override
  State<ApplyCard> createState() => _ApplyCardState();
}

class _ApplyCardState extends State<ApplyCard>
{
  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(
      onTap: (){
               Navigator.push(context,MaterialPageRoute(builder: (c)=> ApplyDetailsScreen(contractID:widget.orderId,
       )));
      },
      child: Card(
        color: Colors.white,
        elevation: 10,
        shadowColor: Colors.indigo,
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          height: widget.itemCount! * 125, //2*125
          child: ListView.builder(
            itemCount: widget.itemCount,
            itemBuilder: (context, index)
            {
              jobs model = jobs.fromJson(widget.data![index].data() as Map<String, dynamic>);
               return placedOrdersItemsDesignWidget(model, context, widget.seperateQuantitiesList![index]);
            },
          ),
        ),
      ),
    );
  }
}


Widget placedOrdersItemsDesignWidget(jobs job, BuildContext context, itemQuantity)
{
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 120,
    color: Colors.transparent,
    child: Row(
      children: [

        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            job.thumbnailUrl.toString(),
            width: 120,
          ),
        ),

        const SizedBox(width: 10.0,),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(
                  height: 20,
                ),

                //title and unit
                Row(
                  children: [

                    Expanded(
                      child: Text(
                        job.itemTitle.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    const Text(
                      "UNIT ",
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      job.unit.toString(),
                      style: const TextStyle(
                        color: Colors.indigo,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                //x with quantity
                Row(
                  children: [

                     const Text(
                      "DueDat",
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 14,
                      ),
                    ),

                    Flexible(

                      child: Text(
                       // job.dueDate.toString(),

                            ": ${DateFormat("dd MMMM, yyyy").format(DateTime.parse(job.dueDate.toString()))}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),
        ),

      ],
    ),
  );
}
