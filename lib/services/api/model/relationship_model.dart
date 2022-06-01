import 'package:zeus_api/services/api/model/client_model.dart';
import 'package:zeus_api/services/api/model/role_model.dart';

class GetRelationshipResponse {
  List<Relationship>? relationship;

  GetRelationshipResponse({this.relationship});

  GetRelationshipResponse.fromJson(Map<String, dynamic> json) {
    if (json['Relationship'] != null) {
      relationship = [];
      json['Relationship'].forEach((v) {
        relationship!.add(Relationship.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (relationship != null) {
      data['Relationship'] = relationship!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Relationship {
  String? clientRoleRelId;
  String? permission;
  String? createdDateTime;
  String? createdById;
  dynamic role;
  dynamic client;

  Relationship(
      {this.clientRoleRelId,
      this.permission,
      this.createdDateTime,
      this.createdById,
      this.role,
      this.client});

  Relationship.fromJson(Map<String, dynamic> json) {
    clientRoleRelId = json['client_role_rel_id'];
    permission = json['permission'];
    createdDateTime = json['created_date_time'];
    createdById = json['created_by_id'];

    GetClientResponse getClientResponse = GetClientResponse.fromJson({
      "Client": [json['client']]
    });
    client = getClientResponse.client;
    GetRoleResponse getRoleResponse = GetRoleResponse.fromJson({
      "Role": [json['role']]
    });
    role = getRoleResponse.role;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clientRoleRelId'] = clientRoleRelId;
    data['permission'] = permission;
    data['createdById'] = createdById;
    data['createdDateTime'] = createdDateTime;
    data['client'] = client;
    data['role'] = role;
    return data;
  }
}
