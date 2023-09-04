//
//  FactoryMock.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 4/9/23.
//

import Foundation
import UIKit
@testable import htv_cat_ios

class FactoryMock: ViewControllerFactory {
    var parameters: [Any] = []
    var coordinatorDelegate: CoordinatorDelegate? = nil
    var makeCount = 0
    var madeViewController: UIViewController? = nil
    
    func make(parameters: [Any], coordinatorDelegate: CoordinatorDelegate?) -> UIViewController {
        makeCount += 1
        self.parameters = parameters
        self.coordinatorDelegate = coordinatorDelegate
        let vc = UIViewController()
        madeViewController = vc
        return vc
    }
}
