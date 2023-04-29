//
//  APIManager.swift
//  TestMUp
//
//  Created by Нахид Гаджалиев on 28.04.2023.
//

import Foundation

final class APIManager  {
    
    static let shared = APIManager()
    
    func getImages(completion: @escaping (Result<[ImageModel], Error>) -> Void) {
        
        guard let url = URL(string: Constants.Request.baseURL + Constants.Request.albumURL + "&access_token=\(AuthManager.shared.token ?? "")&v=5.131") else { return }

        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(Constants.APIError.failedGettingData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(APIResponseModel.self, from: data)
                let images: [ImageModel] = result.response.items.compactMap { item -> ImageModel? in
                    
                    return ImageModel (
                        urlString: item.sizes.filter{$0.type.rawValue == "z"}.first?.url ?? "",
                        date: item.date,
                        id: item.id
                    )
                }
                completion(.success(images))
                print("Success")
            }
            catch {
                completion(.failure(error))
                print("failure")
            }
        }
        task.resume()
        
    }
    
}
