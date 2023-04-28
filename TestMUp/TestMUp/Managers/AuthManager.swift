//
//  AuthManager.swift
//  TestMUp
//
//  Created by Нахид Гаджалиев on 28.04.2023.
//

import Foundation

final class AuthManager {
    
    let defaults = UserDefaults.standard
    static let shared = AuthManager()
    
    var loginURL: URL? {
        return URL(string: "https://oauth.vk.com/authorize?client_id=\(Constants.App.id)&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&scope=photos&revoke=1&response_type=token&v=5.131")
    }
    
    var token: String? {
        return defaults.string(forKey: Constants.Keys.access_token)
    }
    
    var tokenExpDate: Date? {
        return defaults.object(forKey: Constants.Keys.expirationDate) as? Date
    }
    
    var isTokenExpired: Bool {
        guard let expDate = tokenExpDate else { return false }
        let curDate = Date()
        return curDate >= expDate
    }
    
    var isUserLoggedIn: Bool {
        return token != nil
    }
}




// MARK: - ADDING METHODS
extension AuthManager {
    
    func authorization(redirectString: String, completion: @escaping (Bool) -> Void) {
        let redirectStringArray = redirectString.components(separatedBy: "#")
        let data = redirectStringArray[1]
        let dataArray = data.components(separatedBy: "&")
        var token: String?
        var expirationDate: Int?
        
        dataArray.forEach { value in
            let valuePair = value.components(separatedBy: "=")
            
            switch valuePair[0] {
            case "access_token":
                token = valuePair[1]
            case "expires_in":
                expirationDate = Int(valuePair[1])
            default:
                print(valuePair)
            }
        }
        
        guard let token = token, let expDate = expirationDate else {
            completion(false)
            return
        }
        saveToken(with: token, and: expDate)
        completion(true)
    }

    func logOut(completion: @escaping (Bool) -> Void) {
        defaults.set(nil, forKey: Constants.Keys.access_token)
        defaults.setValue(nil, forKey: Constants.Keys.expirationDate)
        
        completion(true)
    }

    private func saveToken(with token: String, and expires_in: Int) {
        defaults.setValue(token, forKey: Constants.Keys.access_token)
        defaults.setValue(Date().addingTimeInterval(TimeInterval(expires_in)), forKey: Constants.Keys.expirationDate)
    }
    
}
