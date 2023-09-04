//
//  BreedCoordinator.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import UIKit

protocol BreedCoordinatorDelegate: CoordinatorDelegate {
    func showDetail(breed: BreedModel)
}

final class BreedCoordinator: IndependantStartableCoordinator, BreedCoordinatorDelegate {
    var navigationController: UINavigationController!
    private let homeFactory: ViewControllerFactory
    private let detailFactory: ViewControllerFactory
    
    init(
        homeFactory: ViewControllerFactory = HomeFactory(),
        detailFactory: ViewControllerFactory = DetailFactory()
    ) {
        self.homeFactory = homeFactory
        self.detailFactory = detailFactory
    }
    
    func start(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        if let homeController = try? homeFactory.make(parameters: [], coordinatorDelegate: self) {
            navigationController.viewControllers = [homeController]
        }
    }
    
    func showDetail(breed: BreedModel) {
        if let detailController = try? detailFactory.make(parameters: [breed], coordinatorDelegate: nil) {
            navigationController.pushViewController(detailController, animated: true)
        }
    }
}
