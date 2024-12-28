import 'package:flutter/material.dart';
import 'package:freelancer_app/models/jobs.dart';
import 'package:intl/intl.dart';




class BookmarkItemDesignWidget extends StatefulWidget
{
  jobs? model;
  int? quantityNumber;




  BookmarkItemDesignWidget({this.model, this.quantityNumber,});

  @override
  State<BookmarkItemDesignWidget> createState() => _BookmarkItemDesignWidgetState();
}



class _BookmarkItemDesignWidgetState extends State<BookmarkItemDesignWidget>
{

  @override
  Widget build(BuildContext context)
  {

    return Card(
      color: Colors.black12,
      shadowColor: Colors.transparent,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [

              //image
              Image.network(
                widget.model!.thumbnailUrl.toString(),
                width: 140,
                height: 120,
              ),

              const SizedBox(width: 6,),

              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    //title
                    Text(
                      widget.model!.itemTitle.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8,),
                   Text(

                 "Due Date: ${DateFormat("dd MMMM, yyyy ").format(DateTime.parse( widget.model!.dueDate.toString()))}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),

                    const SizedBox(height: 8,),
                    //Price:unit
                    Row(
                      children: [



                        const Text(
                          "UNIT : ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),

                        Text(
                          widget.model!.unit.toString()+" unit ",
                          style: const TextStyle(
                            color: Colors.purpleAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),

                    const SizedBox(height: 4,),



                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
