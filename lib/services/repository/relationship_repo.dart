import 'dart:convert';

import 'package:zeus_api/services/api/model/client_model.dart';
import 'package:zeus_api/services/api/model/relationship_model.dart';

import '../api/networking.dart';
import '../response.dart';

class RelationshipRepo {
  final networking = Networking();

  Future<Response> getAllRelationships({accessToken}) async {
    Map<String, String> headers = {'Authorization': 'Bearer $accessToken'};

    var response = await networking.getData(
        path: 'get_all_relationship_by_createdby_id', headers: headers);

    if (response.isSuccess && response.data != null) {
      GetRelationshipResponse getRelationshipResponse =
          GetRelationshipResponse.fromJson(response.data);

      return Response(true,
          data: getRelationshipResponse.relationship, message: '');
    } else if (response.message.contains('No records')) {
      return Response(false, message: 'No records');
    }

    return Response(false, message: response.message);
  }

  Future<Response> getRelationshipById({accessToken, clientRoleRelId}) async {
    Map<String, String> headers = {'Authorization': 'Bearer $accessToken'};
    String path = "clientRoleRelId=$clientRoleRelId";
    var response = await networking.getData(
        path: 'get_relationship_by_id?$path', headers: headers);

    if (response.isSuccess && response.data != null) {
      GetRelationshipResponse getRelationshipResponse =
          GetRelationshipResponse.fromJson(response.data);

      return Response(true,
          data: getRelationshipResponse.relationship, message: '');
    } else if (response.message.contains('No records')) {
      return Response(false, message: 'No records');
    }

    return Response(false, message: response.message);
  }

  Future<Response> saveRelationship(
      {accessToken,
      createdById,
      clientRoleRelId,
      permission,
      client,
      role}) async {
    Relationship relationship = Relationship(
        createdById: createdById,
        clientRoleRelId: clientRoleRelId,
        permission: permission,
        client: client,
        role: role);
    String body = jsonEncode(relationship);

    String api = 'save_relationship';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess) {
      return Response(true, message: '', data: response.data);
    } else if (response.message.contains('No records')) {
      return Response(false, message: 'No records');
    }

    return Response(false, message: response.message);
  }

  Future<Response> deleteRelationship({accessToken, clientRoleRelId}) async {
    Relationship relationship = Relationship(
      clientRoleRelId: clientRoleRelId,
    );
    String body = jsonEncode(relationship);

    String api = 'delete_relationship';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    var response =
        await networking.deleteData(api: api, body: body, headers: headers);

    if (response.isSuccess) {
      return Response(true, message: '', data: response.data);
    } else if (response.message.contains('No records')) {
      return Response(false, message: 'No records');
    }

    return Response(false, message: response.message);
  }

  Future<Response> isAuthorized(
      {accessToken, clientId, roleId, permission}) async {
    Map<String, String> headers = {'Authorization': 'Bearer $accessToken'};
    String path = "clientId=$clientId&roleId=$roleId&permission=$permission";
    var response =
        await networking.getData(path: 'is_authorized?$path', headers: headers);

    if (response.isSuccess && response.data != null) {
      return Response(true, data: response.data, message: '');
    } else if (response.message.contains('No records')) {
      return Response(false, message: 'No records');
    }

    return Response(false, message: response.message);
  }
}
