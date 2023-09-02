//
//  CellViewModel.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 1/9/23.
//

import UIKit

protocol CellViewModel {
    var height: CGFloat { get }
}

extension CellViewModel {
    var height: CGFloat {
        return UITableView.automaticDimension
    }
}
