//
//  SceneDelegate.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 09.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import UIKit
import LightningKitUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = SeedViewController(seed:
                ["GOAT", "GOAT", "GOAT", "GOAT", "GOAT", "GOAT", "GOAT", "GOAT", "GOAT", "GOAT", "GOAT", "GOAT", "GOAT", "GOAT", "GOAT", "GOAT", "GOAT", "GOAT", "GOAT", "GOAT", "GOAT", "GOAT", "GOAT", "GOAT"]
            )
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

