//
//  MKProgress.swift
//  MKProgress
//
//  Created by Muhammad Kamran on 4/2/17.
//  Copyright © 2017 Muhammad Kamran. All rights reserved.
//

import UIKit

public final class MKProgress {
    
    fileprivate var hudWindow: UIWindow? = nil
    public static var shared = MKProgress()
    
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
    
    public static func show() {
        if shared.hudWindow == nil {
            shared.hudWindow = shared.getHUDWindow()
        }
        shared.hudWindow?.makeKeyAndVisible()
    }
    
    public static func hide() {
        shared.hudWindow?.resignKey()
        shared.hudWindow = nil
    }
}
