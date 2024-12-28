import 'package:flutter/cupertino.dart';

class ProposalChanger extends ChangeNotifier
{
  int counter = 0;

  int get count=> counter;

  showSelectedAddress(dynamic newValue)
  {
    counter = newValue;
    notifyListeners();
  }
}