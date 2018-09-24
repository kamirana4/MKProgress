# MKProgress
An iOS Simple Swift Progress HUD 


![image](https://github.com/kamirana4/MKProgress/blob/master/Images/6.gif)
![image](https://github.com/kamirana4/MKProgress/blob/master/Images/5.gif)
![image](https://github.com/kamirana4/MKProgress/blob/master/Images/2.gif)
![image](https://github.com/kamirana4/MKProgress/blob/master/Images/4.gif)
![image](https://github.com/kamirana4/MKProgress/blob/master/Images/1.gif)

## Requirements

- iOS 9.0+
- Swift 3.0, 4.0, 4.1, 4.2
- Xcode 8.0, 9.0, 10

## Installation

MKProgress is only available via [CocoaPods](http://cocoapods.org):

```ruby
pod 'MKProgress', '~> 1.0.8'
```
If you want to use the latest features of MKProgress use normal external source dependencies.

```ruby
pod 'MKProgress', :git => 'https://github.com/kamirana4/MKProgress.git'
```

This will pull the latest master branch everytime you do 'pod isntall'

##For Xcdoe 9.4.1 or Swift < 4.2

```ruby
  pod 'MKProgress', '1.0.7'
```

## Usage

The included sample code shows how to use the Progress HUD. 


Import MKProgress:
```swift
import MKProgress
```

Show the Progress HUD:
```swift
MKProgress.show()
```

Show the Progress HUD with delay:
```swift
MKProgress.show(after: 0.1, animated: true)
```

Hide the Progress HUD:
```swift

MKProgress.hide()
```

## Customization

MKProgress can be customized via the following configurations:

```swift

MKProgress.config.hudType = .radial
MKProgress.config.width = 64.0
MKProgress.config.height = 64.0
MKProgress.config.hudColor = .white
MKProgress.config.backgroundColor = UIColor(white: 0, alpha: 0.55)
MKProgress.config.cornerRadius = 16.0
MKProgress.config.fadeInAnimationDuration = 0.2
MKProgress.config.fadeOutAnimationDuration = 0.25
MKProgress.config.hudYOffset = 15

MKProgress.config.circleRadius = 40.0
MKProgress.config.circleBorderWidth = 1.0
MKProgress.config.circleBorderColor = .darkGray
MKProgress.config.circleAnimationDuration = 0.9
MKProgress.config.circleArcPercentage = 0.85
MKProgress.config.logoImage: UIImage?  = nil
MKProgress.config.logoImageSize = CGSize(width: 40, height: 40)

MKProgress.config.activityIndicatorStyle = .whiteLarge
MKProgress.config.activityIndicatorColor = .black
MKProgress.config.preferredStatusBarStyle = .lightContent
MKProgress.config.prefersStatusBarHidden = false

```

## Licence

MKProgress is released under the MIT license. See LICENSE for details




