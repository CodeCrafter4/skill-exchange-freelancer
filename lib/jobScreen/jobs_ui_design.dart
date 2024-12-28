import 'package:flutter/material.dart';
import 'package:freelancer_app/models/jobs.dart';
import 'package:intl/intl.dart';
import 'jobs_details_screen.dart';

class ItemsUiDesignWidget extends StatefulWidget
{
  jobs? model;



  ItemsUiDesignWidget({this.model,});

  @override
  State<ItemsUiDesignWidget> createState() => _ItemsUiDesignWidgetState();
}

class _ItemsUiDesignWidgetState extends State<ItemsUiDesignWidget>
{
  var format = DateFormat("dd MMMM, yyyy ");
  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ItemsDetailsScreen(
          model: widget.model,
        ),));


      },
      child: Card(
        color: Colors.transparent,
        elevation: 10,
        shadowColor: Colors.white
        ,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [


                list(url: widget.model!.thumbnailUrl.toString(),name: widget.model!.itemTitle.toString(),desc:"Email: "+widget.model!.employerEmail.toString()),

                const Divider(height: 2.9,),


              ],
            ),
          ),
        ),
      ),
    );
  }

  ListTile list({required String url,required String name,required String desc}) {
    return ListTile(

      contentPadding: const EdgeInsets.only(top: 5, left: 10),
      leading: const CircleAvatar(
        radius: 30,

        backgroundImage: ExactAssetImage('images/go.png'),
      ),
      title: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19

            ),),

          ],
        ),
      ),

      subtitle: Padding(
        padding: EdgeInsets.all( 5,),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(desc, maxLines: 2,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.justify,
              ),
            ),

            Container(
              decoration: const BoxDecoration(
              ),
              padding: EdgeInsets.all( 10,),

              child: Text(
                overflow: TextOverflow.ellipsis,
               "Due Date: ${format.format(widget.model!.dueDate?.toUtc() as DateTime)}",
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.lightBlue,
                )
              ),

            ),


          ],
        ),

      ),

    );

  }

}
