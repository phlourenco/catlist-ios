//
//  DetailFactory.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 4/9/23.
//

import UIKit

class DetailFactory: ViewControllerFactory {
    func make(parameters: [Any], coordinatorDelegate: CoordinatorDelegate?) throws -> UIViewController {
        guard !parameters.isEmpty, let breed = parameters[0] as? BreedModel else {
            throw AppError.unknownError
        }
                
        let viewModel = DetailViewModel(breed: breed)
        let detailController = DetailViewController(viewModel: viewModel)
        return detailController
    }
}
