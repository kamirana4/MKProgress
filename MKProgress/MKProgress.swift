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
    
    /**
     - Flag to indicate if dismiss animation is being played to dismiss the ProgressHUD
     */
    fileprivate var isDismissing = false
    
    /**
     - Flag to indicate if Progress is waiting for the timeInterval given before showing up
     */
    fileprivate var isWaitingToShow = false
    
    /**
     - Returns 'UIWindow'.
     - 'MKProgressViewController' initialised and set as rootViewController for the window.
     */
    
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
    
    /**
     - Returns if there is already visible progress hud.
     - Initialises new window.
     - Show's the progress hud.
     */
    public static func show(_ animated: Bool = true) {
        if shared.isDismissing {
            shared.isDismissing = false
            makeKeyWindowVisible(animated)
            return
        }

        guard shared.hudWindow == nil else { return }
        makeKeyWindowVisible(animated)
    }
    
    fileprivate static func makeKeyWindowVisible(_ animated: Bool) {
        shared.hudWindow = shared.getHUDWindow()
        shared.hudWindow?.makeKeyAndVisible()
        
        guard animated else { return }
        shared.playFadeInAnimation()
    }
    
    /**
     - Shows progress hud after the given time interval
     - parameter wait: Wait interval before showing the progress hud. Default: 0.2 sec
     - parameter animated: Flag to handle the fadeIn animation on presenting. Default: true
     */
    public static func show(after wait: TimeInterval = 0.2, animated: Bool = true) {
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
        })
    }
    
    private func playFadeOutAnimation(_ completion: ((Bool) -> Void)?) {
        guard let rootViewController = self.hudWindow?.rootViewController else { return }
        
        MKProgress.shared.isDismissing = true
        
        rootViewController.view.layer.opacity = 1.0
        
        UIView.animate(withDuration: MKProgress.config.fadeOutAnimationDuration, animations: {
            guard MKProgress.shared.isDismissing else { return }
            rootViewController.view.layer.opacity = 0.0
        }, completion: completion)
    }
    
    /**
     - Hides the progress hud
     - parameter animated: Flag to handle the fadeOut animation on dismiss. Default: true
     */
    public static func hide(_ animated: Bool = true) {
        
        func hideProgressHud() {
            MKProgress.shared.isDismissing = false
            
            MKProgress.shared.stopAnimatoins()
            MKProgress.shared.hudWindow?.resignKey()
            MKProgress.shared.hudWindow = nil
        }
        
        MKProgress.shared.isWaitingToShow = false
        
        if animated {
            MKProgress.shared.playFadeOutAnimation({ _ in
                guard MKProgress.shared.isDismissing else { return }
                hideProgressHud()
            })
        } else {
            hideProgressHud()
        }
    }
}
