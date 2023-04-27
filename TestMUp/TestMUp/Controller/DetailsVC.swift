//
//  DetailsVC.swift
//  TestMUp
//
//  Created by Нахид Гаджалиев on 27.04.2023.
//

import UIKit
import SnapKit

class DetailsVC: UIViewController {
    
    // MARK: - PRIVATE PROPERTIES
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true

        return image
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let size = (view.frame.width / 7) - 1
        layout.itemSize = CGSize(width: size, height: size)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GalleryCollectionViewCell.self,
                                forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier) // создать кастомную ячейку
        
        return collectionView
    }()
    
    private var image: String? // здесь будет изображение
    private var otherImages: [String] = [String]() // остальные изображения
    private lazy var size = view.frame.width
    
    // MARK: - Initialization
    init(generalImage: String, otherImages: [String]) {
        super.init(nibName: nil, bundle: nil)
        self.image = generalImage
        self.otherImages = otherImages
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}




// MARK: - ADDING PRIVATE METHODS
extension DetailsVC {
    
    private func getDate() -> String {
        // Добавить сюда логику получения даты с изображения
        return "01"
    }
    
    private func viewUpdate() {
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(collectionView)
        navBarConfiguration()
        setupConstraints()
        // imageView.image = добавить логику получения изображения
    }
    
    private func setupConstraints() {
        imageView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: size,
                                 height: size)
        imageView.center = view.center
        
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(view.frame.width / 7)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
        }
    }
    
    private func navBarConfiguration() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self,
                                                            action: #selector(shareTapped))
        navigationController?.navigationItem.hidesBackButton = true //
        navigationController?.navigationBar.tintColor = Constants.Colors.customBlack //сделать кастомным
    }
    
}




// MARK: - ADDING ACTIONS
extension DetailsVC {
    
    @objc private func shareTapped() {
        // Добавить логику "поделиться"
    }
    
}




extension DetailsVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        otherImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier,
                                                            for: indexPath) as? GalleryCollectionViewCell else {
            return UICollectionViewCell()
        }
        let url = otherImages[indexPath.row]
        cell.configure(with: url) // добавить реальные юрл в массив
        return cell
    }
    
}


// MARK: - Оставшиеся задания
/*
 1. Добавить логику загрузки данных по изображениям
 2. Обработать ошибки
 3. Добавить логику приближения изображения
 4. Добавить логику "поделиться"
 */
