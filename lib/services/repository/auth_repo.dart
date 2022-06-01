import 'dart:convert';

import '../api/model/auth_model.dart';
import '../api/networking.dart';
import '../response.dart';

class AuthRepo {
  final networking = Networking();
  //user ID = Dbcode

  // Future<Response> getUserById({context, userId}) async {
  //   //String userID = await localStorage.getUserId();

  //   String path = 'userId=$userId';

  //   var response = await networking.getData(
  //     path: 'get_user_by_id?$path',
  //   );

  //   if (response.isSuccess && response.data != null) {
  //     GetUserByIdResponse getUseByIdResponse =
  //         GetUserByIdResponse.fromJson(response.data);

  //     return Response(true, data: getUseByIdResponse.user, message: '');
  //   } else if (response.message.contains('timeout')) {
  //     return Response(false,
  //         message:
  //             AppLocalizations.of(context)!.translate('timeout_exception'));
  //   } else if (response.message.contains('socket')) {
  //     return Response(false,
  //         message: AppLocalizations.of(context)!.translate('socket_exception'));
  //   } else if (response.message.contains('http')) {
  //     return Response(false,
  //         message: AppLocalizations.of(context)!.translate('http_exception'));
  //   } else if (response.message.contains('format')) {
  //     return Response(false,
  //         message: AppLocalizations.of(context)!.translate('format_exception'));
  //   }

  //   return Response(false,
  //       message: AppLocalizations.of(context)!.translate('no_records_found'));
  // }

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
