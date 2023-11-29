import 'package:flutter_test/flutter_test.dart';
import 'package:k_social/k_social.dart';
import 'package:k_social/k_social_platform_interface.dart';
import 'package:k_social/k_social_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockKSocialPlatform
    with MockPlatformInterfaceMixin
    implements KSocialPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final KSocialPlatform initialPlatform = KSocialPlatform.instance;

  test('$MethodChannelKSocial is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelKSocial>());
  });

  test('getPlatformVersion', () async {
    KSocial kSocialPlugin = KSocial();
    MockKSocialPlatform fakePlatform = MockKSocialPlatform();
    KSocialPlatform.instance = fakePlatform;

    expect(await kSocialPlugin.getPlatformVersion(), '42');
  });
}
