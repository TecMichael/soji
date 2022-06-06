class UserSearchHistoryResponse {
  int? statusCode;
  Response? response;

  UserSearchHistoryResponse({this.statusCode, this.response});

  UserSearchHistoryResponse.fromJson(Map<String, dynamic> json) {
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
  List<UserSearchHistory>? data;
  int? status;

  Response({this.data, this.status});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UserSearchHistory>[];
      json['data'].forEach((v) {
        data!.add(new UserSearchHistory.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class UserSearchHistory {
  int? id;
  int? uid;
  String? search;
  String? searchType;
  String? prediction;
  String? isScam;
  String? createdAt;

  UserSearchHistory(
      {this.id,
        this.uid,
        this.search,
        this.searchType,
        this.prediction,
        this.isScam,
        this.createdAt});

  UserSearchHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    search = json['search'];
    searchType = json['searchType'];
    prediction = json['prediction'];
    isScam = json['isScam']??'';
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['search'] = this.search;
    data['isScam'] = this.isScam;
    data['searchType'] = this.searchType;
    data['prediction'] = this.prediction;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
