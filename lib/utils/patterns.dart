class MyPatterns {
  static const String _emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static final RegExp _emailRegularExpression = RegExp(_emailPattern);

  static const String _phonePattern = r'^(05)[0-9]{8}$';
  static final RegExp _phoneRegularExpression = RegExp(_phonePattern);

  static const String _creditCardPattern =
      r'^(?:4[0-9]{12}(?:[0-9]{3})?|[25][1-7][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$';
  static final RegExp _creditCardRegularExpression = RegExp(_creditCardPattern);

  static const String _textPattern = r'^[a-zA-Z ]*$';
  static final RegExp _textRegularExpression = RegExp(_textPattern);

  static bool emailIsValid(String email) {
    return _emailRegularExpression.hasMatch(email);
  }

  static bool phoneIsValid(String phone) {
    return _phoneRegularExpression.hasMatch(phone);
  }

  static bool isCreditCard(String cardNumber) {
    return _creditCardRegularExpression.hasMatch(cardNumber);
  }

  static bool isTextOnly(String text) {
    return _textRegularExpression.hasMatch(_textPattern);
  }
}
