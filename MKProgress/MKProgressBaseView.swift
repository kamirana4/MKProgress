//
//  MKProgressBase.swift
//  MKProgress
//
//  Created by Muhammad Kamran on 3/29/17.
//  Copyright © 2017 Muhammad Kamran. All rights reserved.
//

import UIKit

protocol ProgressViewDataSource {
    func configureView()
}

protocol ProgressViewDataDelegate {
    func stopAnimation()
}

class MKProgressBaseView: UIView, ProgressViewDataSource, ProgressViewDataDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Fatal error occurred while setup!")
    }
    
    func configureView() {
        let config = MKProgress.config
        clipsToBounds = true
        layer.cornerRadius = config.cornerRadius
        backgroundColor = config.hudColor
    }
    
    func stopAnimation() {
        // Implement to provide functionality
    }
}
