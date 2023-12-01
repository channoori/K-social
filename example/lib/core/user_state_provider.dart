import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k_social/facebook/data/enums/login_platform.dart';
import 'package:k_social/facebook/data/models/social_user.dart';

class UserStateNotifier extends StateNotifier<SocialUser> {
  UserStateNotifier(super.state);

  @override
  set state(SocialUser value) {
    super.state = value;
  }

  @override
  SocialUser get state => super.state;
}

final userStateProvider = StateNotifierProvider<UserStateNotifier, SocialUser>((ref) {
  return UserStateNotifier(
    SocialUser(
      loginPlatform: LoginPlatform.unknown,
    ),
  );
});
