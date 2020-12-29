#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_plugin_mipush.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_plugin_mipush'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin.'
  s.description      = <<-DESC
A new Flutter plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'
  s.frameworks = 'MobileCoreServices', 'SystemConfiguration', 'UserNotifications', 'CFNetwork', 'CoreTelephony'
  s.libraries = 'xml2', 'z', 'resolv'
  s.vendored_libraries = 'Classes/libMiPushSDK.a'
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
