//
//  MKProgress.swift
//  MKProgress
//
//  Created by Muhammad Kamran on 4/2/17.
//  Copyright © 2017 Muhammad Kamran. All rights reserved.
//

import UIKit

public enum HudType: Int {
    case activityIndicator
    case radial
}

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
    public var activityIndicatorStyle: UIActivityIndicatorViewStyle = .white
    
    
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
     */
    public var fadeInAnimationDuration: TimeInterval = 0.15
    
    /**
     - Progress HUD FadeOut animation duration on start
     */
    public var fadeOutAnimationDuration: TimeInterval = 0.15
    
    /**
     - Progress HUD type
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
     - Default: 0.9 second
     */
    public var logoImage: UIImage?  = nil
    
    /**
     - Logo image size inside the rotating circle
     - Default: CGSize(width: 40, height: 40)
     */
    public var logoImageSize: CGSize = CGSize(width: 40, height: 40)
}

public final class MKProgress {
    
    /**
     - HUD Window added  on top of current window.
     - Default: nil
     */
    fileprivate var hudWindow: UIWindow? = nil
    
    
    /**
     - Shared Instance
     */
    public static var shared = MKProgress()
    
    
    /**
     - Shared Config for the Progress HUD
     */
    public static var config = MKConfig()
    
    
    /**
     - Returns 'UIWindow'.
     - 'MKProgressViewController' initialised and set as rootViewController for the window.
     */
    
    fileprivate func getHUDWindow() -> UIWindow {
        let hudWindow = UIWindow()
        hudWindow.frame = UIScreen.main.bounds
        hudWindow.isHidden = false
        hudWindow.windowLevel = UIWindowLevelNormal
        hudWindow.backgroundColor = UIColor.clear
        let controller = MKProgressViewController()
        hudWindow.rootViewController = controller
        return hudWindow
    }
    
    fileprivate func stopAnimatoins() {
        guard let rootViewController = self.hudWindow?.rootViewController else { return }
        (rootViewController as? MKProgressViewController)?.stopAnimations()
    }
}

extension MKProgress {
    
    /**
     - Returns if there is already progress hud.
     - Initialises new window.
     - Show's the progress hud.
     */
    public static func show(_ animated: Bool = true) {
        guard shared.hudWindow == nil else { return }
        
        shared.hudWindow = shared.getHUDWindow()
        shared.hudWindow?.makeKeyAndVisible()
        
        guard animated else { return }
        shared.playFadeInAnimation()
    }
    
    private func playFadeInAnimation() {
        guard let rootViewController = self.hudWindow?.rootViewController else { return }
        
        rootViewController.view.layer.opacity = 0.0
        
        UIView.animate(withDuration: MKProgress.config.fadeInAnimationDuration, animations: {
            rootViewController.view.layer.opacity = 1.0
        })
    }
    
    private func playFadeOutAnimation(_ completion: ((Bool) -> Void)?) {
        guard let rootViewController = self.hudWindow?.rootViewController else { return }
        
        rootViewController.view.layer.opacity = 1.0
        
        UIView.animate(withDuration: MKProgress.config.fadeOutAnimationDuration, animations: {
            rootViewController.view.layer.opacity = 0.0
        }, completion: completion)
    }
    
    /**
     - Hides the progress hud by resigning hud window.
     - Resets hud window.
     */
    public static func hide(_ animated: Bool = true) {
        func hideProgressHud() {
            MKProgress.shared.stopAnimatoins()
            MKProgress.shared.hudWindow?.resignKey()
            MKProgress.shared.hudWindow = nil
        }
        
        if animated {
            MKProgress.shared.playFadeOutAnimation({ _ in
                hideProgressHud()
            })
        } else {
            hideProgressHud()
        }
    }
}
