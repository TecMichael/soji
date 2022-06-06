
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:roomies_app/model/responses/company_search_response.dart';
import 'package:roomies_app/model/responses/search_history_response.dart';

import '../../model/responses/login_response.dart';
import '../../model/responses/sign_up_response.dart';


abstract class AppState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends AppState {

  @override
  List<Object> get props => [];
}

class LoadingState extends AppState {
  @override
  List<Object> get props => [];
}

class LoadedState extends AppState {
 final  String? message,phone;

 LoadedState({ this.message,this.phone});

  @override
  List<Object> get props => [];
}

class LoadFailureState extends AppState {
  final String? error;

  LoadFailureState({@required this.error});

  @override
  List<Object> get props => [error.toString()];
}

class EmptyState extends AppState {
  final String? message;

  EmptyState({@required this.message});

  @override
  List<Object> get props => [message.toString()];
}

class SignUpPostedState extends AppState {
  final  String? phone,userId;
  final SignUpResponse? signUpResponse;
  SignUpPostedState({ this.phone,this.userId,this.signUpResponse});

  @override
  List<Object> get props => [];
}

class SignInPostedState extends AppState {
  final SignInResponse? signInResponse;
  SignInPostedState({ this.signInResponse});

  @override
  List<Object> get props => [];
}

class UserSearchCompletedState extends AppState {
  final UserSearchHistoryResponse? companySearchResponse;
  String? message;
  UserSearchCompletedState({ this.companySearchResponse, this.message});

  @override
  List<Object> get props => [];
}

class CompanySearchedState extends AppState {
  final CompanySearchResponse? companySearchResponse;
  CompanySearchedState({ this.companySearchResponse});

  @override
  List<Object> get props => [];
}

