class SignInResponse {
  int? statusCode;
  Response? response;

  SignInResponse({this.statusCode, this.response});

  SignInResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  User? data;
  int? status;

  Response({this.data, this.status});

  Response.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new User.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class User {
  int? uid;
  String? email;
  String? password;
  String? token;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? profileUrl;
  String? dateRegistered;
  int? searchCount;

  User(
      {this.uid,
        this.email,
        this.password,
        this.token,
        this.firstName,
        this.lastName,
        this.phoneNumber,
        this.profileUrl,
        this.dateRegistered,
        this.searchCount});

  User.fromJson(Map<String, dynamic> json) {
    uid = json['uid']??'';
    email = json['email']??'';
    password = json['password']??'';
    token = json['token']??'';
    firstName = json['firstName']??'';
    lastName = json['lastName']??'';
    phoneNumber = json['phoneNumber']??'';
    profileUrl = json['profileUrl']??'';
    dateRegistered = json['dateRegistered']??'';
    searchCount = json['searchCount']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['uid'] = this.uid;
    data['email'] = this.email;
    data['password'] = this.password;
    data['token'] = this.token;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phoneNumber'] = this.phoneNumber;
    data['profileUrl'] = this.profileUrl;
    data['dateRegistered'] = this.dateRegistered;
    data['searchCount'] = this.searchCount;
    return data;
  }
}
