import 'dart:convert';

import 'package:zeus_api/services/api/model/client_model.dart';
import 'package:zeus_api/services/api/model/role_model.dart';

import '../api/networking.dart';
import '../response.dart';

class RoleRepo {
  final networking = Networking();

  Future<Response> getAllRoles({accessToken}) async {
    Map<String, String> headers = {'Authorization': 'Bearer $accessToken'};

    var response = await networking.getData(
        path: 'get_all_role_by_createdby_id', headers: headers);

    if (response.isSuccess && response.data != null) {
      GetRoleResponse getRoleResponse = GetRoleResponse.fromJson(response.data);

      return Response(true, data: getRoleResponse.role, message: '');
    } else if (response.message.contains('No records')) {
      return Response(false, message: 'No records');
    }

    return Response(false, message: response.message);
  }

  Future<Response> getRoleById({accessToken, roleId}) async {
    Map<String, String> headers = {'Authorization': 'Bearer $accessToken'};
    String path = "roleId=$roleId";
    var response = await networking.getData(
        path: 'get_role_by_id?$path', headers: headers);

    if (response.isSuccess && response.data != null) {
      GetRoleResponse getRoleResponse = GetRoleResponse.fromJson(response.data);

      return Response(true, data: getRoleResponse.role, message: '');
    } else if (response.message.contains('No records')) {
      return Response(false, message: 'No records');
    }

    return Response(false, message: response.message);
  }

  Future<Response> saveRole(
      {accessToken,
      createdById,
      roleId,
      name,
      List<RoleAttribute>? attribute}) async {
    Role role = Role(
        createdById: createdById,
        roleId: roleId,
        name: name,
        attribute: attribute ?? []);
    String body = jsonEncode(role);

    String api = 'save_role';
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

  Future<Response> deleteRole({accessToken, roleId}) async {
    Role role = Role(
      roleId: roleId,
    );
    String body = jsonEncode(role);

    String api = 'delete_role';
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
}
