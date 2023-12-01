import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k_social/facebook/data/enums/login_status.dart';
import 'package:k_social/facebook/data/models/login_data.dart';
import 'package:k_social/k_social.dart';

class FacebookLoginNotifier extends StateNotifier<bool> {
  FacebookLoginNotifier(super.state);

  @override
  set state(bool value) {
    super.state = value;
  }

  @override
  get state => super.state;

  Future<(bool, String?)> login() async {
    bool result = false;
    String? message;
    try {
      final LoginData loginData = await KSocial.facebook.login(['public_profile', 'email']);
      if (loginData.status == LoginStatus.success) {
        final String token = loginData.accessToken!.token;
        // * get Facebook UserInfo
        final userData = await KSocial.facebook.getUserInfo();
        result = true;
      }
    } catch (e) {
      result = false;
      message = e.toString();
    }
    return (result, message);
  }
}

final facebookLoginStateProvider = StateNotifierProvider<FacebookLoginNotifier, bool>((ref) {
  return FacebookLoginNotifier(false);
});
