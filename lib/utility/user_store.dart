import 'package:flutter/material.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:roomies_app/model/responses/home_response.dart';
import 'package:roomies_app/services/cache_helper.dart';

import '../model/responses/login_response.dart';
import '../model/responses/sign_up_response.dart';

class UserStore extends ChangeNotifier {
  /// Internal, private state of the cart.
  User? currUser ;
  CacheHelper cacheHelper=CacheHelper();
  List<Category> categoryList=[];
  Mixpanel? mixpanel;



  void initMixPanel() async{
    mixpanel = await Mixpanel.init("12ee3cf398f805c6b4163cc243a4b4ef", optOutTrackingDefault: false);

  }

  void fetchCurrentUser( ) async{
    SignInResponse response =await cacheHelper.getCurrentUser();
    currUser = response.response!.data!;
    notifyListeners();
  }

  void setCategories(List<Category> categories) async{
    categoryList = categories;
    notifyListeners();
  }


}