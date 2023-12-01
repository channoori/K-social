import '../k_social_platform_interface.dart';
import 'data/models/access_token.dart';
import 'data/models/login_data.dart';

class FacebookLogin {
  Future<LoginData> login(List<String> permissions) {
    return KSocialPlatform.instance.login(permissions);
  }

  Future<AccessToken?> get accessToken => KSocialPlatform.instance.accessToken;

  Future<Map<String, dynamic>> getUserInfo({String fields = "name, email, picture.width(200)"}) {
    return KSocialPlatform.instance.getUserInfo(fields: fields);
  }

  Future<void> logout() => KSocialPlatform.instance.logout();
}
