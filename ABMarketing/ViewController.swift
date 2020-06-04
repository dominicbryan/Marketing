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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.present(smartMotionViewController, animated: true, completion: nil)
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

