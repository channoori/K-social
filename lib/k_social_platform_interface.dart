import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'facebook/data/models/access_token.dart';
import 'facebook/data/models/login_data.dart';
import 'k_social_method_channel.dart';

abstract class KSocialPlatform extends PlatformInterface {
  KSocialPlatform() : super(token: _token);

  static final Object _token = Object();

  static KSocialPlatform _instance = MethodChannelKSocial();

  static KSocialPlatform get instance => _instance;

  static set instance(KSocialPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<LoginData> login(List<String> permissions) {
    throw UnimplementedError('facebookLogin() has not been implemented.');
  }

  Future<AccessToken?> get accessToken {
    throw UnimplementedError('accessToken() has not been implemented.');
  }

  Future<Map<String, dynamic>> getUserInfo({String fields = "name, email, picture.width(200)"}) {
    throw UnimplementedError('getUserInfo() has not been implemented.');
  }

  Future<bool> logout() {
    throw UnimplementedError('logout() has not been implemented.');
  }
}
