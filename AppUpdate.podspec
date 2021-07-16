#
# Be sure to run `pod lib lint AppUpdate.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AppUpdate'
  s.version          = '0.1.0'
  s.summary          = 'AppUpdate 是iOS端APP更新类库.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  AppUpdate 是iOS端APP更新类库.
                       DESC

  s.homepage         = 'https://github.com/Bogon/AppUpdate'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Bogon' => 'zhangqixcu@gmail.com' }
  s.source           = { :git => 'https://github.com/Bogon/AppUpdate.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'AppUpdate/Classes/**/*'
  
  s.resource_bundles = {
    'AppUpdate' => ['AppUpdate/**/*.{xib,png,jpg,xcassets}']
  }

  # s.public_header_files = 'Pod/Classes/**/*'
  s.frameworks = 'UIKit', 'Foundation'
  s.dependency 'Alamofire', '~> 4.8.2'
  s.dependency 'HandyJSON', '~> 5.0.2'
  s.dependency 'SwiftyJSON'
end
