//
//  BreedCoordinator.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import UIKit

protocol BreedCoordinatorDelegate: AnyObject {
    func showDetail(breed: BreedModel)
}

final class BreedCoordinator: Coordinator, BreedCoordinatorDelegate {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeController = HomeViewController()
        homeController.delegate = self
        navigationController.viewControllers = [homeController]
    }
    
    func showDetail(breed: BreedModel) {
        let viewModel = DetailViewModel(breed: breed)
        let detailController = DetailViewController(viewModel: viewModel)
        navigationController.pushViewController(detailController, animated: true)
    }
}
