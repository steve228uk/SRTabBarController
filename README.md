# SRTabBarController
[![license](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=2592000)](https://github.com/steve228uk/SRTabBarController/blob/master/LICENSE) [![CocoaPods](https://img.shields.io/cocoapods/p/SRTabBarController.svg?maxAge=2592000)](https://cocoapods.org/pods/SRTabBarController) [![CocoaPods](https://img.shields.io/cocoapods/v/SRTabBarController.svg?maxAge=2592000)](https://cocoapods.org/pods/SRTabBarController)

`SRTabBarController` aims to replicate much of `UITabBarController`'s functionality for OS X. It acts as a visual tab bar for `NSTabView` and has a number of nifty features.

- Add tabs using segues right within your storyboard.
- Set text color, tint color, bar color, and item spacing in Interface Builder.
- Choose from 4 positions: Top, Bottom, Left, Right.
- Supports text & image, text only or image only tabs.
- Use translucent effects via `NSVisualEffectsView`.
- Written in Swift.

![Types of tab bars](https://github.com/steve228uk/SRTabBarController/blob/master/Screenshots/Types.gif)

> Check out this [screencast](https://www.youtube.com/watch?v=IOidp1Hq24M&feature=youtu.be) for some of the options available

## Installation

SRTabBarController can be installed manually by including all files within the `Pod` directory in your project. However, installation via CocoaPods is recommended.

````ruby
pod 'SRTabBarController', :git => 'https://github.com/steve228uk/SRTabBarController.git'
````

## Usage

While `SRTabBarController` can be added to your project programatically, it is recommended that you use it in your storyboard. Just like `UITabBarController` tabs can be defined via segues. As custom relationship segues are unsupported as workaround has been used that utilises custom segues and identifiers to define tabs.

**1 -** Drag a new `UIViewController` into your storyboard and set it as the root content view controller for your window.
**2 -** Set the class of the new controller to be `SRTabBarController` ensuring that the bundle is set correctly.

![Xcode Inspector](https://github.com/steve228uk/SRTabBarController/blob/master/Screenshots/inspector-1.png)

**3 -** Define tab bar properties from the Attributes inspector on the `SRTabBarController`.

![Attributes Inspector](https://github.com/steve228uk/SRTabBarController/blob/master/Screenshots/inspector-2.png)

**4 -** Create your view controllers for each tab and link your `SRTabBarController` to them using a Custom segue.

![Attributes Inspector](https://github.com/steve228uk/SRTabBarController/blob/master/Screenshots/segue.gif)

**5 -** Ensure each tab view controller has a title defined in the attributes inspector. This is used as the title of the tab.

**6 -** Okay, this is the trickiest part. Click on each of the segues you just created and define the following in the attributes inspector.

![Attributes Inspector](https://github.com/steve228uk/SRTabBarController/blob/master/Screenshots/inspector-3.png)

The index here defines the position it will be displayed in the tab bar. Optionally, you can provide the name of a **default** image within your app's assets. For example if you had a search tab that you wanted to be at position 1 and have an icon called Search you would set the following as the identifier `tab_1_Search`.

## Customizing SRTabBarController

Alongside the settings that can be defined within Interface Builder's inspector there are also a number of options that can be set by subclassing `SRTabBarController`. The `SRTabBar` itself is actually an `NSVisualEffectsView` so it's very easy to get those translucent effects users are familiar with in OS X.

**Location** - To customize the location on the screen set `tabBarLocation` to `.Top`, `.Right`, `.Bottom`, or `.Left`.

**Translucency** - To enable the visual effects turn set `tabBar?.translucent = true`.

**Visual Effects** - Check out the `NSVisualEffectsView` for some of the settings that can be enabled for the `tabBar`. You'll most likely want to change the `material` and `blendingMode`.

> Check out this [screencast](https://www.youtube.com/watch?v=IOidp1Hq24M&feature=youtu.be) for some of the options available
