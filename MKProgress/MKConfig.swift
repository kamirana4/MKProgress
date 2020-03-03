//
//  MKConfig.swift
//  MKProgress
//
//  Created by Muhammad Kamran on 4/9/18.
//  Copyright © 2018 Muhammad Kamran. All rights reserved.
//

import UIKit

public struct MKConfig {
    
    /**
     - Progress HUD background view's 'Width'.
     - Try to provide the equal 'Width' and 'Height'.
     - Default: 110.0
     */
    public var width: CGFloat = 110.0
    
    /**
     - Progress HUD background view's 'Height'.
     - Try to provide the equal 'Width' and 'Height'.
     - Default: 110.0
     */
    public var height: CGFloat = 110.0
    
    /**
     - Progress HUD activity indicator style
     - Default: .whiteLarge
     */
    public var activityIndicatorStyle: UIActivityIndicatorView.Style = .whiteLarge
    
    /**
     - Progress HUD activity indicator color
     - Default: .black
     */
    public var activityIndicatorColor: UIColor = .black
    
    /**
     - Progress HUD background's Color
     - Default: .white
     */
    public var hudColor: UIColor = .white
    
    /**
     - Progress HUD corner radius
     - Default: 16.0
     */
    public var cornerRadius: CGFloat = 16.0
    
    /**
     - Overlay color
     - Default: 'UIColor.init(white: 0, alpha: 0.55)'
     */
    public var backgroundColor: UIColor = UIColor(white: 0, alpha: 0.55)
    
    /**
     - Preferred Status Bar Style
     - Default: .default
     */
    public var preferredStatusBarStyle: UIStatusBarStyle = .default
    
    /**
     - Preferred Status bar hidden
     - Default: false
     */
    public var prefersStatusBarHidden: Bool = false
    
    /**
     - Progress HUD FadeIn animation duration on start
     - Default: 0.2 Sec
     */
    public var fadeInAnimationDuration: TimeInterval = 0.2
    
    /**
     - Progress HUD FadeOut animation duration on start
     - Default: 0.25 Sec
     */
    public var fadeOutAnimationDuration: TimeInterval = 0.25
    
    /**
     - Progress HUD Y offset to adjust view's vertical position
     - Default: 15
     */
    public var hudYOffset: CGFloat = 15
    
    /**
     - Progress HUD type
     - Default: .radial
     */
    public var hudType: HudType = .radial
    
    /**
     - Rotating circle radius(minimum should be HUD width/2)
     - Default: 40.0
     */
    public var circleRadius: CGFloat = 40.0
    
    /**
     - Rotating circle border width
     - Default: 1.0
     */
    public var circleBorderWidth: CGFloat = 1.0
    
    /**
     - Rotating circle border color
     - Default: UIColor.darkGray
     */
    public var circleBorderColor: UIColor = .darkGray
    
    /**
     - Rotating circle rotation animation duration
     - Default: 0.9 second
     */
    public var circleAnimationDuration: TimeInterval = 0.9
    
    /**
     - Rotating circle arc percentage
     - Default: 0.85
     */
    public var circleArcPercentage: CGFloat = 0.85
    
    /**
     - Logo image icon inside the rotating circle
     */
    public var logoImage: UIImage?  = nil
    
    /**
     - Logo image size inside the rotating circle
     - Default: CGSize(width: 40, height: 40)
     */
    public var logoImageSize: CGSize = CGSize(width: 40, height: 40)
}
