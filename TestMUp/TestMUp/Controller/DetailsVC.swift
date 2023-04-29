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
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 2
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GalleryCollectionViewCell.self,
                                forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier) // создать кастомную ячейку
        
        return collectionView
    }()
    
    private var image: ImageModel? // здесь будет изображение
    private var otherImages: [ImageModel] = [ImageModel]() // остальные изображения
    private lazy var size = view.frame.width
    
    // MARK: - Initialization
    init(generalImage: ImageModel, otherImages: [ImageModel]) {
        super.init(nibName: nil, bundle: nil)
        self.image = generalImage
        self.otherImages = otherImages
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewUpdate()
        pinchToZoom()
        collectionView.dataSource = self
    }
}




// MARK: - ADDING PRIVATE METHODS
extension DetailsVC {
    
    private func getDate() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(image?.date ?? 0))
        return DateFormatter.titleDateFormatter.string(from: date)
    }
    
    private func viewUpdate() {
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(collectionView)
        navBarConfiguration()
        setupConstraints()
        imageView.kf.setImage(with: URL(string: image?.urlString ?? ""), placeholder: UIImage(systemName: "photo"))
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
        title = getDate()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self,
                                                            action: #selector(shareTapped))
        navigationController?.navigationItem.hidesBackButton = true //
        navigationController?.navigationBar.tintColor = Constants.Colors.customBlack //сделать кастомным
    }
    
    private func pinchToZoom() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch))
        imageView.addGestureRecognizer(pinchGesture)
    }
    
}




// MARK: - ADDING ACTIONS
extension DetailsVC {
    
    @objc private func didPinch(_ gesture: UIPinchGestureRecognizer) {
        if gesture.state == .changed {
            let scale = gesture.scale
            imageView.frame = CGRect(x: 0, y: 0, width: size  * scale, height: size * scale)
            imageView.center = view.center
        }
        if gesture.state == .ended {
            imageView.frame = CGRect(x: 0, y: 0, width: size, height: size)
            imageView.center = view.center
        }
    }
    
    @objc private func shareTapped() {
        guard let image = imageView.image else {
            let alert = UIAlertController(title: "Error".localized(),
                                          message: "Image not found".localized(),
                                          preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "OK", style: .default)
            alert.addAction(actionOK)
            self.present(alert, animated: true)
            return
        }
        
        let shareController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        shareController.completionWithItemsHandler = { _, bool, _, error in
            
            if bool {
                let alert = UIAlertController(title: "Saved".localized(),
                                              message: "Image successfully saved to gallery".localized(),
                                              preferredStyle: .alert)
                let actionOK = UIAlertAction(title: "OK", style: .default)
                alert.addAction(actionOK)
                self.present(alert, animated: true)
            }
            
            if error != nil {
                let alert = UIAlertController(title: "Error".localized(),
                                              message: "Some error during execution".localized(),
                                              preferredStyle: .alert)
                let actionOK = UIAlertAction(title: "OK", style: .default)
                alert.addAction(actionOK)
                self.present(alert, animated: true)
            }
        }
        
        present(shareController, animated: true)
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
        let url = otherImages[indexPath.row].urlString
        cell.configure(with: url)
        return cell
    }
    
}
