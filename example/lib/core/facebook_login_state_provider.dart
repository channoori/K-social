import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k_social/facebook/data/enums/login_status.dart';
import 'package:k_social/facebook/data/models/login_data.dart';
import 'package:k_social/k_social.dart';

import 'user_state_provider.dart';

class FacebookLoginNotifier extends StateNotifier<bool> {
  FacebookLoginNotifier(super.state, this.ref);

  Ref ref;

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
        // * get Facebook UserInfo
        final userData = await KSocial.facebook.getUserInfo();
        ref.read(userStateProvider.notifier).state = userData;
        result = true;
      }
    } catch (e) {
      result = false;
      message = e.toString();
    }
    state = result;
    return (result, message);
  }

  Future<bool> logout() async {
    final result = await KSocial.facebook.logout();
    state = !result;
    return result;
  }
}

final facebookLoginStateProvider = StateNotifierProvider<FacebookLoginNotifier, bool>((ref) {
  return FacebookLoginNotifier(false, ref);
});
