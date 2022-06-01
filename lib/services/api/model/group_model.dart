import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'dart:convert';

import 'interest_model.dart';
import 'auth_model.dart';

class GetGroupByUserIdResponse {
  List<GroupData>? group;

  GetGroupByUserIdResponse({this.group});

  GetGroupByUserIdResponse.fromJson(Map<String, dynamic> json) {
    if (json['GroupData'] != null) {
      group = [];
      json['GroupData'].forEach((v) {
        group!.add(new GroupData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.group != null) {
      data['GroupData'] = this.group!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupData {
  String? userId;
  String? groupId;
  String? groupName;
  String? description;
  String? visibilityId;
  String? privacyId;
  String? groupQR;
  String? groupProfImage;
  String?
      memberId; //When to lazy load, to avoid duplicated data retrieved if new data is inseted in the db
  int? totalMembers;
  int? totalImages;
  List<InterestTypeData>? interests;

  GroupData({
    this.userId,
    this.groupId,
    this.groupName,
    this.description,
    this.visibilityId,
    this.privacyId,
    this.groupQR,
    this.groupProfImage,
    this.memberId,
    this.totalMembers,
    this.totalImages,
    this.interests,
  });

  GroupData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    groupId = json['group_id'];
    groupName = json['group_name'];
    description = json['description'];
    visibilityId = json['visibility_id'];
    privacyId = json['privacy_id'];
    visibilityId = json['visibility_id'];
    groupProfImage = json['profile_pic'];
    groupQR = json['group_qr'];
    memberId = json['member_id'];
    totalMembers = json['total_members'];
    totalImages = json['total_images'];
    GetInterestTypeResponse getInterestTypeResponse =
        GetInterestTypeResponse.fromJson(
            {"InterestTypeData": json['Interests']});
    interests = getInterestTypeResponse.interestTypeData;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['group_id'] = this.groupId;
    data['group_name'] = this.groupName;
    data['description'] = this.description;
    data['visibility_id'] = this.visibilityId;
    data['privacy_id'] = this.privacyId;
    data['profile_pic'] = this.groupProfImage;
    data['group_qr'] = this.groupQR;
    data['member_id'] = this.memberId;
    data['total_members'] = this.totalMembers;
    data['total_images'] = this.totalImages;
    data['Interests'] = this.interests;

    return data;
  }
}

class GetGroupMembersByGroupIdResponse {
  List<UserData>? memberList;

  GetGroupMembersByGroupIdResponse({this.memberList});

  GetGroupMembersByGroupIdResponse.fromJson(Map<String, dynamic> json) {
    if (json['GroupMembersData'] != null) {
      memberList = [];
      json['GroupMembersData'].forEach((v) {
        memberList!.add(new UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.memberList != null) {
      data['GroupMembersData'] =
          this.memberList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetGroupsByIdResponse {
  List<GroupData>? group;

  GetGroupsByIdResponse({this.group});

  GetGroupsByIdResponse.fromJson(Map<String, dynamic> json) {
    if (json['GroupData'] != null) {
      group = [];
      json['GroupData'].forEach((v) {
        group!.add(new GroupData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.group != null) {
      data['GroupData'] = this.group!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetPhotoByGroupIdResponse {
  List<PhotoData>? photo;

  GetPhotoByGroupIdResponse({this.photo});

  GetPhotoByGroupIdResponse.fromJson(Map<String, dynamic> json) {
    if (json['PhotoData'] != null) {
      photo = [];
      json['PhotoData'].forEach((v) {
        photo!.add(new PhotoData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.photo != null) {
      data['PhotoData'] = this.photo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PhotoData {
  String? userId;
  String? userName;
  String? photoId;
  String? photoUrl;
  String? uploadedDateTime;
  String?
      groupPhotoId; //When to lazy load, to avoid duplicated data retrieved if new data is inseted in the db

  PhotoData({
    this.userId,
    this.userName,
    this.photoId,
    this.photoUrl,
    this.uploadedDateTime,
    this.groupPhotoId,
  });

  PhotoData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    photoId = json['photo_id'];
    photoUrl = json['url'];
    uploadedDateTime = json['uploaded_date_time'];
    groupPhotoId = json['group_photo_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['photo_id'] = this.photoId;
    data['url'] = this.photoUrl;
    data['uploaded_date_time'] = this.uploadedDateTime;
    data['group_photo_id'] = this.groupPhotoId;

    return data;
  }
}

class GroupNotifier extends ChangeNotifier {
  List<GroupData> groups = [];
  List<GroupData> get groupsData => groups;
  //check if the current state of data is raw from db or the number has altered when the user use the applcation

  void addGroupNotifier(GroupData group, bool isNew) {
    if (isNew) {
      //new data is added, add data from the start
      this.groups.insert(0, group);
    } else {
      //old data(from db) is added, add data at the back
      this.groups.add(group);
    }

    notifyListeners();
  }

  void removeSingleGroupNotifier(String groupId) {
    this.groups.removeWhere((group) => group.groupId == groupId);

    notifyListeners();
  }

  void removeAllGroupNotifier() {
    this.groups.clear();

    notifyListeners();
  }

  void updateSingleGroupNotifier(GroupData groupData) {
    this.groups[this
        .groups
        .indexWhere((group) => group.groupId == groupData.groupId)] = groupData;

    notifyListeners();
  }

  List<GroupData> getAllGroups() {
    return this.groups;
  }
}

class PhotoNotifier extends ChangeNotifier {
  List<PhotoData> photos = [];
  List<PhotoData> get photosData => photos;

  void addPhotoNotifier(PhotoData photo, bool isNew) {
    if (isNew)
      this.photos.insert(0, photo);
    else
      this.photos.add(photo);

    notifyListeners();
  }
}

class SaveGroup {
  String? userId;
  String? groupId;
  String? groupName;
  String? description;
  bool? visibilityId;
  bool? privacyId;
  String? groupProfImage;
  String? interestTypes;
  String? groupQR;
  String? phPlatform;
  String? phModel;
  String? phId;
  String? phBrand;
  String? longitude;
  String? latitude;
  String? photos;

  SaveGroup({
    this.userId,
    this.groupId,
    this.groupName,
    this.description,
    this.visibilityId,
    this.privacyId,
    this.groupProfImage,
    this.interestTypes,
    this.groupQR,
    this.phPlatform,
    this.phModel,
    this.phId,
    this.phBrand,
    this.longitude,
    this.latitude,
    this.photos,
  });

  SaveGroup.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    groupId = json['group_id'];
    groupName = json['group_name'];
    description = json['description'];
    visibilityId = json['visibility_id'];
    privacyId = json['privacy_id'];
    groupProfImage = json['profile_pic'];
    interestTypes = json['interest_types'];
    groupQR = json['group_qr'];
    phPlatform = json['ph_platform'];
    phModel = json['ph_model'];
    phId = json['ph_id'];
    phBrand = json['ph_brand'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    photos = json['photos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['groupId'] = this.groupId;
    data['groupName'] = this.groupName;
    data['description'] = this.description;
    data['visibilityId'] = this.visibilityId;
    data['privacyId'] = this.privacyId;
    data['profilePic'] = this.groupProfImage;
    data['interestTypes'] = this.interestTypes;
    data['phPlatform'] = this.phPlatform;
    data['phModel'] = this.phModel;
    data['phId'] = this.phId;
    data['phBrand'] = this.phBrand;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['photos'] = this.photos;

    return data;
  }
}

class AddGroupMember {
  String? qrCode;
  String? selfQrId;

  AddGroupMember({
    this.qrCode,
    this.selfQrId,
  });

  AddGroupMember.fromJson(Map<String, dynamic> json) {
    qrCode = json['qr_code'];
    selfQrId = json['self_qr_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qrCode'] = this.qrCode;
    data['selfQrId'] = this.selfQrId;

    return data;
  }
}

class RemoveGroupMember {
  String? userId;
  String? deletedUserId;
  String? groupId;

  RemoveGroupMember({
    this.userId,
    this.deletedUserId,
    this.groupId,
  });

  RemoveGroupMember.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    deletedUserId = json['deleted_user_id'];
    groupId = json['groupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['deletedUserId'] = this.deletedUserId;
    data['groupId'] = this.groupId;

    return data;
  }
}
