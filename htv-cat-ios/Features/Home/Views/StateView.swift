//
//  StateView.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 3/9/23.
//

import UIKit

final class StateView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    static func instantiate(image: UIImage?, text: String) -> StateView {
        guard let view: StateView = fromNib(withOwner: self, options: nil) else {
            fatalError("StateView instantiate error")
        }
        view.configure(image: image, text: text)
        return view
    }
    
    func configure(image: UIImage?, text: String) {
        imageView.image = image
        label.text = text
    }
}
