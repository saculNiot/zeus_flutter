import 'dart:convert';

import '../api/networking.dart';
import '../response.dart';

class AuthRepo {
  final networking = Networking();

  Future<Response> createAccessToken({
    email,
    password,
  }) async {
    String body = jsonEncode({'email': email, 'password': password});
    print(body);
    String api = 'api/token/';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response =
        await networking.postData(api: api, body: body, headers: headers);

    if (response.isSuccess) {
      return Response(true, message: '', data: response.data);
    } else if (response.message.contains('No records')) {
      return Response(false, message: 'No records');
    }

    return Response(false, message: response.message);
  }
}
