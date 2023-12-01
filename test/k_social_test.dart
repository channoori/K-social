import 'package:flutter_test/flutter_test.dart';
import 'package:k_social/facebook/data/models/access_token.dart';
import 'package:k_social/facebook/data/models/login_data.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockKSocialPlatform with MockPlatformInterfaceMixin {
  Future<AccessToken?> get accessToken => throw UnimplementedError();

  Future<LoginData> facebookLogin(List<String> permissions) {
    throw UnimplementedError();
  }

  Future<Map<String, dynamic>> getUserInfo({String fields = "name, email, picture.width(200)"}) {
    throw UnimplementedError();
  }

  Future<void> logout() {
    throw UnimplementedError();
  }
}

void main() {}
