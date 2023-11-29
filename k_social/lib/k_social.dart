
import 'k_social_platform_interface.dart';

class KSocial {
  Future<String?> getPlatformVersion() {
    return KSocialPlatform.instance.getPlatformVersion();
  }
}
