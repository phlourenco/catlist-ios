//
//  MainCoordinator.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 1/9/23.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    var window: UIWindow?
    
    static var shared = MainCoordinator()
    
    var navigationController: UINavigationController
    private var breedCoordinator: BreedCoordinator!
    
    private init() {
        navigationController = UINavigationController()
        navigationController.view.backgroundColor = .white
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.purple]
//        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.purple]
//        navBarAppearance.backgroundColor = UIColor.yellow

        navigationController.navigationBar.standardAppearance = navBarAppearance
        navigationController.navigationBar.compactAppearance = navBarAppearance
        navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance

        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.tintColor = UIColor.darkGray
    }
    
    func start() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        showHome()
    }
    
    private func showHome() {
        breedCoordinator = BreedCoordinator(navigationController: navigationController)
        breedCoordinator.start()
    }
    
}

