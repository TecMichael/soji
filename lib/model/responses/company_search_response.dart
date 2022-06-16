class CompanySearchResponse {
  int? statusCode;
  Response? response;

  CompanySearchResponse({this.statusCode, this.response});

  CompanySearchResponse.fromJson(Map<String, dynamic> json) {
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
  List<SearchResultModel>? data;
  int? status;

  Response({this.data, this.status});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SearchResultModel>[];
      json['data'].forEach((v) {
        data!.add(new SearchResultModel.fromJson(v));
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

class SearchResultModel {
  String? isScam;
  String? searchedContent;
  String? description;
  Dataset? dataset;
  String? isLogin;

  SearchResultModel(
      {this.isScam,
        this.searchedContent,
        this.description,
        this.dataset,
        this.isLogin});

  SearchResultModel.fromJson(Map<String, dynamic> json) {
    isScam = json['isScam'];
    searchedContent = json['searchedContent'];
    description = json['description'];
    dataset =
    json['dataset'] != null ? new Dataset.fromJson(json['dataset']) : null;
    isLogin = json['isLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isScam'] = this.isScam;
    data['searchedContent'] = this.searchedContent;
    data['description'] = this.description;
    if (this.dataset != null) {
      data['dataset'] = this.dataset!.toJson();
    }
    data['isLogin'] = this.isLogin;
    return data;
  }
}

class Dataset {
  int? id;
  String? companyName;
  String? phoneNumber;
  Null? email;
  Null? city;
  Null? website;
  String? pageHandle;
  Null? token;
  String? subEmail;
  String? subPhones;
  Null? password;
  String? verified;
  String? signupMode;
  String? claimed;
  int? visitorCount;
  Null? companyDocument;
  String? dateInserted;
  String? dateCreated;
  String? dateVerified;
  int? country;
  Null? about;
  String? dateCancelled;

  Dataset(
      {this.id,
        this.companyName,
        this.phoneNumber,
        this.email,
        this.city,
        this.website,
        this.pageHandle,
        this.token,
        this.subEmail,
        this.subPhones,
        this.password,
        this.verified,
        this.signupMode,
        this.claimed,
        this.visitorCount,
        this.companyDocument,
        this.dateInserted,
        this.dateCreated,
        this.dateVerified,
        this.country,
        this.about,
        this.dateCancelled});

  Dataset.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    city = json['city'];
    website = json['website'];
    pageHandle = json['pageHandle'];
    token = json['token'];
    subEmail = json['subEmail'];
    subPhones = json['subPhones'];
    password = json['password'];
    verified = json['verified'];
    signupMode = json['signupMode'];
    claimed = json['claimed'];
    visitorCount = json['visitorCount'];
    companyDocument = json['companyDocument'];
    dateInserted = json['dateInserted'];
    dateCreated = json['dateCreated'];
    dateVerified = json['dateVerified'];
    country = json['country'];
    about = json['about'];
    dateCancelled = json['dateCancelled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyName'] = this.companyName;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['city'] = this.city;
    data['website'] = this.website;
    data['pageHandle'] = this.pageHandle;
    data['token'] = this.token;
    data['subEmail'] = this.subEmail;
    data['subPhones'] = this.subPhones;
    data['password'] = this.password;
    data['verified'] = this.verified;
    data['signupMode'] = this.signupMode;
    data['claimed'] = this.claimed;
    data['visitorCount'] = this.visitorCount;
    data['companyDocument'] = this.companyDocument;
    data['dateInserted'] = this.dateInserted;
    data['dateCreated'] = this.dateCreated;
    data['dateVerified'] = this.dateVerified;
    data['country'] = this.country;
    data['about'] = this.about;
    data['dateCancelled'] = this.dateCancelled;
    return data;
  }
}
