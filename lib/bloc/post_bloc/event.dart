import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AppEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInEvent extends AppEvent {
  final  String? email,password;
   final BuildContext? context;
  SignInEvent({required this.email,this.password,this.context});
  @override
  List<Object> get props => [];
}

class SaveUserReport extends AppEvent {
  final  String? data,narration,amount;
  final BuildContext? context;
  SaveUserReport({required this.data,this.narration,this.amount, this.context});
  @override
  List<Object> get props => [];
}

class VerifyUser extends AppEvent {
  final  String? content,email,name;
  final BuildContext? context;
  VerifyUser({required this.content,this.email,this.name, this.context});
  @override
  List<Object> get props => [];
}

class SearchUserRecordEvent extends AppEvent {
  final BuildContext? context;
  SearchUserRecordEvent({this.context});
  @override
  List<Object> get props => [];
}

class SearchCompanyEvent extends AppEvent {
  final  String? data;
  int? type;
  SearchCompanyEvent({ this.data,this.type});
  @override
  List<Object> get props => [];
}

class SignUpEvent extends AppEvent{
  final  String? password,email,firstname,lastname,confirmPassword,phone,ccode;
  SignUpEvent({this.password,this.firstname,this.ccode,this.lastname,this.confirmPassword,this.email,this.phone});
  @override
  List<Object> get props => [];
}

