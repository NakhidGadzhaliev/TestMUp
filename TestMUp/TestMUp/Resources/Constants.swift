//
//  Constants.swift
//  TestMUp
//
//  Created by Нахид Гаджалиев on 27.04.2023.
//

import UIKit

enum Constants {
    enum Colors {
        static var customBlack = UIColor(named: "customBlack")
        static var customWhite = UIColor(named: "customWhite")
    }
    
    enum Request {
        static let baseURL = "https://api.vk.com/method/"
        static let ownerID = "-128666765"
        static let albumID = "266310117"
        static let albumURL = "photos.get?&owner_id=\(ownerID)&album_id=\(albumID)"
    }
    
    enum App {
        static let id = "51628853"
    }
    
    enum Keys {
        static let access_token = "access_token"
        static let expirationDate = "expirationDate"
    }
    
    enum APIError: Error {
        case failedGettingData
    }
}
