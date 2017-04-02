//
//  MKProgressViewController.swift
//  MKProgress
//
//  Created by Muhammad Kamran on 3/29/17.
//  Copyright © 2017 Muhammad Kamran. All rights reserved.
//

import UIKit

class MKProgressViewController: UIViewController {

    var background: MKProgressBackground = {
        let bg = MKProgressBackground()
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    var indicator: MKActivityIndicatorView = {
        let indicator = MKActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(background)
        background.addSubview(indicator)
        
        var x = background.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        var y = background.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        var w = background.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0)
        var h = background.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0)
        
        NSLayoutConstraint.activate([x, y, w, h])
        
        x = indicator.centerXAnchor.constraint(equalTo: background.centerXAnchor)
        y = indicator.centerYAnchor.constraint(equalTo: background.centerYAnchor, constant: -30.0)
        w = indicator.widthAnchor.constraint(equalToConstant: 50.0)
        h = indicator.heightAnchor.constraint(equalToConstant: 50.0)
        
        NSLayoutConstraint.activate([x, y, w, h])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        super.loadViewIfNeeded()
    }
    
    internal override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let rootViewController = UIApplication.shared.delegate?.window??.rootViewController {
            return rootViewController.supportedInterfaceOrientations
        } else {
            return UIInterfaceOrientationMask.portrait
        }
    }
    
    internal override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.presentingViewController?.preferredStatusBarStyle ?? UIApplication.shared.statusBarStyle
    }
    
    internal override var prefersStatusBarHidden: Bool {
        return self.presentingViewController?.prefersStatusBarHidden ?? UIApplication.shared.isStatusBarHidden
    }
    
    internal override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        if let rootViewController = UIApplication.shared.delegate?.window??.rootViewController {
            return rootViewController.preferredStatusBarUpdateAnimation
        } else {
            return .none
        }
    }
    
    internal override var shouldAutorotate: Bool {
        if let rootViewController = UIApplication.shared.delegate?.window??.rootViewController {
            return rootViewController.shouldAutorotate
        } else {
            return false
        }
    }
}
