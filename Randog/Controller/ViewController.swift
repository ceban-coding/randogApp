//
//  ViewController.swift
//  Randog
//
//  Created by Ion Ceban on 4/22/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        DogAPI.requestRandomImage { (imageData , error) in
            handleRandomImageResponse(imageData: imageData, error: error)
       
    }
    
    func handleRandomImageResponse(imageData: dogImage?, error: Error?) {
        guard let imageURL = URL(string: imageData?.message ?? "") else {
            return
        }
            
        DogAPI.requestImageFile(url: imageURL) { (image, error) in
            handleImageFileResponse(image: image, error: error)
      }
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
     }

  }
}
