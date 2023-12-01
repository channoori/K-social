import 'package:k_social/facebook/data/models/social_user.dart';

import '../k_social_platform_interface.dart';
import 'data/enums/login_platform.dart';
import 'data/models/access_token.dart';
import 'data/models/facebook_user.dart';
import 'data/models/login_data.dart';

class FacebookLogin {
  Future<LoginData> login(List<String> permissions) {
    return KSocialPlatform.instance.login(permissions);
  }

  Future<AccessToken?> get accessToken => KSocialPlatform.instance.accessToken;

  Future<SocialUser> getUserInfo({String fields = "name, email, picture.width(200)"}) async {
    final Map<String, dynamic> user = await KSocialPlatform.instance.getUserInfo(fields: fields);
    final facebookUser = FacebookUser.fromJson(user);
    return SocialUser(loginPlatform: LoginPlatform.facebook, facebookUser: facebookUser);
  }

  Future<bool> logout() => KSocialPlatform.instance.logout();
}
