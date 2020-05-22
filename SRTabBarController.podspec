Pod::Spec.new do |s|
  s.name             = "SRTabBarController"
  s.version          = "0.1.0"
  s.summary          = "A UITabBarController for OS X"

  s.description      = <<-DESC
`SRTabBarController` aims to replicate much of `UITabBarController`'s functionality on OS X. A parent tab controller can be added and segues used within interface builder to define the tabs. Options include:

- Translucency using `NSVisualEffectView`
- Positioned at the top, right, bottom, or left of the window
- Set options such as text color and tint color within Interface builder
- Text & Image, Text Only or Image only tabs

Behind the scenes `SRTabBarController` uses `NSTabView` to manage the tabs and maintain their state when switching between views.
                       DESC

  s.homepage         = "https://github.com/steve228uk/SRTabBarController"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Stephen Radford" => "steve228uk@gmail.com" }
  s.source           = { :git => "https://github.com/steve228uk/SRTabBarController.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/steve228uk'

  s.osx.deployment_target = '10.12'

  s.source_files = 'Pod/**/*'

end
