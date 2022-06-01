import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:zeus_api/utils/constants.dart';
import 'dart:io';
//import 'package:xml2json/xml2json.dart';

import '../response.dart';

class Networking {
  String url = Constants.url;
  String apiVer = Constants.apiVer;

  Future<Response> getData({required String path, headers}) async {
    try {
      http.Response response;

      response = await http
          .get(Uri.parse('$url/$apiVer/${path ?? ""}'), headers: headers)
          .timeout(const Duration(milliseconds: 30000));
      print('$url/$apiVer/${path ?? ""}');

      if (response.statusCode == 200) {
        return Response(true, data: jsonDecode(response.body), message: '');
      } else if (response.statusCode == 204) {
        print(response.statusCode);

        return Response(true, message: "No records", data: "No records");
      } else {
        String message = response.body;

        print(response.statusCode);
        print(message);

        return Response(
          false,
          message: response.body,
        );
      }
    } on TimeoutException {
      return Response(false, message: 'timeout', data: "Timeout Exception");
    } on SocketException {
      return Response(false, message: 'socket', data: "Socket Exception");
    } on FormatException catch (e) {
      print(e.toString());
      return Response(false, message: 'format', data: "Invalid Format");
    } on HttpException catch (e) {
      print(e.toString());
      return Response(false, message: 'http', data: "HTTP exception");
    }
  }

  Future<Response> postData({String? api, String? path, body, headers}) async {
    try {
      http.Response response = await http
          .post(Uri.parse('$url/$apiVer/$api${path ?? ""}'),
              body: body, headers: headers)
          .timeout(const Duration(seconds: 30));

      print('$url/$apiVer/$api${path ?? ""}');

      print('body: ' + body);
      print(response.statusCode);

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (response.body == 'true' || response.body == 'false') {
          print(response.body);

          return Response(true, data: response.body, message: '');
        } else if (response.body.startsWith('{')) {
          return Response(true, data: jsonDecode(response.body), message: '');
        } else {
          return Response(true, data: response.body, message: '');
        }
      } else if (response.statusCode == 204) {
        print(response.statusCode);

        return Response(true, message: "No records", data: "No records");
      } else {
        String message = response.body;

        print(response.statusCode);
        print(message);

        return Response(
          false,
          message: message,
        );
      }
    } on TimeoutException {
      return Response(false, message: 'timeout', data: "Timeout Exception");
    } on SocketException {
      return Response(false, message: 'socket', data: "Socket Exception");
    } on FormatException catch (e) {
      print(e.toString());
      return Response(false, message: 'format', data: "Invalid Format");
    } on HttpException catch (e) {
      print(e.toString());
      return Response(false, message: 'http', data: "HTTP exception");
    }
  }

  Future<Response> deleteData({String? api, String? path, body, headers}) async {
    try {
      http.Response response = await http
          .delete(Uri.parse('$url/$apiVer/$api${path ?? ""}'),
              body: body, headers: headers)
          .timeout(const Duration(seconds: 30));

      print('$url/$apiVer/$api${path ?? ""}');

      print('body: ' + body);
      print(response.statusCode);

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (response.body == 'true' || response.body == 'false') {
          print(response.body);

          return Response(true, data: response.body, message: '');
        } else if (response.body.startsWith('{')) {
          return Response(true, data: jsonDecode(response.body), message: '');
        } else {
          return Response(true, data: response.body, message: '');
        }
      } else if (response.statusCode == 204) {
        print(response.statusCode);

        return Response(true, message: "No records", data: "No records");
      } else {
        String message = response.body;

        print(response.statusCode);
        print(message);

        return Response(
          false,
          message: message,
        );
      }
    } on TimeoutException {
      return Response(false, message: 'timeout', data: "Timeout Exception");
    } on SocketException {
      return Response(false, message: 'socket', data: "Socket Exception");
    } on FormatException catch (e) {
      print(e.toString());
      return Response(false, message: 'format', data: "Invalid Format");
    } on HttpException catch (e) {
      print(e.toString());
      return Response(false, message: 'http', data: "HTTP exception");
    }
  }

  Future multiPartRequest(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse(url);

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile(
      'picture',
      stream,
      length,
      filename: basename(imageFile.path),
      contentType: new MediaType('image', 'jpg'),
    );

    request.files.add(multipartFile);
    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  }
}
