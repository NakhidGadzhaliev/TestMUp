//
//  GalleryVC.swift
//  TestMUp
//
//  Created by Нахид Гаджалиев on 27.04.2023.
//

import UIKit
import SnapKit

final class GalleryVC: UIViewController {
    
    // MARK: - PRIVATE PROPERTIES
    private lazy var galleryCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let size = (view.frame.width / 2) - 1
        layout.itemSize = CGSize(width: size, height: size)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GalleryCollectionViewCell.self,
                                forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    private let imagesArray: [String] = [String]() // данные с сервера
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewUpdate()
        fetchData()
    }
    
}




// MARK: - ADDING METHODS
extension GalleryVC {
    
    private func viewUpdate() {
        title = "Mobile Up Gallery"
        view.backgroundColor = .systemBackground
        view.addSubview(galleryCollectionView)
        navBarConfiguration()
        setupConstraints()
    }
    
    private func fetchData() {
        // Добавить логику сюда
    }
    
    private func collectionViewConfiguration() {
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
    }
    
    private func navBarConfiguration() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Выход",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(exitButtonTapped))
        navigationController?.navigationBar.tintColor = Constants.Colors.customBlack //сделать кастомным
    }
    
    private func setupConstraints() {
        galleryCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}




// MARK: - ADDING ACTIONS
extension GalleryVC {
    
    @objc private func exitButtonTapped() {
        self.dismiss(animated: true)
    }
    
}




extension GalleryVC: UICollectionViewDelegate {
    
}




extension GalleryVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier,
                                                            for: indexPath) as? GalleryCollectionViewCell else {
            return UICollectionViewCell()
        }
        let url = imagesArray[indexPath.row]
        cell.configure(with: url) // добавить реальные юрл в массив
        return cell
    }
    
}

// MARK: - Оставшиеся задания
/*
 1. Добавить логику загрузки данных
 2. Обработать ошибку
 3. Добавить логику выхода из аккаунта
 */
