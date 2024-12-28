
import 'package:flutter/material.dart';
import 'package:freelancer_app/models/employers.dart';

class jobsCategoryUiDesignWidget extends StatefulWidget
{
  Employers? model;
  BuildContext? context;

  jobsCategoryUiDesignWidget({super.key, this.model, this.context,});

  @override
  State<jobsCategoryUiDesignWidget> createState() => _jobsCategoryUiDesignWidgetState();
}



class _jobsCategoryUiDesignWidgetState extends State<jobsCategoryUiDesignWidget>
{

  @override
  Widget build(BuildContext context)
  {

    return GestureDetector(
      onTap: ()
      {
         // Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(
         // model: widget.model,)));
      },

      child: Card(
        //color: Colors.white,
        elevation: 10,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width,

            child: Column(

              children: [
                const Divider(
                  height: 10,
                  color: Colors.black,
                  thickness: 2,
                ),
                list(url: widget.model!.photoUrl.toString(),name: widget.model!.email.toString(),desc:widget.model!.userDescription.toString(),msg:"" ),


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
      leading:  CircleAvatar(
        radius: 30,

        backgroundImage: NetworkImage(widget.model!.photoUrl.toString()),
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
          padding: EdgeInsets.only(right: 10),
            child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
        Text(desc,style: TextStyle(fontWeight: FontWeight.w500),),
    Container(
        decoration: const BoxDecoration(
            ),
    child: IconButton(tooltip: msg,
      onPressed: ()
      {

      },
      icon: const Icon(
        Icons.delete_sweep,
        color: Colors.pinkAccent,
      ),
    ),
    ),

          ],
        ),
      ),
    );
  }
}
