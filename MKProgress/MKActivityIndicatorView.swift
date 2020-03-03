//
//  MKActivityIndicatorView.swift
//  MKProgress
//
//  Created by Muhammad Kamran on 3/29/17.
//  Copyright © 2017 Muhammad Kamran. All rights reserved.
//

import UIKit

class MKActivityIndicatorView: MKProgressBaseView {

    let activityIndicatorView: UIActivityIndicatorView = {
        let config = MKProgress.config
        let activity = UIActivityIndicatorView(style: config.activityIndicatorStyle)
        activity.color = config.activityIndicatorColor
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    override func configureView() {
        super.configureView()
        
        activityIndicatorView.startAnimating()
        addSubview(activityIndicatorView)
        
        let x = activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let y = activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        NSLayoutConstraint.activate([x, y])
    }
    
    override func stopAnimation() {
        self.activityIndicatorView.stopAnimating()
    }
}
