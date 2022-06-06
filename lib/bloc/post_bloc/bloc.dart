import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roomies_app/model/responses/company_search_response.dart';
import 'package:roomies_app/model/responses/generic_response.dart';
import 'package:provider/provider.dart';
import 'package:roomies_app/services/notification_service.dart';
import '../../model/responses/login_response.dart';
import '../../model/responses/sign_up_response.dart';
import '../../model/responses/search_history_response.dart';
import '../../services/api_service.dart';
import '../../services/cache_helper.dart';
import '../../utility/user_store.dart';
import 'event.dart';
import 'state.dart';
import 'package:roomies_app/utility/constants.dart' as Constants;


class AppBloc extends Bloc<AppEvent,AppState>{
 final ApiService apiService;

  AppBloc( {required this.apiService}) : super(InitialState());

AppState get initialState => InitialState();

@override
Stream<AppState> mapEventToState(AppEvent event) async* {
  CacheHelper cacheHelper = CacheHelper();
  if (event is SignUpEvent) {
    yield LoadingState();
    try{
      var responseString = await apiService.signUpUser(event.password,event.email,event.firstname,event.lastname,event.phone,event.ccode);
      var data = json.decode(responseString);
      var errorListener = GenericResponse.fromJson(data);
      if(errorListener.response!.status!=201){
        yield LoadFailureState(error: errorListener.response!.data);
      }
      else{

        SignUpResponse response = SignUpResponse.fromJson(data);
        yield SignUpPostedState(userId: response.response!.data!.toString(),
            signUpResponse: response);

      }
    }catch(e){
      yield LoadFailureState(error: e.toString());
    }
  }

  if (event is SignInEvent) {
    yield LoadingState();
    try{
      var responseString = await apiService.signInUser(event.email,event.password);
      var data = json.decode(responseString);
      var errorListener = GenericResponse.fromJson(data);
      if(errorListener.response!.status!=200){
        yield LoadFailureState(error: errorListener.response!.data);
      }
      else{
        SignInResponse response = SignInResponse.fromJson(data);
        yield SignInPostedState(
            signInResponse: response);
        cacheHelper.loginUser(response);
      }

    }catch(e){
      print('this failure :'+e.toString());
      yield LoadFailureState(error: e.toString());
    }
  }

  if (event is SearchCompanyEvent) {
    yield LoadingState();
    if(event.data!.isNotEmpty){
    try{
      var responseString;
      if(event.data!.contains('@')){
         responseString = await apiService.searchCompanyByEmail(event.data!);
      }else{
         responseString = await apiService.searchCompanyByPhone(event.data!);
      }

      var data = json.decode(responseString);
      var errorListener = GenericResponse.fromJson(data);
      if(errorListener.response!.status!=200){
        yield LoadFailureState(error: errorListener.response!.data);
      }
      else{
        CompanySearchResponse response = CompanySearchResponse.fromJson(data);


          yield CompanySearchedState(
              companySearchResponse: response);


          // NotificationService.showNotification('company identified',
          //     'we have identified ${response.response!.data![0]
          //         .phoneNumber} as ${response.response!.data![0]
          //         .companyName} \n Click to view more details');

        }
    }catch(e){
      print('this failure :'+e.toString());
      yield LoadFailureState(error: e.toString());
    }
    }else{
      yield LoadFailureState(error: 'You cannot make an empty search');

    }
  }


  if (event is SearchUserRecordEvent) {
    yield LoadingState();
    try{
     var user = Provider.of<UserStore>(event.context!,listen:false).currUser;

  var responseString = await apiService.searchUserRecord(user!.token);
  print('not token'+user.token!);
      var data = json.decode(responseString);
      var errorListener = GenericResponse.fromJson(data);
      if(errorListener.response!.status!=200){
        yield LoadFailureState(error: errorListener.response!.data);
      }
      else{
        UserSearchHistoryResponse response = UserSearchHistoryResponse.fromJson(data);

        yield UserSearchCompletedState(
            companySearchResponse: response);

        // if(response.response!.data!.isNotEmpty) {
        //   NotificationService.showNotification('company identified',
        //       'we have identified ${response.response!.data![0]
        //           .phoneNumber} as ${response.response!.data![0]
        //           .companyName} \n Click to view more details');
        // }
      }
    }catch(e){
      print('this failure :'+e.toString());
      yield LoadFailureState(error: e.toString());
    }
  }

  if (event is SaveUserReport) {
    yield LoadingState();
    try{
      var user = Provider.of<UserStore>(event.context!,listen:false).currUser;
      var content='';
      var url='';
      content =event.data!;

      if(event.data!.isEmpty || event.narration!.isEmpty){
        yield LoadFailureState(error: 'Please fill in both contact and narration fields');
      }
      else if(event.data!.contains('@')){
        url = Constants.FLAG_EMAIL;
      } else{
        url = Constants.FLAG_PHONE;

      }

      var responseString = await apiService.saveSearch(content,event.narration,user!.token,url);
      var data = json.decode(responseString);
      var errorListener = GenericResponse.fromJson(data);
      if(errorListener.response!.status!=200){
        yield LoadFailureState(error: errorListener.response!.data);
      }
      else{
        // CompanySearchResponse response = CompanySearchResponse.fromJson(data);
        yield SignInPostedState();
        // if(response.response!.data!.isNotEmpty) {
        //
        // }
      }
    }catch(e){
      print('this failure :'+e.toString());
      yield LoadFailureState(error: e.toString());
    }
  }

  if (event is VerifyUser) {
    yield LoadingState();
    try{
      var user = Provider.of<UserStore>(event.context!,listen:false).currUser;
      var content='';
      var url='';
      content =event.content!;

      if(event.content!.isEmpty || event.name!.isEmpty || event.email!.isEmpty){
        yield LoadFailureState(error: 'Please fill in both name and email fields');
      }
      else if(event.content!.contains('@')){
        url = Constants.VERIFY_EMAIL;
      } else{
        url = Constants.VERIFY_PHONE;

      }

      var responseString = await apiService.verifyUser(content,event.name,event.email,user!.token,url);
      var data = json.decode(responseString);
      var errorListener = GenericResponse.fromJson(data);
      if(errorListener.response!.status!=200){
        yield LoadFailureState(error: errorListener.response!.data);
      }
      else{
        // CompanySearchResponse response = CompanySearchResponse.fromJson(data);
        yield SignInPostedState();
        // if(response.response!.data!.isNotEmpty) {
        //
        // }
      }
    }catch(e){
      print('this failure :'+e.toString());
      yield LoadFailureState(error: e.toString());
    }
  }

  // if (event is PostItemEvent) {
  //   yield LoadingState();
  //   try{
  //    var user= Provider.of<UserStore>(event.context!,listen: false).currUser;
  //     GenericResponse response = await apiService.postItem(event.name,event.description,event.category_id,user!.id);
  //     if(response.error==false) {
  //       yield SignInPostedState();
  //     }else{
  //       yield LoadFailureState(error: response.message);
  //     }
  //   }catch(e){
  //     yield LoadFailureState(error: e.toString());
  //   }
  // }




}

}