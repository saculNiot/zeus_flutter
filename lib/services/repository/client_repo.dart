import 'dart:convert';

import 'package:zeus_api/services/api/model/client_model.dart';

import '../api/model/auth_model.dart';
import '../api/networking.dart';
import '../response.dart';

class ClientRepo {
  final networking = Networking();

  Future<Response> getAllClients({accessToken}) async {
    Map<String, String> headers = {'Authorization': 'Bearer $accessToken'};

    var response = await networking.getData(
        path: 'get_all_client_by_createdby_id', headers: headers);

    if (response.isSuccess && response.data != null) {
      GetClientResponse getClientResponse =
          GetClientResponse.fromJson(response.data);

      return Response(true, data: getClientResponse.client, message: '');
    } else if (response.message.contains('No records')) {
      return Response(false, message: 'No records');
    }

    return Response(false, message: response.message);
  }

  Future<Response> getClientById({accessToken, clientId}) async {
    Map<String, String> headers = {'Authorization': 'Bearer $accessToken'};
    String path = "clientId=$clientId";
    var response = await networking.getData(
        path: 'get_client_by_id?$path', headers: headers);

    if (response.isSuccess && response.data != null) {
      GetClientResponse getClientResponse =
          GetClientResponse.fromJson(response.data);

      return Response(true, data: getClientResponse.client, message: '');
    } else if (response.message.contains('No records')) {
      return Response(false, message: 'No records');
    }

    return Response(false, message: response.message);
  }

  Future<Response> saveClient(
      {accessToken,
      createdById,
      clientId,
      name,
      List<ClientAttribute>? attribute}) async {
    Client client = Client(
        createdById: createdById,
        clientId: clientId,
        name: name,
        attribute: attribute ?? []);
    String body = jsonEncode(client);

    String api = 'save_client';
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

  Future<Response> deleteClient(
      {accessToken, clientId}) async {
    Client client = Client(
      clientId: clientId,
    );
    String body = jsonEncode(client);

    String api = 'delete_client';
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
