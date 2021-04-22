//
//  DogAPI.swift
//  Randog
//
//  Created by Ion Ceban on 4/22/21.
//

import Foundation
import UIKit

class DogAPI {
    enum Endpoint {
        case randomImageFromAllDogsCollection
        case randomImageForBreed(String)
        case listAllBreeds
        
        var url: URL {
           return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
    }
    
    class func requestBreedsList(completionHandler: @escaping ([String], Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoint.listAllBreeds.url) {
            (data, response, error) in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            let breedsResponse = try! decoder.decode(BreedsListResponse.self, from: data)
            let breeds = breedsResponse.message.keys.map({$0})
            completionHandler(breeds, nil)
        }
        task.resume()
    }
    
    
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let downloadedImage = UIImage(data: data)
        completionHandler(downloadedImage, nil)
        }
        task.resume()
  }
    
    class func requestRandomImage(breed: String,completionHandler: @escaping (dogImage?, Error?) -> Void) {
        let randomImageEndpoint = (DogAPI.Endpoint.randomImageForBreed(breed).url)
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
         guard let data = data else {
             completionHandler(nil, error)
             return
         }
         
         let decoder = JSONDecoder()
         let imageData = try! decoder.decode(dogImage.self, from: data)
         completionHandler(imageData, nil)
    }
        task.resume()
   }
    
}
      
