class ApiException implements Exception {
  // Variables
  final int code;
  final String message;
  final String reason;

  // Fixed Code Messages
  static const String authorizationFailedMsg =
      "برجاء تسجيل الدخول والمحاولة مجددا.";
  static const String noInternetConnectionMsg =
      "برجاء التحقق من شبكة الانترنت و المحاولة مجددا.";
  static const String unknownErr = "حدث خطأ ما .. برجاء إعادة المحاولة.";

  ApiException({this.code, this.message, this.reason});

  @override
  String toString() {
    if (code == 500) return "حدث خطأ بالخادم برجاء المحاولة لاحقا";

    String _text = "";
    // _text += "خطأ ";
    //if (ServerVars.IS_DEBUG) _text += "($code) ";
    //  if (message.isNotEmpty) _text += "$message";
    if (reason.isNotEmpty) _text = "$reason";
    return _text;
  }
}
