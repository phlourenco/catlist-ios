//
//  MainCoordinator.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 1/9/23.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var window: UIWindow?
    
    static var shared = MainCoordinator()
    
    var navigationController: UINavigationController
    
    private init() {
        navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.navigationBar.isHidden = true
    }
    
    func start() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        showHome()
    }
    
    private func showHome() {
        let homeController = HomeViewController()
        navigationController.viewControllers = [homeController]
    }
    
}

