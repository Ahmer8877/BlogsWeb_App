import 'package:flutter/cupertino.dart';

class MainLoadingProvider with ChangeNotifier {

  bool isLoading=false;

  Future<void> loading() async {

    try{
       isLoading=true;
      notifyListeners();
  }finally{
      isLoading=false;
      notifyListeners();
  }
  }
}