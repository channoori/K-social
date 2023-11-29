#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint korea_social_login.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'korea_social_login'
  s.version          = '0.0.1'
  s.summary          = '빡쳐서 만든 한국 소셜 로그인 플러그인'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Channoori' => 'chsa2584613@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'

  s.dependency 'FBSDKCoreKit', '~> 16.2.1'
  s.dependency 'FBSDKLoginKit', '~> 16.2.1'

  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
