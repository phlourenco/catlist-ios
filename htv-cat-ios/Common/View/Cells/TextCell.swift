//
//  TextCell.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import UIKit

class TextCell: UICollectionViewCell {
    
    // MARK: - Public properties
    
    static public let cellIdentifier = "TextCell"
    
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
        titleLabel.textColor = .darkGray
        contentView.addSubview(titleLabel)
    }
    
    private func layoutUI() {
        UIView.addConstraints([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}

extension TextCell: ConfigurableCell {
    func configure(viewModel: CellViewModel, delegate: Any?) {
        guard let viewModel = viewModel as? TextCellViewModel else { return }
        
        titleLabel.text = viewModel.text
        titleLabel.font = UIFont.systemFont(ofSize: CGFloat(viewModel.fontSize))
    }
}
