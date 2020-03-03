//
//  ViewController.swift
//  MKProgressExample
//
//  Created by Muhammad Kamran on 4/2/17.
//  Copyright © 2017 Muhammad Kamran. All rights reserved.
//

import UIKit
import MKProgress

class ViewController: UIViewController {
    
    /// MARK: - View's Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        MKProgress.config.hudType = .radial
        MKProgress.config.circleBorderColor = .red
        MKProgress.config.logoImage = #imageLiteral(resourceName: "Swift_logo")
    }
    
    /// MARK: - User Interactions
    @IBAction func show(_ sender: UIButton) {
        MKProgress.show()
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (timer) in
            MKProgress.hide()
        }
    }
}

