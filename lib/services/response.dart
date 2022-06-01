class Response {
  bool isSuccess;
  String message;
  dynamic data;

  Response(this.isSuccess, {required this.message, this.data});
}
