//
//  ConfigurableView.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 1/9/23.
//

import UIKit

protocol ConfigurableCell {
    func configure(viewModel: CellViewModel, delegate: Any?)
}
