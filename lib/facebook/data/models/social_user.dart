// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../enums/login_platform.dart';
import 'facebook_user.dart';

class SocialUser {
  final LoginPlatform loginPlatform;
  final FacebookUser? facebookUser;
  SocialUser({
    required this.loginPlatform,
    this.facebookUser,
  });

  SocialUser copyWith({
    LoginPlatform? loginPlatform,
    FacebookUser? facebookUser,
  }) {
    return SocialUser(
      loginPlatform: loginPlatform ?? this.loginPlatform,
      facebookUser: facebookUser ?? this.facebookUser,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'loginPlatform': loginPlatform.title,
      'facebookUser': facebookUser?.toMap(),
    };
  }
}
