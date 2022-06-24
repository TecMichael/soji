import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:roomies_app/model/responses/generic_response.dart';
import 'package:roomies_app/model/responses/home_response.dart';
import 'package:roomies_app/model/responses/item_by_category_response.dart';
import 'package:roomies_app/model/responses/user_item_relationship_response.dart';

import 'package:provider/provider.dart';
import 'package:roomies_app/utility/constants.dart' as Constants;
import '../model/responses/login_response.dart';
import '../model/responses/user_request_response.dart';
import 'api_client.dart';
import 'cache_helper.dart';

class ApiService {
  ApiClient _apiClient = ApiClient();
  CacheHelper cacheHelper = CacheHelper();


  Future<ItemByCategoryResponse> fetchItemByCategory(id) async {
    var header = <String, String>{
      "AppId":"61eb0f547b6ce40034254030",
      "Authorization":'test_sk_H0e541nQ9SWMfmnJNUL1F9lG0',
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var data;
    final response = await _apiClient.getWithHeaders(Constants.GET_ITEM_BY_CATEGORY+id,header);
    data = json.decode(response);
    print("item by category response " + response.toString());

    return  ItemByCategoryResponse.fromJson(data);

  }

  Future<HomeResponse> fetchHomeData() async {
    var header = <String, String>{
      "AppId":"61eb0f547b6ce40034254030",
      "Authorization":'test_sk_H0e541nQ9SWMfmnJNUL1F9lG0',
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var data;
    final response = await _apiClient.getWithHeaders(Constants.GET_HOME_DATA,header);
    data = json.decode(response);
    print("item by category response " + response.toString());

    return  HomeResponse.fromJson(data);

  }

  Future<UserRequestsResponse> fetchUserRequests(user_id) async {
    var header = <String, String>{
      "AppId":"61eb0f547b6ce40034254030",
      "Authorization":'test_sk_H0e541nQ9SWMfmnJNUL1F9lG0',
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var data;
    final response = await _apiClient.getWithHeaders(Constants.GET_USER_REQUESTS+user_id
        ,header);
    data = json.decode(response);
    print("item by category response " + response.toString());

    return  UserRequestsResponse.fromJson(data);

  }

  Future<CheckUserItemRelationshipResponse> fetchUserItemRelationship(user_id,item_id) async {
    var header = <String, String>{
      "AppId":"61eb0f547b6ce40034254030",
      "Authorization":'test_sk_H0e541nQ9SWMfmnJNUL1F9lG0',
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    var data;
    final response = await _apiClient.getWithHeaders(Constants.GET_USER_ITEM_RELATIONSHIP+user_id+'/'+item_id
        ,header);
    data = json.decode(response);
    print("item user relationship response " + response.toString());

    return  CheckUserItemRelationshipResponse.fromJson(data);

  }


  Future<String> signInUser(email,password) async {
    var body = <String, dynamic>{
      'email': email,
      'password':password
    };
    final response = await _apiClient.postFormWithHeader(Constants.SIGN_IN,body);
    print("login response " + response.toString());
    return  response;
    // return "{\"statusCode\":200,\"response\":{\"data\":{\"uid\":51,\"email\":\"joshua@gavel.ng\",\"password\":\"25d55ad283aa400af464c76d713c07ad\",\"token\":\"0c370241dd54edc7c53b38a2c479187a\",\"firstName\":\"Alabi\",\"lastName\":\"Joshua\",\"phoneNumber\":\"08123456789\",\"profileUrl\":null,\"dateRegistered\":\"2022-03-31T15:43:49.000Z\",\"searchCount\":0},\"status\":200}}";
  }

  Future<String> searchCompanyByPhone(phone) async {
    print('searching number in api service');

    var user = await cacheHelper.getCurrentUser();
    var key = user.response!.data!.token;
    var body = <String, dynamic>{
      'phoneNumber': phone,
    };
    var headers = <String, String>{
      "Accept": "text/plain",
      'Content-Type': "application/json-patch+json",
      'authorization': 'fed475c5ad9b44260ab6116d5b9f0bc7:'+key!
    };
    final response = await _apiClient.postFormWithCustomHeader(Constants.SEARCH_PHONE,body,headers);
    print(" response " + response.toString());
    return  response;
  }

  Future<String> searchCompanyByEmail(email) async {
    var user = await cacheHelper.getCurrentUser();
    var key = user.response!.data!.token;
    var body = <String, dynamic>{
      'email': email,
    };
    var headers = <String, String>{
      "Accept": "text/plain",
      'Content-Type': "application/json-patch+json",
      'authorization': 'fed475c5ad9b44260ab6116d5b9f0bc7:'+key!
    };
    final response = await _apiClient.postFormWithCustomHeader(Constants.SEARCH_EMAILS,body,headers);
    print(" response " + response.toString());
    return  response;
  }


  Future<String> searchUserRecord(key) async {
    var body = <String, dynamic>{
    };
    var headers = <String, String>{
      "Accept": "text/plain",
      'Content-Type': "application/json-patch+json",
      'authorization': 'fed475c5ad9b44260ab6116d5b9f0bc7:'+key
    };
    final response = await _apiClient.getWithHeaders(Constants.GET_USER_SEARCHES,headers);
    print(" response " + response.toString());
    return  response;
  }




  // Future<GenericResponse> requestForItem(item_id,user_id,status) async {
  //   var body = <String, dynamic>{
  //     'item_id': item_id,
  //     'user_id':user_id,
  //     'status':status,
  //   };
  //   var data;
  //   final response = await _apiClient.postForm(Constants.REQUEST_ITEM,body);
  //   data = json.decode(response);
  //   print("item request response " + response.toString());
  //   return  GenericResponse.fromJson(data);
  // }

  Future<String> signUpUser(password,email,firstname,lastname,phone,ccode) async {
    var body = <String, dynamic>{
      'password':password,
      'email':email,
      'firstName':firstname,
      'lastName':lastname,
      'phoneNumber':phone,
      // 'countryCode':ccode

    };
    // var data;
    final response = await _apiClient.postFormWithHeader(Constants.SIGN_UP,body);
    // data = json.decode(response);
    print("register response " + response.toString());
    return  response;
  }

  Future<String> saveSearch(content,reason,key,url) async {
    var body = <String, dynamic>{
      'content':content,
      'reason':reason,

    };
    var headers = <String, String>{
      "Accept": "text/plain",
      'Content-Type': "application/json-patch+json",
      'authorization': 'fed475c5ad9b44260ab6116d5b9f0bc7:'+key
    };
    // var data;
    final response = await _apiClient.postFormWithCustomHeader(url,body,headers);
    // data = json.decode(response);
    print("register response " + response.toString());
    return  response;
  }


  Future<String> verifyUser(content,name,email,key,url) async {
    var body = <String, dynamic>{
      'content':content,
      'companyName':name,
      'companyEmail':email

    };
    var headers = <String, String>{
      "Accept": "text/plain",
      'Content-Type': "application/json-patch+json",
      'authorization': 'fed475c5ad9b44260ab6116d5b9f0bc7:'+key
    };
    // var data;
    final response = await _apiClient.postFormWithCustomHeader(url,body,headers);
    // data = json.decode(response);
    print("register response " + response.toString());
    return  response;
  }



}

