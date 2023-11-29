import 'package:plugin_platform_interface/plugin_platform_interface.dart';

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

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
