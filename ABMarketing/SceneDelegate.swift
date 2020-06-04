//
//  SceneDelegate.swift
//  ABMarketing
//
//  Created by Dominic Bryan on 04/06/2020.
//  Copyright © 2020 Neos Ventures Ltd. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {

            let window = UIWindow(windowScene: windowScene)
            
            /// Comment out TableViewController to see pop-up. Comment out ViewController to see cell
            let viewController = TableViewController()
//            let viewController = ViewController()

            let navigation = UINavigationController(rootViewController: viewController)
            window.rootViewController = navigation

            self.window = window
            window.makeKeyAndVisible()
        }
    }

}

