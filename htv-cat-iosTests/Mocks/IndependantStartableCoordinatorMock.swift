//
//  IndependantStartableCoordinatorMock.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 4/9/23.
//

import UIKit
@testable import htv_cat_ios

class IndependantStartableCoordinatorMock: IndependantStartableCoordinator {
    var navigationController: UINavigationController!
    var startCount = 0
    
    func start(with navigationController: UINavigationController) {
        startCount += 1
        self.navigationController = navigationController
    }
}
