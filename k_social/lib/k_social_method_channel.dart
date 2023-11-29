import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'k_social_platform_interface.dart';

/// An implementation of [KSocialPlatform] that uses method channels.
class MethodChannelKSocial extends KSocialPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('k_social');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
