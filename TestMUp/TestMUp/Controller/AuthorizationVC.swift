//
//  AuthorizationVC.swift
//  TestMUp
//
//  Created by Нахид Гаджалиев on 27.04.2023.
//

import UIKit
import WebKit
import SnapKit

final class AuthorizationVC: UIViewController {
    
    // MARK: - PROPERTIES
    var authorizationCompletion: ((Bool) -> Void)?
    
    //MARK: - PRIVATE PROPERTIES
    private let webView: WKWebView = WKWebView()
    private let connectErrorView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
}




// MARK: - ADDING PRIVATE METHODS
extension AuthorizationVC {
    
    private func viewUpdate() {
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(connectErrorView)
        setupConstraints()
        webViewUpdate()
    }
    
    private func webViewUpdate() {
        webView.navigationDelegate = self
    }
    
    private func setupConstraints() {
        connectErrorView.snp.makeConstraints { make in
            make.height.width.equalToSuperview().dividedBy(2)
            make.center.equalToSuperview()
        }
        
        webView.snp.makeConstraints { make in
            make.leading.top.bottom.trailing.equalToSuperview()
        }
    }
    
}





// MARK: - WKNavigationDelegate
extension AuthorizationVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        webView.isHidden = true
        connectErrorView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.isHidden = false
        connectErrorView.isHidden = true
        
        guard let url = webView.url?.absoluteString else { return }
        
        
    }
    
}

// MARK: - Оставшиеся задания
/*
 1. Добавить логику авторизации
 2. Обработать ошибку при соединении
 */
