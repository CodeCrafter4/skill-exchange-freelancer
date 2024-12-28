import 'package:flutter/material.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import 'package:freelancer_app/models/employers.dart';



class EmployerUIDesignWidget extends StatefulWidget
{
  Employers? model;

  EmployerUIDesignWidget({this.model,});

  @override
  State<EmployerUIDesignWidget> createState() => _EmployersUIDesignWidgetState();
}




class _EmployersUIDesignWidgetState extends State<EmployerUIDesignWidget>
{
  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(
      onTap: ()
      {
        // Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(
        //   model: widget.model,)));
      },


    child: Card(
      color: Colors.white24,
      elevation: 20,
      shadowColor: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const Divider(
                height: 10,
                color: Colors.grey,
                thickness: 2,
              ),
              list(url: widget.model!.photoUrl.toString(),name: widget.model!.name.toString(),desc:"status: "+widget.model!.status.toString() ,msg:"" ),

            ],
          ),
        ),
      ),
  ),

    );
}
    ListTile list({required String url,required String name,required String desc,required String msg}) {
      return ListTile(

        contentPadding: const EdgeInsets.only(top: 5, left: 10),
        leading: CircleAvatar(
            radius: 30,

            backgroundImage: NetworkImage( widget.model!.photoUrl.toString(),),
      ),
      title: Padding(
      padding: const EdgeInsets.only(right: 10),

      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

      Text(name, style: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 17

      ),),

      ],
      ),
      ),
        subtitle: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
        Text(desc,style: const TextStyle(fontWeight: FontWeight.w500),),

            Container(
              decoration: const BoxDecoration(
            ),
             // padding: const EdgeInsets.only(top: 40),
            child: SmoothStarRating(
            rating: widget.model!.ratings == null ? 0.0 : double.parse(widget.model!.ratings.toString()),
            starCount: 5,
            color: Colors.yellow,
            borderColor: Colors.black,
            size: 16,
            ),

            ),

            ],

      ),


      ),

      );

  }
}
