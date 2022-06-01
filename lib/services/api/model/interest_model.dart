class GetInterestTypeResponse {
  List<InterestTypeData>? interestTypeData;

  GetInterestTypeResponse({this.interestTypeData});

  GetInterestTypeResponse.fromJson(Map<String, dynamic> json) {
    if (json['InterestTypeData'] != null) {
      interestTypeData = [];
      json['InterestTypeData'].forEach((v) {
        interestTypeData!.add(new InterestTypeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.interestTypeData != null) {
      data['InterestTypeData'] =
          this.interestTypeData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class SaveUserInterestAndDetails {
  String? typeId;
  String? userId;
  String? profilePic;
  String? name;


  SaveUserInterestAndDetails(
      {this.typeId,
      this.userId,
      this.profilePic,
      this.name,});

  SaveUserInterestAndDetails.fromJson(Map<String, dynamic> json) {
    typeId = json['interest_types'];
    userId = json['user_id'];
    profilePic = json['profile_pic'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['interestTypes'] = this.typeId;
    data['userId'] = this.userId;
    data['profilePic'] = this.profilePic;
    data['name'] = this.name;
    return data;
  }
}

class InterestTypeData {
  String? typeId;
  String? typeName;
  String? typeImageUrl;

  InterestTypeData({
    this.typeId,
    this.typeName,
    this.typeImageUrl,
  });

  InterestTypeData.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    typeName = json['type_name'];
    typeImageUrl = json['type_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type_id'] = this.typeId;
    data['type_name'] = this.typeName;
    data['type_image_url'] = this.typeImageUrl;

    return data;
  }
}

class UserInterestData {
  String? typeId;
  String? userId;
  String? profilePic;
  String? name;

  UserInterestData({
    this.typeId,
    this.userId,
    this.profilePic,
    this.name,
  });

  UserInterestData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    typeId = json['type_id'];
    name = json['name'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['typeId'] = this.typeId;
    data['name'] = this.name;
    data['profilePic'] = this.profilePic;

    return data;
  }
}
