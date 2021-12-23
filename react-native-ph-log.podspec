require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name           = package['name']
  s.version        = package['version']
  s.summary        = package['summary']
  s.description    = package['description']
  s.author         = package['author']['name']
  s.license        = package['license']
  s.homepage       = package['homepage']
  s.source         = { :git => 'https://github.com/wonday/react-native-orientation-locker.git', :tag => "v#{s.version}" }
  s.requires_arc   = true
  s.ios.deployment_target = '11.0'
  s.preserve_paths = 'README.md', 'package.json', 'index.js'
  # s.source_files = "ios/**/*.{h,c,cc,cpp,m,mm,swift}"
  s.dependency     'React-Core'


  s.source_files = "ios/*", "ios/iOS/*", "ios/Clogan/*.{h,c}"
  s.public_header_files = "ios/*.h"

  s.subspec 'mbedtls' do |mbedtls|
    mbedtls.source_files = "ios/mbedtls/**/*.{h,c}"
    mbedtls.header_dir = 'mbedtls'
    mbedtls.private_header_files = "ios/mbedtls/**/*.h"
    mbedtls.pod_target_xcconfig = { "HEADER_SEARCH_PATHS" => "${PODS_ROOT}/react-native-ph-log/**"}
  end
end
