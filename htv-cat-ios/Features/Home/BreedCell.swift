//
//  BreedCell.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 1/9/23.
//

import UIKit

class BreedCell: UICollectionViewCell {
    
    // MARK: - Public properties
    
    static public let cellIdentifier = "BreedCell"
    
    // MARK: - Private properties
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
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
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .darkGray
        
        let bgView = UIView()
        bgView.layer.cornerRadius = 5
        bgView.backgroundColor = UIColor(named: "PrimaryColor")
        
        let vStack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        vStack.axis = .vertical
        vStack.spacing = 10
        
        contentView.addSubview(bgView)
        bgView.addSubview(vStack)
        
        UIView.addConstraints([
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        UIView.addConstraints([
            vStack.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 10),
            vStack.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -10),
            vStack.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 10),
            vStack.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -10)
        ])
    }
    
    private func layoutUI() {
        
    }
}

extension BreedCell: ConfigurableCell {
    func configure(viewModel: CellViewModel, delegate: Any?) {
        guard let viewModel = viewModel as? BreedCellViewModel else { return }
        
        let breed = viewModel.breed
        
        let countryEmoji = breed.countryCode.toCountryFlagEmoji() ?? ""
        titleLabel.text = breed.name.appending(" \(countryEmoji)")
        descriptionLabel.text = breed.description
    }
}
