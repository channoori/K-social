#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint k_social.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'k_social'
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
  
  # Facebook
  s.dependency 'FBSDKCoreKit', '~> 16.0.1'
  s.dependency 'FBSDKLoginKit', '~> 16.0.1'
  # Naver
  s.dependency 'naveridlogin-sdk-ios'
                     
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
