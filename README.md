# MKProgress
An iOS Simple Swift Progress HUD 


![image](https://github.com/kamirana4/MKProgress/blob/master/_PNG/1.png)

## Requirements

- iOS 9.0+
- Swift 3.0+
- Xcode 8.0+ 

## Installation

MKProgress is only available via [CocoaPods](http://cocoapods.org):

```ruby
pod 'MKProgress', '~> 1.0.5'
```
If you want to use the latest features of MKProgress use normal external source dependencies.

```ruby
pod 'MKProgress', :git => 'https://github.com/kamirana4/MKProgress.git'
```

This will pull the latest master branch everytime you do 'pod isntall'

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

Hide the Progress HUD:
```swift

MKProgress.hide()
```

## Customization

MKProgress can be customized via the following configurations:

```swift

MKProgress.config.width = 64.0
MKProgress.config.height = 64.0
MKProgress.config.activityIndicatorStyle = .whiteLarge
MKProgress.config.activityIndicatorColor = .black
MKProgress.config.hudColor = .white
MKProgress.config.cornerRadius = 16.0
MKProgress.config.backgroundColor = UIColor.init(white: 0, alpha: 0.55)
MKProgress.config.preferredStatusBarStyle = .lightContent
MKProgress.config.prefersStatusBarHidden = false
```

## Licence

MKProgress is released under the MIT license. See LICENSE for details




