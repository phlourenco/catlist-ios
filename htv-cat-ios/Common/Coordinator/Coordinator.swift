//
//  Coordinator.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 1/9/23.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController! { get set }
}

protocol StartableCoordinator: Coordinator {
    func start()
}

protocol IndependantStartableCoordinator: Coordinator {
    func start(with navigationController: UINavigationController)
}

protocol CoordinatorDelegate: AnyObject { }

protocol ViewControllerFactory {
    func make(parameters: [Any], coordinatorDelegate: CoordinatorDelegate?) throws -> UIViewController
}
