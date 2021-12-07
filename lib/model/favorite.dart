
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritedCountries extends ChangeNotifier{
  FavoritedCountries(){
    fillList();
  }

  var  list = <String>[];


  void fillList() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("favorite")) {
      list = prefs.getStringList("favorite")!;
      notifyListeners();
    }
  }

  void changeCountry(String country) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(list.contains(country)){
      list.remove(country);
    }else{
      list.add(country);
    }
    prefs.setStringList("favorite", list);
    notifyListeners();
  }

}