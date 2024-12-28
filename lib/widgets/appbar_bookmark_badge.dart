import 'package:flutter/material.dart';
import 'package:freelancer_app/assistantMethods/saved_item_counter.dart';
import 'package:freelancer_app/savedScreens/saved_screen.dart';
import 'package:provider/provider.dart';


class AppBarWithBookmarkBadge extends StatefulWidget implements PreferredSizeWidget
{
  PreferredSizeWidget? preferredSizeWidget;
  String? employerUID;

  AppBarWithBookmarkBadge({this.preferredSizeWidget, this.employerUID,});

  @override
  State<AppBarWithBookmarkBadge> createState() => _AppBarWithBadgeState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => preferredSizeWidget == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80 + AppBar().preferredSize.height);
}



class _AppBarWithBadgeState extends State<AppBarWithBookmarkBadge>
{
  @override
  Widget build(BuildContext context)
  {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Color(0xff0648f3),
        ),
      ),
      automaticallyImplyLeading: true,
      title: const Text(
        "job Detail",
        style: TextStyle(
          fontSize: 20,
          letterSpacing: 1,
        ),
      ),
      centerTitle: true,
      actions: const [
        Stack(
          // children: [
          //   IconButton(
          //       onPressed: ()
          //       {
          //     Navigator.push(context, MaterialPageRoute(builder: (c)=>SavedScreen(employerUID: widget.employerUID,)));
          //
          //       },
          //       icon: const Icon(
          //         Icons.menu,
          //         color: Colors.white,
          //       ),
          //   ),
          //   // Positioned(
          //   //   child: Stack(
          //   //     children:  [
          //   //
          //   //       const Icon(
          //   //         Icons.brightness_1,
          //   //         size: 20,
          //   //         color: Colors.deepPurple,
          //   //       ),
          //   //
          //   //       Positioned(
          //   //         top: 2,
          //   //         right: 6,
          //   //         child: Center(
          //   //           child: Consumer<BookmarkItemCounter>(
          //   //             builder: (context, counter ,c){
          //   //               return Text(
          //   //                 counter.count.toString(),
          //   //                 style: const TextStyle(color: Colors.white
          //   //                 ),
          //   //               );
          //   //             }
          //   //           )
          //   //         ),
          //   //       ),
          //   //
          //   //     ],
          //   //   ),
          //   // ),
          // ],
        ),
      ],
    );
  }
}
