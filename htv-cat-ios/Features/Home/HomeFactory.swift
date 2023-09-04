//
//  HomeFactory.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 4/9/23.
//

import UIKit

class HomeFactory: ViewControllerFactory {
    func make(parameters: [Any], coordinatorDelegate: CoordinatorDelegate?) throws -> UIViewController {
        let homeController = HomeViewController()
        homeController.delegate = coordinatorDelegate
        return homeController
    }
}
