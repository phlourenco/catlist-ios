//
//  InfinityLoadingCell.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import UIKit

class InfinityLoadingCell: UICollectionViewCell {
    
    // MARK: - Public properties
    
    static public let cellIdentifier = "InfinityLoadingCell"
    
    // MARK: - Private properties
    
    private let titleLabel = UILabel()
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        titleLabel.text = "Loading..."
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .red
        contentView.addSubview(titleLabel)
    }
    
    private func layoutUI() {
        UIView.addConstraints([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
