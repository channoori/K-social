import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'facebook/data/models/access_token.dart';
import 'facebook/data/models/login_data.dart';
import 'k_social_method_channel.dart';

abstract class KSocialPlatform extends PlatformInterface {
  /// Constructs a KSocialPlatform.
  KSocialPlatform() : super(token: _token);

  static final Object _token = Object();

  static KSocialPlatform _instance = MethodChannelKSocial();

  /// The default instance of [KSocialPlatform] to use.
  ///
  /// Defaults to [MethodChannelKSocial].
  static KSocialPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [KSocialPlatform] when
  /// they register themselves.
  static set instance(KSocialPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<LoginData> facebookLogin(List<String> permissions) {
    throw UnimplementedError('facebookLogin() has not been implemented.');
  }

  Future<AccessToken?> get accessToken {
    throw UnimplementedError('accessToken() has not been implemented.');
  }

  Future<Map<String, dynamic>> getUserInfo({String fields = "name, email, picture.width(200)"}) {
    throw UnimplementedError('getUserInfo() has not been implemented.');
  }

  Future<void> logout() {
    throw UnimplementedError('logout() has not been implemented.');
  }
}
