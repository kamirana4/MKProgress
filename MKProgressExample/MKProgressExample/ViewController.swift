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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MKProgress.config.hudType = .radial
        MKProgress.config.circleBorderColor = .red
        MKProgress.config.logoImage = #imageLiteral(resourceName: "Swift_logo")
    }
    
    @IBAction func show(_ sender: UIButton) {
        MKProgress.show()
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            MKProgress.hide()
        }
        
    }
}

