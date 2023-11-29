import 'package:flutter_test/flutter_test.dart';
import 'package:k_social/facebook/data/models/access_token.dart';
import 'package:k_social/facebook/data/models/login_data.dart';
<<<<<<< HEAD
import 'package:k_social/k_social_platform_interface.dart';
=======
import 'package:k_social/k_social.dart';
import 'package:k_social/k_social_platform_interface.dart';
import 'package:k_social/k_social_method_channel.dart';
>>>>>>> main
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockKSocialPlatform with MockPlatformInterfaceMixin implements KSocialPlatform {
  @override
  // TODO: implement accessToken
  Future<AccessToken?> get accessToken => throw UnimplementedError();

  @override
  Future<LoginData> facebookLogin(List<String> permissions) {
    // TODO: implement facebookLogin
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getUserInfo({String fields = "name, email, picture.width(200)"}) {
    // TODO: implement getUserInfo
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}

<<<<<<< HEAD
void main() {}
=======
void main() {
  final KSocialPlatform initialPlatform = KSocialPlatform.instance;

  test('$MethodChannelKSocial is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelKSocial>());
  });
}
>>>>>>> main
