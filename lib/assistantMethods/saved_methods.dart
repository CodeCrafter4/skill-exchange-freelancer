import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../global/global.dart';
import 'saved_item_counter.dart';

class BookmarkMethods
{
  addItemToCart(String? itemId, int itemCounter, BuildContext context)
  {
    List<String>? tempList = sharedPreferences!.getStringList("userBookmark");
    try {
    tempList!.add("$itemId:$itemCounter"); //2367121:5

    //save to firestore database
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .update(
        {
          "userBookmark": tempList,
        }).then((value)
    {
      Fluttertoast.showToast(msg: "Applying.");

      //save to local storage
      sharedPreferences!.setStringList("userBookmark", tempList);

      //update item badge number
      Provider.of<BookmarkItemCounter>(context, listen: false).showBookmarkListItemsNumber();
    });
    } catch (e) {}
  }

  clearBookmark(BuildContext context)
  {
    //clear in local storage
    sharedPreferences!.setStringList("userBookmark", ["initialValue"]);

    List<String>? emptyCartList = sharedPreferences!.getStringList("userBookmark");

    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .update(
        {
          "userBookmark": emptyCartList,
        }).then((value)
    {
      //update item badge number
      Provider.of<BookmarkItemCounter>(context, listen: false).showBookmarkListItemsNumber();
    });
  }


  //2367121:5 ==> 2367121
  separateItemIDsFromUserCartList()
  {
    //2367121:5
    List<String>? userCartList = sharedPreferences!.getStringList("userBookmark");

    List<String> itemsIDsList = [];

      for (int i = 1; i < userCartList!.length; i++) {
        //2367121:5
        String item = userCartList[i].toString();
        var lastCharacterPositionOfItemBeforeColon = item.lastIndexOf(":");

        //2367121
        String getItemID = item.substring(
            0, lastCharacterPositionOfItemBeforeColon);
        itemsIDsList.add(getItemID);
      }

    return itemsIDsList;
  }

  //2367121:5 ==> 5
  separateItemQuantitiesFromUserCartList()
  {
    //2367121:5
    List<String>? userCartList = sharedPreferences!.getStringList("userBookmark");


    List<int> itemsQuantitiesList = [];
    for(int i=1; i<userCartList!.length; i++)
    {
      //2367121:5
      String item = userCartList[i].toString();

      // 0=[:] 1=[5]
      var colonAndAfterCharactersList = item.split(":").toList(); // 0=[:] 1=[5]

      //5
      var quantityNumber = int.parse(colonAndAfterCharactersList[1].toString());

      itemsQuantitiesList.add(quantityNumber);
    }


    return itemsQuantitiesList;
  }


  separateOrderItemIDs(productIDs)
  {
    //2367121:5
    List<String>? userCartList = List<String>.from(productIDs);

    List<String> itemsIDsList = [];
    for(int i=1; i<userCartList.length; i++)
    {
      //2367121:5
      String item = userCartList[i].toString();
      var lastCharacterPositionOfItemBeforeColon = item.lastIndexOf(":");

      //2367121
      String getItemID = item.substring(0, lastCharacterPositionOfItemBeforeColon);
      itemsIDsList.add(getItemID);
    }

    return itemsIDsList;
  }

  separateOrderItemsQuantities(productIDs)
  {
    //2367121:5
    List<String>? userCartList = List<String>.from(productIDs);


    List<String> itemsQuantitiesList = [];
    for(int i=1; i<userCartList.length; i++)
    {
      //2367121:5
      String item = userCartList[i].toString();

      // 0=[:] 1=[5]
      var colonAndAfterCharactersList = item.split(":").toList(); // 0=[:] 1=[5]

      //'5'
      var quantityNumber = int.parse(colonAndAfterCharactersList[1].toString());

      itemsQuantitiesList.add(quantityNumber.toString());
    }


    return itemsQuantitiesList;
  }
}