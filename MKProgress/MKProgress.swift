//
//  MKProgress.swift
//  MKProgress
//
//  Created by Muhammad Kamran on 4/2/17.
//  Copyright © 2017 Muhammad Kamran. All rights reserved.
//

import UIKit

public struct MKConfig {
    
    /**
     @ Progress HUD background view's 'Width'.
     @ Try to provide the equal 'Width' and 'Height'.
     @ Default: 64.0
     */
    public var width: CGFloat = 64.0
    
    
    /**
     @ Progress HUD background view's 'Height'.
     @ Try to provide the equal 'Width' and 'Height'.
     @ Default: 64.0
     */
    public var height: CGFloat = 64.0
    

    /**
     @ Progress HUD activity indicator style
     @ Default: .whiteLarge
     */
    public var activityIndicatorStyle: UIActivityIndicatorViewStyle = .white
    
    
    /**
     @ Progress HUD activity indicator color
     @ Default: .black
     */
    public var activityIndicatorColor: UIColor = .black
    
    
    /**
     @ Progress HUD background's Color
     @ Default: .white
     */
    public var hudColor: UIColor = .white
    
    
    /**
     @ Progress HUD corner radius
     @ Default: 16.0
     */
    public var cornerRadius: CGFloat = 16.0
    
    
    /**
     @ Overlay color
     @ Default: 'UIColor.init(white: 0, alpha: 0.55)'
     */
    public var backgroundColor: UIColor = UIColor.init(white: 0, alpha: 0.55)
    
    
    /**
     @ Preferred Status Bar Styple
     @ Default: .default
     */
    public var preferredStatusBarStyle: UIStatusBarStyle = .default
    
    
    /**
     @ Preferred Status bar hidden
     @ Default: false
     */
    public var prefersStatusBarHidden: Bool = false
}

public final class MKProgress {
    
    /**
     @ HUD Window added  on top of current window.
     @ Default: nil
     */
    fileprivate var hudWindow: UIWindow? = nil
    
    
    /**
     @ Shared Instance
     */
    public static var shared = MKProgress()
    
    
    /**
     @ Shared Config for the Progress HUD
     */
    public static var config = MKConfig()
    
    
    /**
     @ Returns 'UIWindow'.
     @ 'MKProgressViewController' initialised and set as rootViewController for the window.
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
}

extension MKProgress {
    
    /**
     @ Returns if there is already progress hud.
     @ Initialises new window.
     @ Show's the progress hud.
     */
    public static func show() {
        guard shared.hudWindow == nil else { return }
        
        shared.hudWindow = shared.getHUDWindow()
        shared.hudWindow?.makeKeyAndVisible()
    }
    
    /**
     @ Hides the progress hud by resigning hud window.
     @ Resets hud window.
     */
    public static func hide() {
        shared.hudWindow?.resignKey()
        shared.hudWindow = nil
    }
}
