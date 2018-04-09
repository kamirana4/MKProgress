//
//  MKProgressViewController.swift
//  MKProgress
//
//  Created by Muhammad Kamran on 3/29/17.
//  Copyright © 2017 Muhammad Kamran. All rights reserved.
//

import UIKit

class MKProgressViewController: UIViewController {

    var background: MKProgressBackgroundView = {
        let bg = MKProgressBackgroundView()
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    var indicator: MKActivityIndicatorView = {
        let indicator = MKActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    var rotationView: MKRotationView = {
        let rotationView = MKRotationView()
        rotationView.translatesAutoresizingMaskIntoConstraints = false
        return rotationView
    }()
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(background)
        
        
        let x = background.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let y = background.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let w = background.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0)
        let h = background.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0)
        
        NSLayoutConstraint.activate([x, y, w, h])
        
        self.addProgressHudView()
    }
    
    private func addProgressHudView() {
        switch MKProgress.config.hudType {
        case .activityIndicator:
            background.addSubview(indicator)
            self.setupConstraint(indicator)
        case .radial:
            background.addSubview(rotationView)
            self.setupConstraint(rotationView)
        }
    }
    
    private func setupConstraint(_ view: MKProgressBaseView) {
        let config = MKProgress.config
        
        let x = view.centerXAnchor.constraint(equalTo: background.centerXAnchor)
        let y = view.centerYAnchor.constraint(equalTo: background.centerYAnchor, constant: -config.hudYOffset)
        let w = view.widthAnchor.constraint(equalToConstant: config.width)
        let h = view.heightAnchor.constraint(equalToConstant: config.height)
        
        NSLayoutConstraint.activate([x, y, w, h])
    }
    
    public func stopAnimations() {
        switch MKProgress.config.hudType {
        case .activityIndicator:
            self.indicator.stopAnimation()
        case .radial:
            self.rotationView.stopAnimation()
        }
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
        return MKProgress.config.preferredStatusBarStyle
    }
    
    internal override var prefersStatusBarHidden: Bool {
        return MKProgress.config.prefersStatusBarHidden
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
