//
//  GalleryCollectionViewCell.swift
//  TestMUp
//
//  Created by Нахид Гаджалиев on 27.04.2023.
//

import UIKit
import Kingfisher
import SnapKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "GalleryCollectionViewCell"
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




// MARK: - ADDING PRIVATE METHODS
extension GalleryCollectionViewCell {
    
    func configure(with imageUrl: String) {
        let url = URL(string: imageUrl)
        let placeholderImage = UIImage(systemName: "photo")?.withRenderingMode(.alwaysOriginal)
        
        imageView.kf.setImage(with: url, placeholder: placeholderImage)
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.backgroundColor = .systemBackground
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
