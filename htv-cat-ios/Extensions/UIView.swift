//
//  UIView.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 1/9/23.
//

import UIKit

extension UIView {
    static func addConstraints(_ constraints: [NSLayoutConstraint]) {
        let views = constraints.compactMap { $0.firstItem as? UIView }
        let uniqueViews = Set(views)
        uniqueViews.forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate(constraints)
    }
}
