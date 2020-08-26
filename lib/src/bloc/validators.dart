import 'dart:async';

class Validators {
  static final RegExp emailValidationRegEx = RegExp(
    r"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$",
    caseSensitive: false,
  );

  final StreamTransformer<String, String> emailValidationTransformer =
      StreamTransformer.fromHandlers(handleData: (String email, sink) {
    if (emailValidationRegEx.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError("Enter a valid email");
    }
  });

  final StreamTransformer<String, String> passwordValidationTransformer =
      StreamTransformer.fromHandlers(handleData: (String password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError("Enter a password longer than 6 characters");
    }
  });

  static bool validateEmail(String email) {
    return emailValidationRegEx.hasMatch(email);
  }

  static bool validatePassword(String password) {
    return password.length >= 6;
  }
}
