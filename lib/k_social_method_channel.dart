import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'facebook/data/enums/login_status.dart';
import 'facebook/data/models/access_token.dart';
import 'facebook/data/models/login_data.dart';
import 'k_social_platform_interface.dart';

class MethodChannelKSocial extends KSocialPlatform {
  bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;
  bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;

  @visibleForTesting
  final methodChannel = const MethodChannel('k_social');

  @override
  Future<LoginData> login(List<String> permissions) async {
    try {
      final result = await methodChannel.invokeMethod('facebook/login', {"permissions": permissions});
      final token = AccessToken.fromJson(Map<String, dynamic>.from(result));
      return LoginData(status: LoginStatus.success, accessToken: token);
    } on PlatformException catch (e) {
      return LoginData.parseException(e);
    }
  }

  @override
  Future<AccessToken?> get accessToken async {
    final result = await methodChannel.invokeMethod('facebook/getAccessToken');
    if (result == null) return null;
    return AccessToken.fromJson(Map<String, dynamic>.from(result));
  }

  @override
  Future<Map<String, dynamic>> getUserInfo({String fields = "name, email, picture.width(200)"}) async {
    final result = await methodChannel.invokeMethod('facebook/getUserInfo', {"fields": fields});
    return isAndroid ? jsonDecode(result) : Map<String, dynamic>.from(result);
  }

  @override
  Future<bool> logout() async {
    final bool result = await methodChannel.invokeMethod('facebook/logout') ?? false;
    return result;
  }
}
