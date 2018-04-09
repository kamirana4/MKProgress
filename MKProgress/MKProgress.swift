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
    
    fileprivate var isDismissing = false
    
    fileprivate var shouldShowAfterDismissing =  false
    
    fileprivate var isWaitingToShow = false
    
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
        if shared.isDismissing {
            shared.shouldShowAfterDismissing = true
            return
        }

        guard shared.hudWindow == nil else { return }
        
        shared.hudWindow = shared.getHUDWindow()
        shared.hudWindow?.makeKeyAndVisible()
        
        guard animated else { return }
        shared.playFadeInAnimation()
    }
    
    public static func show(after wait: TimeInterval = 0.5, animated: Bool = true) {
        shared.isWaitingToShow = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + wait) {[weak shared] in
            guard shared?.isWaitingToShow == true else { return }
            MKProgress.show(animated)
        }
    }
    
    private func playFadeInAnimation() {
        guard let rootViewController = self.hudWindow?.rootViewController else { return }
        
        rootViewController.view.layer.opacity = 0.0
        
        UIView.animate(withDuration: MKProgress.config.fadeInAnimationDuration, animations: {
            rootViewController.view.layer.opacity = 1.0
        }, completion: { _ in
            MKProgress.shared.shouldShowAfterDismissing = false
        })
    }
    
    private func playFadeOutAnimation(_ completion: ((Bool) -> Void)?) {
        guard let rootViewController = self.hudWindow?.rootViewController else { return }
        
        MKProgress.shared.isDismissing = true
        
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
            MKProgress.shared.shouldShowAfterDismissing = false
            MKProgress.shared.isDismissing = false
            
            MKProgress.shared.stopAnimatoins()
            MKProgress.shared.hudWindow?.resignKey()
            MKProgress.shared.hudWindow = nil
        }
        
        MKProgress.shared.isWaitingToShow = false
        
        if animated {
            MKProgress.shared.playFadeOutAnimation({ _ in
                if MKProgress.shared.shouldShowAfterDismissing {
                    MKProgress.shared.playFadeInAnimation()
                } else {
                    hideProgressHud()
                }
            })
        } else {
            hideProgressHud()
        }
    }
}
