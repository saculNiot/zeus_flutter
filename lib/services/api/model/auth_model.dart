import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'dart:convert';


class GetWsUrlResponse {
  List<UserData>? user;

  GetWsUrlResponse({this.user});

  GetWsUrlResponse.fromJson(Map<String, dynamic> json) {
    if (json['WebService'] != null) {
      user = [];
      json['WebService'].forEach((v) {
        user!.add(new UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['WebService'] = this.user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetUserByIdResponse {
  List<UserData>? user;

  GetUserByIdResponse({this.user});

  GetUserByIdResponse.fromJson(Map<String, dynamic> json) {
    if (json['UserData'] != null) {
      user = [];
      json['UserData'].forEach((v) {
        user!.add(new UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['UserData'] = this.user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
  String? userId;
  String? email;
  String? password;
  String? name;
  String? status;
  String? qrId;
  String? profilePic;
  String? phPlatform;
  String? phModel;
  String? phId;
  String? phBrand;
  String? longitude;
  String? latitude;
  String? approval;
  String? joinDateTime;
  String? wsUrl;

  String?
      memberId; //When to lazy load, to avoid duplicated data retrieved if new data is inseted in the db

  UserData(
      {this.userId,
      this.email,
      this.password,
      this.name,
      this.status,
      this.qrId,
      this.profilePic,
      this.phPlatform,
      this.phModel,
      this.phId,
      this.phBrand,
      this.longitude,
      this.latitude,
      this.approval,
      this.joinDateTime,
      this.wsUrl,
      this.memberId});

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    status = json['status'];
    qrId = json['qr_id'];
    profilePic = json['profile_pic'];
    phPlatform = json['ph_platform'];
    phModel = json['ph_model'];
    phId = json['ph_id'];
    phBrand = json['ph_brand'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    approval = json['approval'];
    joinDateTime = json['join_date_time'];
    wsUrl = json['web_service'];
    memberId = json['member_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['password'] = this.password;
    data['name'] = this.name;
    data['status'] = this.status;
    data['qr_id'] = this.qrId;
    data['profile_pic'] = this.profilePic;
    data['ph_platform'] = this.phPlatform;
    data['ph_model'] = this.phModel;
    data['ph_id'] = this.phId;
    data['ph_brand'] = this.phBrand;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['approval'] = this.approval;
    data['join_date_time'] = this.joinDateTime;
    data['web_service'] = this.wsUrl;
    data['member_id'] = this.memberId;

    return data;
  }
}

class SaveAccount {
  String? userId;
  String? email;
  String? password;
  String? name;
  String? status;
  String? qrId;
  String? phPlatform;
  String? phModel;
  String? phId;
  String? phBrand;
  String? longitude;
  String? latitude;
  String? approval;

  SaveAccount(
      {this.userId,
      this.email,
      this.password,
      this.name,
      this.status,
      this.qrId,
      this.phPlatform,
      this.phModel,
      this.phId,
      this.phBrand,
      this.longitude,
      this.latitude,
      this.approval});

  SaveAccount.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    status = json['status'];
    qrId = json['qrId'];
    phPlatform = json['phPlatform'];
    phModel = json['phModel'];
    phId = json['phId'];
    phBrand = json['phBrand'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    approval = json['approval'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['email'] = this.email;
    data['password'] = this.password;
    data['name'] = this.name;
    data['status'] = this.status;
    data['qrId'] = this.qrId;
    data['phPlatform'] = this.phPlatform;
    data['phModel'] = this.phModel;
    data['phId'] = this.phId;
    data['phBrand'] = this.phBrand;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['approval'] = this.approval;

    return data;
  }
}

class UserNotifier extends ChangeNotifier {
  List<UserData> users = [];
  List<UserData> get userData => users;

  void addUserNotifier(UserData user, bool isNew) {
    if (isNew)
      this.users.insert(0, user);
    else
      this.users.add(user);

    notifyListeners();
  }

  void removeSingleUserNotifier(String userId) {
    this.users.removeWhere((user) => user.userId == userId);

    notifyListeners();
  }

  void updateSingleUserNotifier(UserData userData) {
    this.users[this.users.indexWhere((user) => user.userId == user.userId)] =
        userData;
    notifyListeners();
  }
}
