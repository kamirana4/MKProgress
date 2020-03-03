//
//  MKProgress.swift
//  MKProgress
//
//  Created by Muhammad Kamran on 4/2/17.
//  Copyright © 2017 Muhammad Kamran. All rights reserved.
//

import UIKit

public enum HudType: Int {
    
    /// Basic progress HUD with animated activity indicator
    case activityIndicator
    /// Circular animated progress HUD
    case radial
}

public final class MKProgress {
    
    /// HUD Window added on top of current window.
    /// - Default: nil
    fileprivate var hudWindow: UIWindow? = nil
    
    /// - `MKProgress` shared instance
    public static var shared = MKProgress()
    
    /// - `MKConfig` shared instance for the Progress HUD
    public static var config = MKConfig()
    
    /// Flag to indicate if dismiss animation is being played to dismiss the ProgressHUD
    fileprivate var isDismissing = false
    
    /// Flag to indicate if Progress is waiting for the timeInterval given before showing up
    fileprivate var isWaitingToShow = false
    
    /// Creating `UIWindow` to present Progress HUD
    /// 'MKProgressViewController' initialization and settting as rootViewController for the window.
    /// Returns 'UIWindow'.
    fileprivate func getHUDWindow() -> UIWindow {
        let hudWindow = UIWindow()
        hudWindow.frame = UIScreen.main.bounds
        hudWindow.isHidden = false
        hudWindow.windowLevel = UIWindow.Level.normal
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
    
    /// Showing Progress HUD
    /// - parameter animated: Flag to indicate if progress hud should appear with animation.
    /// - animated: Default: true
    public static func show(_ animated: Bool = true) {
        if shared.isDismissing {
            shared.isDismissing = false
            makeKeyWindowVisible(animated)
            return
        }

        guard shared.hudWindow == nil else { return }
        makeKeyWindowVisible(animated)
    }
    
    /// Presenting Progress window
    /// - parameter animated: Flag to indicate if progress hud should appear with animation.
    /// - animated: Default: true
    fileprivate static func makeKeyWindowVisible(_ animated: Bool) {
        shared.hudWindow = shared.getHUDWindow()
        shared.hudWindow?.makeKeyAndVisible()
        
        guard animated else { return }
        shared.playFadeInAnimation()
    }
    
    /// Shows progress hud after the given time interval
    /// - parameter wait: Wait interval before showing the progress hud.
    /// - wait: Default: 0.2 sec
    /// - parameter animated: Flag to handle the fadeIn animation on presenting.
    /// - animated: Default: true
    public static func show(after wait: TimeInterval = 0.2, animated: Bool = true) {
        shared.isWaitingToShow = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + wait) {[weak shared] in
            guard shared?.isWaitingToShow == true else { return }
            MKProgress.show(animated)
        }
    }
    
    /// Plays fade in animation
    private func playFadeInAnimation() {
        guard let rootViewController = self.hudWindow?.rootViewController else { return }
        
        rootViewController.view.layer.opacity = 0.0
        
        UIView.animate(withDuration: MKProgress.config.fadeInAnimationDuration, animations: {
            rootViewController.view.layer.opacity = 1.0
        })
    }
    
    /// Plays fade out animation
    private func playFadeOutAnimation(_ completion: ((Bool) -> Void)?) {
        guard let rootViewController = self.hudWindow?.rootViewController else { return }
        
        MKProgress.shared.isDismissing = true
        
        rootViewController.view.layer.opacity = 1.0
        
        UIView.animate(withDuration: MKProgress.config.fadeOutAnimationDuration, animations: {
            guard MKProgress.shared.isDismissing else { return }
            rootViewController.view.layer.opacity = 0.0
        }, completion: completion)
    }
    
    /// Hiding the progress hud
    /// - parameter animated: Flag to handle the fadeOut animation on dismiss.
    /// - animated: Default: true
    public static func hide(_ animated: Bool = true) {
        let progress = MKProgress.shared
        func hideProgressHud() {
            progress.isDismissing = false
            
            progress.stopAnimatoins()
            progress.hudWindow?.resignKey()
            progress.hudWindow = nil
        }
        
        MKProgress.shared.isWaitingToShow = false
        
        if animated {
            progress.playFadeOutAnimation({ _ in
                guard MKProgress.shared.isDismissing else { return }
                hideProgressHud()
            })
        } else {
            hideProgressHud()
        }
    }
}
