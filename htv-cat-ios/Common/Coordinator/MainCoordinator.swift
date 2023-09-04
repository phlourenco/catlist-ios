//
//  MainCoordinator.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 1/9/23.
//

import UIKit

final class MainCoordinator: StartableCoordinator {
    
    var window: UIWindow?
    
    static let shared: MainCoordinator = {
        MainCoordinator(breedCoordinator: BreedCoordinator())
    }()
    
    var navigationController: UINavigationController!
    private let breedCoordinator: IndependantStartableCoordinator
    
    init(breedCoordinator: IndependantStartableCoordinator) {
        self.breedCoordinator = breedCoordinator

        navigationController = UINavigationController()
        navigationController.view.backgroundColor = .white
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()

        navigationController.navigationBar.standardAppearance = navBarAppearance
        navigationController.navigationBar.compactAppearance = navBarAppearance
        navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController.interactivePopGestureRecognizer?.delegate = nil

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
        breedCoordinator.start(with: navigationController)
    }
}
