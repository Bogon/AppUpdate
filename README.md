# AppUpdate

[![CI Status](https://img.shields.io/travis/Bogon/AppUpdate.svg?style=flat)](https://travis-ci.org/Bogon/AppUpdate)
[![Version](https://img.shields.io/cocoapods/v/AppUpdate.svg?style=flat)](https://cocoapods.org/pods/AppUpdate)
[![License](https://img.shields.io/cocoapods/l/AppUpdate.svg?style=flat)](https://cocoapods.org/pods/AppUpdate)
[![Platform](https://img.shields.io/cocoapods/p/AppUpdate.svg?style=flat)](https://cocoapods.org/pods/AppUpdate)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

AppUpdate is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AppUpdate'
```

## Requirements
`AppUpdate` is written in Swift 5.0 Compatible with iOS 10.0+

## Usage
+ Swift
```Swift
UpdateProvider.shared.updateVersion(update_url: "https://xxxxxxx", channel: "distrbution")
```

+ Objective-C
```Objective-C
@import AppUpdate;

[[UpdateProvider shared] updateVersionWithUpdate_url: @"https://xxxxxxx" channel: @"distrbution" bundleID: @"com.xxx.yyy"];
```

## Author

Bogon, zhangqixcu@gmail.com

## License

AppUpdate is available under the MIT license. See the LICENSE file for more info.
