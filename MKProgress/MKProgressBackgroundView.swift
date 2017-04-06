//
//  MKProgressBackground.swift
//  MKProgress
//
//  Created by Muhammad Kamran on 3/29/17.
//  Copyright © 2017 Muhammad Kamran. All rights reserved.
//

import UIKit

class MKProgressBackgroundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        backgroundColor = MKProgress.config.backgroundColor
    }
}
