import 'dart:convert';

class GetClientResponse {
  List<Client>? client;

  GetClientResponse({this.client});

  GetClientResponse.fromJson(Map<String, dynamic> json) {
    if (json['Client'] != null) {
      client = [];
      json['Client'].forEach((v) {
        client!.add(Client.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (client != null) {
      data['Client'] = client!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Client {
  String? clientId;
  String? name;
  List<ClientAttribute>? attribute;
  String? createdDateTime;
  String? createdById;
  // List<Role>? roles;

  Client({
    this.clientId,
    this.name,
    this.attribute,
    this.createdDateTime,
    this.createdById,
    // this.roles,
  });

  Client.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    name = json['name'];
    GetClientAttributeResponse getClientAttributeResponse =
        GetClientAttributeResponse.fromJson({"attribute": json['attribute']});
    attribute = getClientAttributeResponse.attribute;
    createdDateTime = json['created_date_time'];
    createdById = json['created_by_id'];
    // roles = json['qr_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clientId'] = clientId;
    data['name'] = name;
    data["attribute"] = attribute;
    data['createdById'] = createdById;
    data['createdDateTime'] = createdDateTime;

    return data;
  }
}

class GetClientAttributeResponse {
  List<ClientAttribute>? attribute;

  GetClientAttributeResponse({this.attribute});

  GetClientAttributeResponse.fromJson(Map<String, dynamic> json) {
    if (json['attribute'] != null) {
      attribute = [];
      json['attribute'].forEach((v) {
        attribute!.add(ClientAttribute.fromJson(v));
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

class ClientAttribute {
  String? attributeId;
  String? key;
  String? value;

  ClientAttribute({
    this.attributeId,
    this.key,
    this.value,
  });

  ClientAttribute.fromJson(Map<String, dynamic> json) {
    attributeId = json['client_attr_id'];
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['client_attr_id'] = attributeId;
    data['key'] = key;
    data['value'] = value;

    return data;
  }
}
