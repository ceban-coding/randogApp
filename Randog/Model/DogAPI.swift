//
//  DogAPI.swift
//  Randog
//
//  Created by Ion Ceban on 4/22/21.
//

import Foundation
import UIKit

class DogAPI {
    enum Endpoint: String {
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL {
           return URL(string: self.rawValue)!
        }
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
    
    class func requestRandomImage(completionHandler: @escaping (dogImage?, Error?) -> Void) {
        let randomImageEndpoint = (DogAPI.Endpoint.randomImageFromAllDogsCollection.url)
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
      
