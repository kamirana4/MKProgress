//
//  MKProgressBase.swift
//  MKProgress
//
//  Created by Muhammad Kamran on 3/29/17.
//  Copyright © 2017 Muhammad Kamran. All rights reserved.
//

import UIKit

class MKProgressBaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Fatal error occurred while setup!")
    }
    
    open func configureView() {
        let config = MKProgress.config
        clipsToBounds = true
        layer.cornerRadius = config.cornerRadius
        backgroundColor = config.hudColor
    }
}
