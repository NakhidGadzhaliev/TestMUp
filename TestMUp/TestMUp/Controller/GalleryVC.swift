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
    
    private var imagesArray: [ImageModel] = [ImageModel]() // данные с сервера
    
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
        APIManager.shared.getImages { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let images):
                    self?.imagesArray = images
                    self?.galleryCollectionView.reloadData()
                case .failure:
                    self?.showErrorAlert()
                }
            }
        }
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Failed to load images",
                                      message: nil,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Reload",
                                      style: .default,
                                      handler: { [weak self] (_) in
            self?.fetchData()
        }))
        
        present(alert, animated: true)
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
        let alert = UIAlertController(title: "Logout?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] _ in
            
            AuthManager.shared.logOut { success in
                if success {
                    DispatchQueue.main.async {
                        let loginVC = LoginVC()
                        loginVC.modalPresentationStyle = .fullScreen
                        self?.present(loginVC, animated: true)
                    }
                }
            }
        }))
        
        present(alert, animated: true)
    }
    
}




extension GalleryVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = imagesArray[indexPath.row]
        let otherImages = imagesArray.filter { $0.id != image.id }
//        let detailVC = DetailsVC(generalImage: image, otherImages: [otherImages])
//        navigationController?.pushViewController(detailVC, animated: true)
    }
    
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
        let url = imagesArray[indexPath.row].urlString
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
