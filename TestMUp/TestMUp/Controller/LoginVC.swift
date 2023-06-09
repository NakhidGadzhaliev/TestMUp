//
//  LoginVC.swift
//  TestMUp
//
//  Created by Нахид Гаджалиев on 27.04.2023.
//

import UIKit
import SnapKit

final class LoginVC: UIViewController {
    
    // MARK: - PRIVATE PROPERTIES
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Mobile Up \nGallery"
        label.font = .systemFont(ofSize: 44, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in with VK".localized(), for: .normal)
        button.setTitleColor(Constants.Colors.customWhite, for: .normal)
        button.backgroundColor = Constants.Colors.customBlack
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewUpdate()
    }
    
}




// MARK: - ADDING METHODS
extension LoginVC {
    
    private func viewUpdate() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(loginButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(view.frame.height * 0.2)
            make.trailing.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(24)
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
    }
    
    private func authErrorAlert() {
        let title = "Error".localized()
        let message = "Some error during authorization".localized()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true)
    }
    
}




// MARK: - ADDING ACTIONS
extension LoginVC {
    @objc private func loginButtonTapped() {
        let authVC = AuthorizationVC()
        
        authVC.authorizationCompletion = { [weak self] success in
            switch success {
            case true:
                let galleryVC = GalleryVC()
                let navVC = UINavigationController(rootViewController: galleryVC)
                navVC.modalPresentationStyle = .fullScreen
                self?.present(navVC, animated: true)
            case false:
                self?.authErrorAlert()
            }
        }
        
        present(authVC, animated: true)
    }
}
