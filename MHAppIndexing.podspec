#
# Be sure to run `pod lib lint MHAppIndexing.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "MHAppIndexing"
  s.version          = "1.0.0"
  s.summary          = "Easily add content to CoreSpotlight search index."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
There are two ways to add content to CoreSpotlight:
1. Using MHCoreSpotlightManager to index objects directly
2. Using MHUserActivityManager to index objects via NSUserActivity
In every case the objects must confirm either the protocol MHCoreSpotlightObject or MHUserActivityObject.
                       DESC

  s.homepage         = "https://github.com/myhammerios/MHAppIndexing"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'Apache License Version 2.0'
  s.author           = { "MyHammer iOS-Team" => "ios-dev@myhammer.net" }
  s.source           = { :git => "https://github.com/myhammerios/MHAppIndexing.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'MHAppIndexing' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
