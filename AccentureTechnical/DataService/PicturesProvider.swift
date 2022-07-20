//
//  PicturesProvider.swift
//  AccentureTechnical
//
//  Created by Daniel Marco Rafanan on 7/21/22.
//

import Foundation

protocol PicturesProvider{
    func getPictures(completion:@escaping (Result<[PictureModel], NetworkError>) -> Void)
}

class PicturesDataService:PicturesProvider{
    
    private let urlString = "https://jsonplaceholder.typicode.com/photos"
    
    func getPictures(completion:@escaping (Result<[PictureModel], NetworkError>) -> Void){
        
        guard let url = URL(string: urlString) else{
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                completion(.failure(.unableToFetch))
                return
            }
            
            guard let pictureModels = try? JSONDecoder().decode([PictureModel].self, from: data) else {
                completion(.failure(.unableToParse))
                return
            }
            
            completion(.success(pictureModels))
            
        }.resume()
    }
}

enum NetworkError:Error{
    case badURL
    case unableToFetch
    case unableToParse
}
