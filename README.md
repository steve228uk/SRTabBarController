# SRTabBarController
[![license](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=2592000)](https://github.com/steve228uk/SRTabBarController/blob/master/LICENSE)

`SRTabBarController` aims to replicate much of `UITabBarController`'s functionality for OS X. It acts as a visual tab bar for `NSTabView` and has a number of nifty features.

- Add tabs using segues right within your storyboard.
- Set text color, tint color, bar color, and item spacing in Interface Builder.
- Choose from 4 positions: Top, Bottom, Left, Right.
- Supports text & image, text only or image only tabs.
- Use translucent effects via `NSVisualEffectsView`.
- Written in Swift.

![Types of tab bars](https://github.com/steve228uk/SRTabBarController/blob/master/Screenshots/Types.gif)

## Installation

SRTabBarController can be installed manually by including all files within the `Pod` directory in your project. However, installation via CocoaPods is recommended.

````
pod 'SRTabBarController', :git => 'https://github.com/steve228uk/SRTabBarController.git'
````

## Usage

While `SRTabBarController` can be added to your project programatically, it is recommended that you use it in your storyboard. Just like `UITabBarController` tabs can be defined via segues. As custom relationship segues are unsupported as workaround has been used that utilises custom segues and identifiers to define tabs.
