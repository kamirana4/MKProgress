//
//  MKActivityIndicatorView.swift
//  MKProgress
//
//  Created by Muhammad Kamran on 3/29/17.
//  Copyright © 2017 Muhammad Kamran. All rights reserved.
//

import UIKit

class MKActivityIndicatorView: MKProgressBase {

    let activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activity.color = UIColor.white
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
}
