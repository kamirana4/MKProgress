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
        
        MKProgress.show()
        
        let timeInterval = TimeInterval.init(3.0)
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { (timer) in
            MKProgress.hide()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

