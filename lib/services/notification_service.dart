import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:roomies_app/bloc/post_bloc/event.dart';
import 'package:roomies_app/screens/search_screen.dart';
import 'package:roomies_app/services/api_service.dart';

import '../bloc/post_bloc/bloc.dart';
import '../model/responses/company_search_response.dart';
import '../model/responses/generic_response.dart';
import '../screens/dashboard.dart';
import 'navigator_service.dart';

class NotificationService extends StatelessWidget {


  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      static void configLocalNotification() {
    print('configuring');
    AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
        '@mipmap/ic_launcher');
    IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
    InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(
        initializationSettings, onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
        var data = json.decode(payload);
        CompanySearchResponse response = CompanySearchResponse.fromJson(data);
          Navigator.pushReplacement(
              NavigationService.navigatorKey.currentContext!,
              MaterialPageRoute(builder: (context) => BlocProvider<AppBloc>(
                  create: (context) => AppBloc(apiService: ApiService()),
                  child: DashboardScreen(response: response,)),
              ));

      }
    });
  }

  static void showNotification(title, body,payload) async {
    print('attempting to show');

    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        Platform.isAndroid ? 'com.example.soji' : 'com.example.soji',
        'Flutter chat demo',
        playSound: true,
        enableVibration: true,
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: BigTextStyleInformation('')

    );
    IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

     await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    platformChannelSpecifics,
    payload: payload,
    );
  }

  static void searchData(val) async{
    print('searching number');
    ApiService apiService = ApiService();
    try{
      var responseString;
      if(val.contains('@')){
        responseString = await apiService.searchCompanyByEmail(val);
      }else{
        responseString = await apiService.searchCompanyByPhone(val);
      }
      var data = json.decode(responseString);
      var errorListener = GenericResponse.fromJson(data);
      if(errorListener.response!.status!=200){
        // yield LoadFailureState(error: errorListener.response!.data);
      }
      else{

        CompanySearchResponse response = CompanySearchResponse.fromJson(data);
        // yield CompanySearchedState(
        //     companySearchResponse: response);
        if(response.response!.data!.isNotEmpty) {


            NotificationService.showNotification(response.response!.data![0].searchedContent!,
                '${response.response!.data![0].description!} \n Click to view more details',json.encode(response));


        }else{
          print('data empty');
        }
      }
    }catch(e){
      print('this failure :'+e.toString());
      // yield LoadFailureState(error: e.toString());
    }
    // appBloc.add(SearchCompanyEventByPhone(phones:[number]));
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
