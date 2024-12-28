import 'package:flutter/cupertino.dart';
import 'package:freelancer_app/global/global.dart';



class BookmarkItemCounter extends ChangeNotifier
{
  int BookmarkListItemCounter = sharedPreferences!.getStringList("userBookmark")!.length - 1;

  int get count => BookmarkListItemCounter;

  Future<void> showBookmarkListItemsNumber() async
  {
    BookmarkListItemCounter = sharedPreferences!.getStringList("userBookmark")!.length - 1;

    await Future.delayed(const Duration(), ()
    {
      notifyListeners();
    });
  }


}