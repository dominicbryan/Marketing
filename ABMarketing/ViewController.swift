//
//  ViewController.swift
//  ABMarketing
//
//  Created by Dominic Bryan on 04/06/2020.
//  Copyright © 2020 Neos Ventures Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var smartMotionViewController = SmartMotionMarketingViewController(delegate: self, variant: .B)
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /// Checking to see if we have seen the pop-up before 
        if !defaults.bool(forKey: SmartMotionMarketingViewController.smartMotionMarketingKey) {
            navigationController?.present(smartMotionViewController, animated: true) { [weak self] in
                self?.defaults.set(true, forKey: SmartMotionMarketingViewController.smartMotionMarketingKey)
            }
        }
    }
    
}

extension ViewController: SmartKitMarketingDelegate {
    
    func smartMotionKitBuyPressed() {
        print("Smart motion")
    }
    
    func smartSenseKitBuyPressed() {
        print("smart sense")
    }
    
    func findOutMorePressed() {
        print("Find out more")
    }
}

