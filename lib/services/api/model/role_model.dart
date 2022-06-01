import 'dart:convert';

import 'client_model.dart';

class GetRoleResponse {
  List<Role>? role;

  GetRoleResponse({this.role});

  GetRoleResponse.fromJson(Map<String, dynamic> json) {
    if (json['Role'] != null) {
      role = [];
      json['Role'].forEach((v) {
        role!.add(Role.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (role != null) {
      data['Role'] = role!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Role {
  String? roleId;
  String? name;
  List<RoleAttribute>? attribute;
  String? createdDateTime;
  String? createdById;
  List<Client>? clients;

  Role({
    this.roleId,
    this.name,
    this.attribute,
    this.createdDateTime,
    this.createdById,
    this.clients,
  });

  Role.fromJson(Map<String, dynamic> json) {
    roleId = json['role_id'];
    name = json['name'];
    GetRoleAttributeResponse getRoleAttributeResponse =
        GetRoleAttributeResponse.fromJson({"attribute": json['attribute']});
    attribute = getRoleAttributeResponse.attribute;
    createdDateTime = json['created_date_time'];
    createdById = json['created_by_id'];
    // roles = json['qr_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roleId'] = roleId;
    data['name'] = name;
    data["attribute"] = attribute;
    data['createdById'] = createdById;
    data['createdDateTime'] = createdDateTime;

    return data;
  }
}

class GetRoleAttributeResponse {
  List<RoleAttribute>? attribute;

  GetRoleAttributeResponse({this.attribute});

  GetRoleAttributeResponse.fromJson(Map<String, dynamic> json) {
    if (json['attribute'] != null) {
      attribute = [];
      json['attribute'].forEach((v) {
        attribute!.add(RoleAttribute.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (attribute != null) {
      data['attribute'] = attribute!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RoleAttribute {
  String? attributeId;
  String? key;
  String? value;

  RoleAttribute({
    this.attributeId,
    this.key,
    this.value,
  });

  RoleAttribute.fromJson(Map<String, dynamic> json) {
    attributeId = json['role_attr_id'];
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['role_attr_id'] = attributeId;
    data['key'] = key;
    data['value'] = value;

    return data;
  }
}
