//
//  DetailHorizontalCell.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import UIKit

final class DetailHorizontalCell: UICollectionViewCell {
    
    // MARK: - Public properties
    
    static public let cellIdentifier = "DetailHorizontalCell"
    
    // MARK: - Private properties
    
    private let scrollView = UIScrollView()
    private let vStack = UIStackView()
    
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
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        vStack.spacing = 5
        
        contentView.addSubview(scrollView)
        scrollView.addSubview(vStack)
    }
    
    private func layoutUI() {
        UIView.addConstraints([
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            scrollView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        UIView.addConstraints([
            vStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            vStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            vStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            vStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0)
        ])
    }
    
    private func makeDetailView(value: String, description: String, color: UIColor? = UIColor(named: "PrimaryColor")) -> UIView {
        let view = UIView()
        
        view.backgroundColor = color
        view.layer.cornerRadius = 8
        
        UIView.addConstraints([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 70),
            view.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        let valueLabel = UILabel()
        valueLabel.font = .boldSystemFont(ofSize: 30)
        valueLabel.textColor = .darkGray
        valueLabel.text = value
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.textAlignment = .center
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.textColor = .gray
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.numberOfLines = 2
        
        let vStack = UIStackView(arrangedSubviews: [valueLabel, descriptionLabel])
        vStack.axis = .vertical
        vStack.alignment = .center
        vStack.distribution = .fill
        
        view.addSubview(vStack)
        
        UIView.addConstraints([
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            vStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 2),
            vStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -2)
        ])
        
        return view
    }
}

extension DetailHorizontalCell: ConfigurableCell {
    func configure(viewModel: CellViewModel, delegate: Any?) {
        guard let viewModel = viewModel as? DetailHorizontalCellViewModel else { return }
        
        vStack.removeAllSubviews()
        
        for detail in viewModel.details {
            vStack.addArrangedSubview(makeDetailView(value: detail.value, description: detail.title))
        }
    }
}
