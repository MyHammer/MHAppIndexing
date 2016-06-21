# MHAppIndexing

Easily add content to CoreSpotlight search index.

## Usage

There are two ways to add content to CoreSpotlight:
1. Using MHCoreSpotlightManager to index objects directly
2. Using MHUserActivityManager to index objects via NSUserActivity
In every case the objects must confirm either the protocol MHCoreSpotlightObject or MHUserActivityObject.

Please see example code in project!

## Requirements

MHAppIndexing is based on CoreSpotlight framework. The minimum supported iOS version is iOS 9.0.

## Installation

Installation is done with [CocoaPods](http://cocoapods.org). Install it with:

```bash
$ gem install cocoapods
```

## Podfile

To integrate MHAppIndexing into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'

use_frameworks!

target 'TargetName' do
  pod 'MHAppIndexing', '1.0.0'
end
```

Then, run the following command:

```bash
$ pod install
```

## Author

Frank Lienkamp, frank.lienkamp@myhammer.net
Andre Heß, andre.hess@myhammer.net 

## License

MHAppIndexing is available under the Apache License 2.0. See the LICENSE file for more info.
