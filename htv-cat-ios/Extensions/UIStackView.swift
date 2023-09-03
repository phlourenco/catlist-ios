//
//  UIStackView.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 3/9/23.
//

import UIKit

extension UIStackView {
    func removeAllSubviews() {
        arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
