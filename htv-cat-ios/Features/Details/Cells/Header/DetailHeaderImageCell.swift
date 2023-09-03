//
//  DetailHeaderImageCell.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import UIKit
import Combine
import Kingfisher

protocol DetailHeaderImageCellDelegate: AnyObject {
    func back()
}

final class DetailHeaderImageCell: UICollectionViewCell {
    
    // MARK: - Public properties
    
    static public let cellIdentifier = "DetailHeaderImageCell"
    weak var delegate: DetailHeaderImageCellDelegate?
    
    // MARK: - Private properties
    
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    private let gradientView = GradientView(colors: [.clear, .white.withAlphaComponent(0.5), .white])
    private let gradientLayer = CAGradientLayer()
    private let loadingView = UIActivityIndicatorView(style: .medium)
    private let backButton = UIButton(type: .system)
    
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
        imageView.backgroundColor = .gray
        imageView.tintColor = .darkGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        imageView.addSubview(gradientView)
        imageView.addSubview(backButton)
        imageView.addSubview(loadingView)
        
        backButton.tintColor = .black
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    private func layoutUI() {
        UIView.addConstraints([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        UIView.addConstraints([
            gradientView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        UIView.addConstraints([
            backButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            backButton.topAnchor.constraint(equalTo: imageView.topAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        UIView.addConstraints([
            loadingView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
    
    @objc
    private func back() {
        delegate?.back()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var view = backButton.hitTest(backButton.convert(point, from: self), with: event)
        if view == nil {
            view = super.hitTest(point, with: event)
        }

        return view
    }
}

extension DetailHeaderImageCell: ConfigurableCell {
    func configure(viewModel: CellViewModel, delegate: Any?) {
        self.delegate = (delegate as? DetailHeaderImageCellDelegate)
        guard let viewModel = viewModel as? DetailHeaderImageCellViewModel else { return }
        
        if let img = viewModel.breedImage {
            imageView.kf.setImage(with: img.url) { [weak self] result in
                self?.loadingView.isHidden = true
                self?.loadingView.stopAnimating()
                
                switch result {
                case .failure(_):
                    self?.imageView.image = UIImage(systemName: "photo")
                default:
                    break
                }
            }
        } else {
            loadingView.isHidden = false
            loadingView.startAnimating()
            imageView.image = nil
        }
    }
}
