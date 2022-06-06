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

  SearchResultModel({this.isScam, this.searchedContent, this.description, this.dataset});

  SearchResultModel.fromJson(Map<String, dynamic> json) {
    isScam = json['isScam'];
    searchedContent = json['searchedContent'];
    description = json['description'];
    dataset =
    json['dataset'] != null ? new Dataset.fromJson(json['dataset']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isScam'] = this.isScam;
    data['searchedContent'] = this.searchedContent;
    data['description'] = this.description;
    if (this.dataset != null) {
      data['dataset'] = this.dataset!.toJson();
    }
    return data;
  }
}

class Dataset {
  int? id;
  String? companyName,description;
  String? phoneNumber;
  String? email;
  String? city;
  String? website;
  String? content;
  String? type;
  Null? addedBy;
  String? dateAdded;

  Dataset(
      {this.id,
        this.description,
        this.companyName,
        this.phoneNumber,
        this.email,
        this.city,
        this.website,
        this.content,
        this.type,
        this.addedBy,
        this.dateAdded});

  Dataset.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    description = json['description'];
    city = json['city'];
    website = json['website'];
    content = json['content'];
    type = json['type'];
    addedBy = json['addedBy'];
    dateAdded = json['dateAdded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyName'] = this.companyName;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['description'] = this.description;
    data['city'] = this.city;
    data['website'] = this.website;
    data['content'] = this.content;
    data['type'] = this.type;
    data['addedBy'] = this.addedBy;
    data['dateAdded'] = this.dateAdded;
    return data;
  }
}
