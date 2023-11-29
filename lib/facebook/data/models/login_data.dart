import 'package:flutter/services.dart';

import '../enums/login_status.dart';
import 'access_token.dart';

class LoginData {
  final LoginStatus status;
  final String? message;
  final AccessToken? accessToken;

  LoginData({
    required this.status,
    this.message,
    this.accessToken,
  });

  static parseException(PlatformException exception) {
    late LoginStatus status;

    switch (exception.code) {
      case "CANCELLED":
        status = LoginStatus.cancelled;
      default:
        status = LoginStatus.failed;
    }

    return LoginData(status: status, message: exception.message);
  }
}
