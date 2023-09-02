//
//  BaseView.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import UIKit

protocol BaseView {
    func showAlert(title: String?, message: String?)
    func showAlert(title: String?, message: String?, tryAgainAction: (()->Void)?, completion: (() -> Void)?)
    func showScreenLoading()
    func hideScreenLoading()
}

extension BaseView where Self: UIViewController {
    func showAlert(title: String?, message: String?) {
        showAlert(title: title, message: message, tryAgainAction: nil, completion: nil)
    }
    
    func showAlert(title: String?, message: String?, tryAgainAction: (()->Void)?, completion: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let tryAgainAction = tryAgainAction {
            alertController.addAction(UIAlertAction(title: "Try again", style: .default, handler: { action in
                tryAgainAction()
            }))
        }
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: completion)
    }
    
    func showScreenLoading() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.white.withAlphaComponent(0)
        backgroundView.tag = 123
        view.addSubview(backgroundView)
        backgroundView.frame = view.bounds
        
        let middleView = UIView()
        middleView.backgroundColor = #colorLiteral(red: 0.9143998472, green: 0.9143998472, blue: 0.9143998472, alpha: 1)
        backgroundView.addSubview(middleView)
        middleView.translatesAutoresizingMaskIntoConstraints = false
        
        middleView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        middleView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        middleView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        middleView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        middleView.layer.cornerRadius = 5
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        middleView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.leadingAnchor.constraint(equalTo: middleView.leadingAnchor).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: middleView.trailingAnchor).isActive = true
        activityIndicator.topAnchor.constraint(equalTo: middleView.topAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: middleView.bottomAnchor).isActive = true
    }
    
    func hideScreenLoading() {
        view.viewWithTag(123)?.removeFromSuperview()
    }
    
}
