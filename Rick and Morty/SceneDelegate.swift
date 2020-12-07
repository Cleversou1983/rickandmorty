//
//  SceneDelegate.swift
//  Rick and Morty
//
//  Created by Cleverson Luiz Correia de Souza on 04/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
     
        // Default window
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.windowScene = windowScene
        
        // Default controller
        let mainController = CharacterListController()
        
        // Navigation controller
        let navigationController = UINavigationController()
        navigationController.viewControllers = [mainController]
        
        // Set window properties
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }

}

