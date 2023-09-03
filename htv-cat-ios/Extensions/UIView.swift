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
    
    static func fromNib<T>(withOwner: Any? = nil, options: [UINib.OptionsKey: Any]? = nil) -> T? where T: UIView {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "\(self)", bundle: bundle)
        return nib.instantiate(withOwner: withOwner, options: options).first as? T
    }
}
